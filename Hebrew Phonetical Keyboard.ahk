; The Hebrew Phonetical Keyboard Everyone's Been Waiting For!
; A special thank you to Hashem for helping me come up with this script!
;
; Copyright © 2025 Moshe Balgley
; Licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.
; You may copy, modify, and share this file for non-commercial purposes,
; provided you give appropriate credit and indicate any changes made.
; https://creativecommons.org/licenses/by-nc-sa/4.0/
;
; This AutoHotkey v2.0 script lets you type Hebrew letters phonetically (the way they sound), also with special
; diacritics (vowel marks), and special characters. It is enabled only while Caps Lock is ON.
;
; Motivation:
; -   I was fed up with the current state of typing Hebrew on a computer. Gboard is great for typing Hebrew on Android,
;     but I wanted a similar, if not better, experience on Windows. I wanted to be able to freely type based on
;     phonetical sound, and also use Rafe, Meteg, and other characters. I believe you should be able to type a Gimel using G;
;     or a Lamed with L; etc, using as little 3rd party software (ie: DavkaWriter) as possible, & not being dependent
;     on internet for Google Docs, Google Translate, etc, or having to pay anything at all. It should be 100% free and easy!
;     Apologies for the long code, I used AI to make it as simplified and optimized as it can be.
;     If you can do a better job, then by all means!
;
; ###################################################################################
; ###                            HOW TO USE THIS SCRIPT                           ###
; ###################################################################################
;
; 0.  Download and install AutoHotKey v2. Download and run this script. The full source code is ALL HERE.
;     There are no binaries to trust, hidden surprises, or viruses — everything is open, transparent and verifiable.
;
; 1.  **ACTIVATION**: This script is ONLY active when **Caps Lock is ON**. Turn Caps
;     Lock OFF to return to normal typing.
;
; 2.  **AUTOMATIC FINAL FORMS (SOFIT)**:
;     -   Letters that have a final form (כ, מ, נ, פ, צ) will automatically change to
;         their sofit form (ך, ם, ן, ף, ץ) when you type a word-ending character
;         (like Space, Period, Comma, etc.).
;     -   **IMPORTANT**: This only happens for words with TWO OR MORE letters.
;         Single-letter words will not be changed. And only within 3 seconds of typing.
;     -   Example: Type `m-l-k` followed by `Space` -> `מלך `.
;       Type `s-l-v-m` followed by `Space` -> `שלום `.
;
; 3.  **LETTER COMBINATIONS (COMBOS)**: Some Hebrew letters are formed by typing two
;     keys in a row.
;     -   Example: `t` followed by `s` or `z` becomes `צ`.
;     -   Example: `c` followed by `h` becomes `ח`.
;     -   Example: `s` followed by `h` becomes `שׁ` (Shin).
;
; 4.  **DOUBLE-PRESS KEYS**: Pressing the same key twice quickly can produce an
;     alternate letter.
;     -   Example: `a` -> `א` | `aa` (quickly) -> `ע`
;     -   Example: `s` -> `ש` | `ss` (quickly) -> `ס`
;
; 5.  **MANUAL OVERRIDES**: You can always type a final-form letter manually by
;     holding `Shift`.
;     -   Example: `Shift + m` will instantly type `ם`.
;
; --- KEY MAPPING REFERENCE ---
;
; -----------------------------------------------------------------------------------------------------------------------------
; Character (Name)        | Phonetic Key(s)                       | Notes / How to Type
; -----------------------------------------------------------------------------------------------------------------------------
; --- CONSONANTS ---
; Alef (א)                | `a`                                   | Type `a` once. For Ayin, type `a` twice.
; Bet with Dagesh (בּ)     | `Shift + b`                           |
; Bet (ב)                 | `b`                                   |
; Gimmel (ג)              | `g`                                   |
; Dalet (ד)               | `d`                                   |
; Heh (ה)                 | `h`                                   |
; Vav (ו)                 | `v`                                   |
; Zayin (ז)               | `z`                                   |
; Chet (ח)                | `Shift + h` or `ch`                   |
; Tet (ט)                 | `Shift + t`                           |
; Yod (י)                 | `i`, `j`, or `y`                      |
; Kaf (כ)                 | `c` or `k`                            | Becomes `ך` automatically. Manual: `Shift + c`/`Shift + k`.
; Lamed (ל)               | `l`                                   |
; Alef Lamed Ligature (ﭏ) | `Shift + l`                           |
; Mem (מ)                 | `m`                                   | Becomes `ם` automatically. Manual: `Shift + m`.
; Nun (נ)                 | `n`                                   | Becomes `ן` automatically. Manual: `Shift + n`.
; Nun Hafukha (׆)         | `Shift + nn`                          | "Backwards Nun"
; Samech (ס)              | `ss` (type `s` twice quickly)         | `s` once is Shin.
; Ayin (ע)                | `aa` (type `a` twice quickly)         | `a` once is Alef.
; Pe (פ)                  | `p` or `f`                            | Becomes `ף` automatically. Manual: `Shift + f`.
; Tsadi (צ)               | `x`, or `ts` or `tz`                  | Becomes `ץ` automatically. Manual: `Shift + x`/`Shift + z`.
; Qof (ק)                 | `q`                                   |
; Resh (ר)                | `r`                                   |
; Shin (ש)                | `s`                                   | Type `s` once. For Samech, type `ss`.
; Shin with Shin Dot (שׁ)  | `Shift + s` or `sh`                   |
; Shin with Sin Dot (שׂ)   | `Alt + s`                             |
; Tav (ת)                 | `t`                                   |
; -----------------------------------------------------------------------------------------------------------------------------
; --- VOWELS (NIKKUD) & VOWEL-LETTERS ---
; Kamatz (ָ)               | `Shift + q` (once)                    |
; Patach (ַ)               | `Shift + p` (once)                    |
; Tzeirei (ֵ)              | `Shift + a`                           |
; Segol (ֶ)                | `e` (once)                            |
; Shva (ְ)                 | `:` (colon)                           |
; Vav with Holam (וֹ)      | `o`                                   |
; Holam Haser (ֹ)          | `Shift + o`                           |
; Chirik (ִ)               | `Shift + e`, `Shift + i`, `Shift + y` |
; Qubutz (ֻ)               | `Shift + u`                           |
; Vav with Shuruk (וּ)     | `u` or `Shift + v`                    |
; Hataf Kamatz (ֳ)         | `Shift + qq`                          |
; Hataf Patach (ֲ)         | `Shift + pp`                          |
; Hataf Segol (ֱ)          | `ee` (type `e` twice quickly)         |
; -----------------------------------------------------------------------------------------------------------------------------
; --- PUNCTUATION & SPECIAL MARKS ---
; Dagesh or Shuruk Dot (ּ) | `Shift + d`                           |
; Meteg (ֽ)                | `|` (pipe character)                  |
; Maqaf (־)               | `-` (hyphen)                          | 
; Rafe (ֿ)                 | `Shift + r`                           |
; Paseq (׀)               | `\` (backslash)                       |
; Geresh (׳)              | `'` (apostrophe)                      |
; Gershayim (״)           | `"` (quote)                           |
; -----------------------------------------------------------------------------------------------------------------------------
;
; The correct order when typing in Hebrew:
; 1) Base Letter — e.g., א, ב, ש
; 2) Dagesh or Mapiq (U+05BC) — central dot
; 3) Shin/Sin Dot (U+05C1 for Shin dot, U+05C2 for Sin dot)
; 4) Vowel (Niqqud) — e.g., Patach, Kamatz, Hirik, etc.
; 5) Meteg (U+05BD) — vertical line below
; 6) Rafe (U+05BF) — short horizontal line above

