; Filename: basecamp_return_macro.ahk
; Description: Numpad3を押すと、ベースキャンプに戻るためのキーシーケンスを自動入力するスクリプト
; Usage: ゲーム中にNumpad3を押すと、ベースキャンプに戻るためのキー入力が自動で実行される

#Requires AutoHotkey v2.0  ; AutoHotkey v2.0が必要
#SingleInstance Force     ; スクリプトの多重起動を防ぐ
#MaxThreadsPerHotkey 1    ; 同じホットキーの多重実行を防ぐ
SetWorkingDir A_ScriptDir ; スクリプトの作業ディレクトリをスクリプトのあるフォルダに固定
ProcessSetPriority "High" ; スクリプトの実行優先度を高く設定

; キー入力の設定
HOLD_TIME := 150    ; キーを押し続ける時間（ミリ秒）
DELAY_TIME := 50    ; キー入力間の待機時間（ミリ秒）

; キー入力を実行する関数
pressKey(key, delay := DELAY_TIME) {
    SendEvent("{" key " down}")
    Sleep(HOLD_TIME)
    SendEvent("{" key " up}")
    Sleep(delay)
}

; ベースキャンプ帰還マクロ
Numpad3::{
    pressKey("F2", 100)  ; メニューを開く
    pressKey("7", 200)   ; ベースキャンプ選択
    pressKey("a")        ; 決定
    pressKey("f")        ; 確認
    pressKey("f")        ; 確認
}
