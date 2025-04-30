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

### 4. 「「この写真に関する詳細情報」を消す
```powershell
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{2cc5ca98-6485-489a-920e-b3e88a6ccce3}" /t REG_DWORD /d 1 /f
```
参考: [【Windows】ロック画面のトリビアやヒント、画像情報を消す方法 | 50歳からでもよくわかるガジェットの話]<https://50it.jeez.jp/archives/1585>

### 5. エクスプローラーを再起動
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
### 管理者権限で実行
```powershell
# Vivaldi
winget install -e --id=Vivaldi.Vivaldi
# Discord
winget install -e --id=Discord.Discord
# Steam
winget install -e --id=Valve.Steam
# DeepL
winget install -e --id DeepL.DeepL
# ChatGPT
winget install -e --id=9NT1R1C2HH7J
# Anthropic Claude
winget install -e --id=Anthropic.Claude
# Google Chrome
winget install -e --id=Google.Chrome
# Cursor(Text Editor)
winget install -e --id=Anysphere.Cursor
# PowerToys
winget install -e --id=Microsoft.PowerToys
# 1Password
winget install -e --id=AgileBits.1Password
# 7zip
winget install -e --id=7zip.7zip
# Notion
winget install -e --id=Notion.Notion
# Epic Games Launcher
winget install -e --id EpicGames.EpicGamesLauncher
# OBS Studio
winget install -e --id OBSProject.OBSStudio
# AutoHotkey
winget install -e --id=AutoHotkey.AutoHotkey
# Git
winget install -e --id Git.Git
# GitHub CLI
winget install -e --id GitHub.cli
# nvm
winget install -e --id CoreyButler.NVMforWindows
# Meta Quest Link
winget install -e --id=Meta.Oculus
# Snipping Tool
winget install -e --id=9MZ95KL8MR0L
# Gimp
winget install -e --id 9PNSJCLXDZ0V
# Paint
winget install -e --id 9PCFS5B6T72H
# LINE Desktop
winget install -e --id XPFCC4CD725961
# Docker CLI
winget install -e --id=Docker.DockerCLI
# LiveSplit
winget install -e --id=LiveSplit.LiveSplit
# VScode
winget install -e --id=Microsoft.VisualStudioCode
# LM Studio
winget install -e --id=ElementLabs.LMStudio
```

### 管理者権限ナシで実行
```powershell
# Spotify
winget install -e --id=Spotify.Spotify
```

## メモ
### タスクバーの並び
左から
1. Terminal
2. Explorer
3. Browser
4. Text Editor
5. Message App
になるようにする。