#Requires AutoHotkey v2.0
SetTitleMatchMode(2)
SendMode("Input")

; --- Global State & Configuration ---
global comboKey := "", comboTime := 0
global doublePressKey := "", doublePressTime := 0
global sofitCandidate := "", sofitCandidateTime := 0
global wordLengthCounter := 0
global sofitMap := Map("כ", "ך", "מ", "ם", "נ", "ן", "פ", "ף", "צ", "ץ")
global sofitTimeout := 3000 ; in milliseconds how long to wait for changing a letter to its sofit form
global comboTimeout := 300 ; in milliseconds how long to wait for a double-press or 2-letter combo activation

; ======================================================================================================================
; === HELPER FUNCTIONS
; ======================================================================================================================

; Resets all state variables tracking combos, double-presses, and sofit candidates to empty.
ResetState() {
    global comboKey, doublePressKey, sofitCandidate
    comboKey := "", doublePressKey := "", sofitCandidate := ""
}

; Sends a character to the active window. Resets combo/double-press state. If the character is a letter,
; increments the word length counter.
SendChar(char, isLetter := true) {
    global wordLengthCounter
    ResetState()
    Send(char)
    if isLetter
        wordLengthCounter++
}

; Sends a character and marks it as a “sofit candidate” (a letter eligible to become its final form at word end).
; Also records the current time for the timeout check and increments word length.
SetSofitCandidate(char) {
    global sofitCandidate, sofitCandidateTime, wordLengthCounter
    ResetState()
    Send(char)
    sofitCandidate := char, sofitCandidateTime := A_TickCount
    wordLengthCounter++
}

; Sends a character (marking it as a sofit candidate) while also marking the key as starting a combo sequence and storing the time.
SetSofitAndCombo(key, char) {
    SetSofitCandidate(char)
    global comboKey, comboTime
    comboKey := key, comboTime := A_TickCount
}

; Detects whether a key was pressed twice rapidly. If so, deletes the first character and sends the alternate character.
; If not, sends the normal character and records the time/key for the next press.
HandleDoublePress(thisKey, singleSend, doubleSend, isLetter := true) {
    global doublePressKey, doublePressTime
    if (doublePressKey = thisKey && (A_TickCount - doublePressTime) < comboTimeout) {
        Send("{BS}" doubleSend)
        ResetState()
        return true
    }
    SendChar(singleSend, isLetter)
    doublePressKey := thisKey, doublePressTime := A_TickCount
    return false
}

