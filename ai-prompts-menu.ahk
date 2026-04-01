; AI Prompts Menu for Windows
; AutoHotkey v2 script
; Triggered by Ctrl+Shift+M
; Reads prompts from shared prompts.json
;
; Requirements: AutoHotkey v2 (https://www.autohotkey.com/)
; Install: place this script (and prompts.json) anywhere, double-click to run
; or add to shell:startup for auto-launch

#Requires AutoHotkey v2.0
#SingleInstance Force

; --- Configuration ---
; prompts.json must be in the same directory as this script
PromptsFile := A_ScriptDir "\prompts.json"

; --- Hotkey: Ctrl+Shift+M ---
^+m:: {
    global PromptsFile

    if !FileExist(PromptsFile) {
        MsgBox("prompts.json not found in " A_ScriptDir, "AI Prompts", "Icon!")
        return
    }

    ; Read and parse JSON
    jsonText := FileRead(PromptsFile, "UTF-8")
    prompts := ParsePrompts(jsonText)

    if prompts.Length = 0 {
        MsgBox("No prompts found in prompts.json", "AI Prompts", "Icon!")
        return
    }

    ; Build menu
    promptMenu := Menu()
    for item in prompts {
        label := item["label"]
        text := item["text"]
        promptMenu.Add(label, SendPrompt.Bind(text))
    }

    ; Show menu at cursor
    promptMenu.Show()
}

; --- Send the selected prompt text ---
SendPrompt(text, itemName, itemPos, menu) {
    ; Small delay to let the menu close
    Sleep(100)
    ; Save clipboard, use it to paste (faster and more reliable than SendInput for long text)
    savedClip := A_Clipboard
    A_Clipboard := text
    ClipWait(2)
    Send("^v")
    ; Restore clipboard after a brief delay
    SetTimer(() => (A_Clipboard := savedClip), -500)
}

; --- Minimal JSON array parser for prompts.json ---
; Handles the specific structure: array of {label, text} objects
ParsePrompts(jsonText) {
    results := []
    ; Remove leading/trailing whitespace and the outer array brackets
    jsonText := Trim(jsonText)
    if SubStr(jsonText, 1, 1) != "["
        return results

    ; State machine parser
    pos := 2  ; skip opening [
    len := StrLen(jsonText)

    while pos <= len {
        ; Find next opening brace
        braceStart := InStr(jsonText, "{",, pos)
        if !braceStart
            break

        ; Find matching closing brace
        braceEnd := InStr(jsonText, "}",, braceStart)
        if !braceEnd
            break

        objText := SubStr(jsonText, braceStart + 1, braceEnd - braceStart - 1)

        label := ExtractJsonValue(objText, "label")
        text := ExtractJsonValue(objText, "text")

        if label != "" {
            item := Map()
            item["label"] := label
            item["text"] := text
            results.Push(item)
        }

        pos := braceEnd + 1
    }

    return results
}

ExtractJsonValue(objText, key) {
    ; Find "key": "value" pattern
    needle := '"' key '"'
    keyPos := InStr(objText, needle)
    if !keyPos
        return ""

    ; Find the colon after the key
    colonPos := InStr(objText, ":",, keyPos + StrLen(needle))
    if !colonPos
        return ""

    ; Find the opening quote of the value
    quoteStart := InStr(objText, '"',, colonPos + 1)
    if !quoteStart
        return ""

    ; Find the closing quote, handling escaped quotes
    pos := quoteStart + 1
    value := ""
    while pos <= StrLen(objText) {
        ch := SubStr(objText, pos, 1)
        if ch = "\" {
            nextCh := SubStr(objText, pos + 1, 1)
            if nextCh = '"'
                value .= '"'
            else if nextCh = "\"
                value .= "\"
            else if nextCh = "n"
                value .= "`n"
            else if nextCh = "t"
                value .= "`t"
            else
                value .= nextCh
            pos += 2
        } else if ch = '"' {
            break
        } else {
            value .= ch
            pos += 1
        }
    }

    return value
}
