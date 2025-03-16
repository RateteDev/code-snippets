; Filename: quest_accept.ahk
; Description: ゲーム内でクエストを自動受注するスクリプト
; Usage: Numpad3を押すと、F1 -> 7 -> F -> A -> S -> F の順でキー入力し、クエストを受注

#Requires AutoHotkey v2.0  ; AutoHotkey v2.0が必要
#SingleInstance Force     ; スクリプトの多重起動を防ぐ
#MaxThreadsPerHotkey 1    ; 同じホットキーの多重実行を防ぐ
SetWorkingDir A_ScriptDir ; スクリプトの作業ディレクトリをスクリプトのあるフォルダに固定
ProcessSetPriority "High" ; スクリプトの実行優先度を高く設定

HOLD_TIME := 150
DELAY_TIME := 300  ; 初期ディレイを長めに設定

pressKey(key, delay := DELAY_TIME) {
    SendEvent("{" key " down}")
    Sleep(HOLD_TIME)
    SendEvent("{" key " up}")
    Sleep(delay)
}

Numpad3::{
    pressKey("F1")
    pressKey("7")
    pressKey("f")
    pressKey("a")
    pressKey("s")
    pressKey("f")
}