; Checks whether a sofit candidate was typed recently and if the word has at least two letters.
; If so, replaces the last letter with its final-form variant. Then sends the trigger character
; (e.g., space or punctuation), resets state, and resets word length.
CheckAndApplySofit(triggerChar, *) {
    global sofitCandidate, sofitCandidateTime, sofitTimeout, sofitMap, wordLengthCounter
    if (sofitCandidate != "" && A_TickCount - sofitCandidateTime < sofitTimeout && wordLengthCounter > 1 && sofitMap.Has(sofitCandidate)) {
        Send("{BS}" sofitMap[sofitCandidate])
    }
    Send(triggerChar)
    ResetState()
    wordLengthCounter := 0
}

; Clears all tracking state and resets the word length counter if an unrecognized key is pressed
; and enough time has elapsed since the previous hotkey.
ResetOnUnhandledKey() {
    if (A_TimeSincePriorHotkey < 50)
        return
    global wordLengthCounter
    ResetState()
    wordLengthCounter := 0
}

; ======================================================================================================================
; === HOTKEYS (Only active when Caps Lock is ON)
; ======================================================================================================================
#HotIf GetKeyState("CapsLock", "T")

; --- Simple Letters & Characters ---
g::SendChar("ג")
d::SendChar("ד")
v::SendChar("ו")
l::SendChar("ל")
q::SendChar("ק")
r::SendChar("ר")
b::SendChar("ב")
+b::SendChar("בּ")
+t::SendChar("ט")
+l::SendChar("ﭏ")
'::SendChar("׳")
"::SendChar("״")
i::
j::
y::SendChar("י")

; --- Vowels (Nikkud) & Diacritics (do not count as letters) ---
+e::
+i::
+y::SendChar("ִ", false)
+a::SendChar("ֵ", false)
+;::SendChar("ְ", false)
+o::SendChar("ֹ", false)
+u::SendChar("ֻ", false)
+d::SendChar("ּ", false)
|::SendChar("ֽ", false)
+r::SendChar("ֿ", false)
\::SendChar("׀", false)

; --- Letter-Vowel combinations (count as letters) ---
o::SendChar("וֹ")
u::
+v::SendChar("וּ")

; --- Sofit-capable letters ---
k::SetSofitCandidate("כ")
m::SetSofitCandidate("מ")
n::SetSofitCandidate("נ")
f::
p::SetSofitCandidate("פ")
x::SetSofitCandidate("צ")

; --- Keys that can start a combo sequence ---
t::SetSofitAndCombo("t", "ת")
c::SetSofitAndCombo("c", "כ")

; --- Keys that can complete a combo sequence ---
h::{
    global comboKey, comboTime
    if ((comboKey = "c" || comboKey = "s") && A_TickCount - comboTime < comboTimeout) {
        Send("{BS}" (comboKey = "c" ? "ח" : "שׁ"))
        ResetState()
    } else {
        SendChar("ה")
    }
}
z::{
    global comboKey, comboTime
    if (comboKey = "t" && A_TickCount - comboTime < comboTimeout) {
        Send("{BS}")
        SetSofitCandidate("צ")
    } else {
        SendChar("ז")
    }
}
s::{
    global comboKey, comboTime
    if (comboKey = "t" && A_TickCount - comboTime < comboTimeout) {
        Send("{BS}")
        SetSofitCandidate("צ")
    } else if !HandleDoublePress("s", "ש", "ס") {
        comboKey := "s", comboTime := A_TickCount
    }
}

; --- Manual Sofit Overrides & Special Shifted Letters ---
+c::
+k::SendChar("ך")
+m::SendChar("ם")
+f::SendChar("ף")
+x::
+z::SendChar("ץ")
+h::SendChar("ח")
+s::SendChar("שׁ")
!s::SendChar("שׂ")

; --- Double-press letters ---
a::HandleDoublePress("a", "א", "ע")
e::HandleDoublePress("e", "ֶ", "ֱ", false)
+n::HandleDoublePress("sh-n", "ן", "׆")
+q::HandleDoublePress("sh-q", "ָ", "ֳ", false)
+p::HandleDoublePress("sh-p", "ַ", "ֲ", false)

; --- Sofit Triggers (Word Enders) ---
; The `$` prefix prevents the Send() command inside the function from re-triggering the hotkey.
$Space::CheckAndApplySofit(" ")
$,::CheckAndApplySofit(",")
$.::CheckAndApplySofit(".")
$-::CheckAndApplySofit("־")
$+/::CheckAndApplySofit("?")
$+9::CheckAndApplySofit("(")
$+0::CheckAndApplySofit(")")
$[::CheckAndApplySofit("[")
$]::CheckAndApplySofit("]")
$+<::CheckAndApplySofit("<")
$+>::CheckAndApplySofit(">")

; --- Catch-all to reset state on unhandled keys ---
~*::ResetOnUnhandledKey()

#HotIf ; Reset the context
