# Windowsセットアップメモ

## 1. 事前準備

### Windows 11 Home／ProをMicrosoftアカウントではなくローカルアカウントで設定する方法
Windows 11のセットアップ時にMicrosoftアカウントを使わずにローカルアカウントで設定する方法を事前に確認しておく。

参考記事:  
[Windows 11 Home／ProをMicrosoftアカウントではなくローカルアカウントで設定する裏技](https://atmarkit.itmedia.co.jp/ait/spv/2210/21/news023.html)

## UI

### 1. 隠しファイル・拡張子の表示

```powershell
# 隠しファイルを表示する
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name Hidden -Value 1
# 拡張子を表示する
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name HideFileExt -Value 0

```

### 2. ダークモードに変更

```powershell
# アプリのテーマをダークモードにする
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name AppsUseLightTheme -Value 0 -Type DWord -Force
# システムのテーマをダークモードにする
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name SystemUsesLightTheme -Value 0 -Type DWord -Force
```

### 3. タスクバーを左寄せに変更する
```powershell
# タスクバーの配置を左寄せに変更
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name TaskbarAl -Value 0 -Type DWord -Force
```

### 4. エクスプローラーを再起動

```powershell
# タスクバーを再起動して適用
Stop-Process -Name explorer -Force
```

## 2. WSLのセットアップ

1. `wsl.exe --install`でWSLをインストール
2. 再起動
3. `wsl.exe --install Ubuntu`でUbuntuをインストール
4. `wsl.exe -d Ubuntu`で接続
5. ユーザー名やパスワードの設定を設定

Ubuntu内の処理について同一階層の`ubuntu.bash`を参照

## 3. Windows Software

```bash
# Vivaldi
winget install --id=Vivaldi.Vivaldi -e
# Discord
winget install --id=Discord.Discord -e
# Steam
winget install --id=Valve.Steam -e
# Spotify
winget install --id=Spotify.Spotify -e
# ChatGPT
winget install --id=9NT1R1C2HH7J -e
# Google Chrome
winget install --id=Google.Chrome -e
# Cursor(Text Editor)
winget install --id=Anysphere.Cursor -e
# PowerToys
winget install --id=Microsoft.PowerToys -e
# 1Password
winget install --id=AgileBits.1Password -e
# 7zip
winget install --id=7zip.7zip -e
# Notion
winget install --id=Notion.Notion -e
# Epic Games Launcher
winget install -e --id EpicGames.EpicGamesLauncher
# OBS Studio
winget install -e --id OBSProject.OBSStudio
```