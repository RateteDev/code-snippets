# ログ出力用の関数
function Write-Log {
    param (
        [Parameter(Mandatory=$true)]
        [string]$Message,

        [Parameter(Mandatory=$false)]
        [ValidateSet("INFO", "SUCCESS", "WARNING", "ERROR")]
        [string]$Level = "INFO",

        [Parameter(Mandatory=$false)]
        [ConsoleColor]$ForegroundColor
    )

    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logPrefix = switch ($Level) {
        "INFO"    { "[INFO]   " }
        "SUCCESS" { "[SUCCESS]" }
        "WARNING" { "[WARNING]" }
        "ERROR"   { "[ERROR]  " }
    }

    $logMessage = "$timestamp $logPrefix $Message"

    if ($ForegroundColor) {
        Write-Host $logMessage -ForegroundColor $ForegroundColor
    } else {
        $color = switch ($Level) {
            "INFO"    { [ConsoleColor]::Cyan }     # 水色
            "SUCCESS" { [ConsoleColor]::Green }    # 緑色
            "WARNING" { [ConsoleColor]::Yellow }   # 黄色
            "ERROR"   { [ConsoleColor]::Red }      # 赤色
        }
        Write-Host $logMessage -ForegroundColor $color
    }
}

# 管理者権限チェック
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Log -Level ERROR -Message "このスクリプトは管理者権限で実行する必要があります。"
    Write-Log -Level WARNING -Message "PowerShellを管理者として実行し、再度スクリプトを実行してください。"
    exit 1
}

Write-Log -Level INFO -Message "Ollama用ポート転送設定を開始します..."

# WSLが実行されているか確認
try {
    $wslStatus = wsl.exe --status 2>&1
    if ($LASTEXITCODE -ne 0) {
        Write-Log -Level ERROR -Message "WSLが実行されていないようです。WSLを起動してから再度試してください。"
        exit 1
    }
} catch {
    Write-Log -Level ERROR -Message "WSLの状態を確認できませんでした。WSLがインストールされているか確認してください。"
    exit 1
}

# 最新のWSLのIPアドレスを取得（複数のインターフェース名に対応）
$wslIp = $null
$interfaces = @("eth0", "wlan0", "wifi0")

foreach ($interface in $interfaces) {
    $ip = wsl.exe ip -4 addr show $interface 2>$null | Select-String -Pattern "inet (\d+\.\d+\.\d+\.\d+)" | ForEach-Object { $_.Matches.Groups[1].Value }
    if ($ip) {
        $wslIp = $ip
        Write-Log -Level SUCCESS -Message "WSLのIPアドレスを取得しました（$interface）: $wslIp"
        break
    }
}

# IPアドレスが見つからない場合は別の方法を試す
if (-not $wslIp) {
    Write-Log -Level INFO -Message "別の方法でIPアドレスを取得します..."
    $wslIp = wsl.exe hostname -I | ForEach-Object { $_.Trim().Split(" ")[0] }
}

if (-not $wslIp) {
    Write-Log -Level ERROR -Message "WSLのIPアドレスを取得できませんでした。"
    exit 1
}

# 既存のポート転送設定を削除
Write-Log -Level INFO -Message "既存のポート転送を削除中..."
netsh interface portproxy delete v4tov4 listenaddress=0.0.0.0 listenport=11434 2>$null

# 新しいポート転送を追加
Write-Log -Level INFO -Message "ポート転送を設定中..."
netsh interface portproxy add v4tov4 listenaddress=0.0.0.0 listenport=11434 connectaddress=$wslIp connectport=11434

Write-Log -Level SUCCESS -Message "ポート転送完了！WindowsからWSLのOllama APIにアクセスできます！"

# Ollamaの動作確認を実行
Write-Log -Level INFO -Message "Ollamaの動作確認を行います...('http://localhost:11434'にリクエストを送信)"
try {
    $response = Invoke-RestMethod -Uri "http://localhost:11434" -Method Get -ErrorAction Stop
    Write-Log -Level SUCCESS -Message "Ollamaは正常に動作しています！"
} catch {
    Write-Log -Level WARNING -Message "Ollamaに接続できませんでした。WSL内でOllamaが起動しているか確認してください。"
    Write-Log -Level INFO -Message "エラー: $_"
}

# Ollamaのバージョンを確認して通知
try {
    $versionResponse = Invoke-RestMethod -Uri 'http://localhost:11434/api/version' -Method Get -ErrorAction Stop
    Write-Log -Level INFO -Message "Ollamaのバージョン: $($versionResponse.version)"
} catch {
    Write-Log -Level WARNING -Message "Ollamaのバージョンを確認できませんでした。"
    Write-Log -Level INFO -Message "エラー: $_"
}
