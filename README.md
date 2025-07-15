# Hebrew-Phonetical-Keyboard
This is a Hebrew Phonetical Keyboard script written for AutoHotKey 2.0.

## What is this?
This is a free tool that lets you type Hebrew based on how the letters sound. You don't have to hunt for the letters anymore!

## ⚙️ How to Install
There are two ways to get this working. The first option is the easiest and is recommended for most users.

### Option 1: The Easy Way (Recommended)
This method gives you a ready-to-use program. No extra software is needed.

1.  **[Click here to go to the download page.](https://github.com/Sliicy/Hebrew-Phonetical-Keyboard/releases/latest)**
2.  On that page, find the file named `Hebrew-Phonetical-Keyboard.exe` and click on it to download it (or use the 32 bit version if your computer is an older, 32-bit machine).
3.  Find the file in your computer's "Downloads" folder and double-click it to run it.

That's it! A small icon (a white globe on a blue circle) will appear in the bottom-right corner of your screen to show that the program is running.
![image](https://github.com/user-attachments/assets/895f05e1-5a6c-4bb5-9297-a7b1ad473270)


### Option 2: Using the AutoHotkey Script
This method is for advanced users who are more comfortable with computers and want to see the code, or who may already use the AutoHotkey program.

1.  **Install AutoHotkey:** If you don't have it, download and install the free helper program called **AutoHotkey v2** from [their official website](https://www.autohotkey.com/). This program is what runs the script.
2.  **Download the Script:** Download the script file named `Hebrew-Phonetical-Keyboard.ahk` from this repository's main page.
3.  **Run the Script:** Once AutoHotkey is installed, just find the `.ahk` file you downloaded and double-click it.

Afterwards, you will see a small "H" icon appear in the bottom-right of your screen.

---

## 🟢 Activation
This script is **ONLY active when Caps Lock is ON**.  
Turn Caps Lock OFF to return to normal typing.

It does not run when the computer starts up, but this can be turned on by creating a shortcut to the downloaded program within:

`%AppData%\Microsoft\Windows\Start Menu\Programs\Startup\`

<img width="629" height="151" alt="image" src="https://github.com/user-attachments/assets/3ae6debe-c837-43a2-8c0e-be13a0dd028a" />


---

## ✨ Automatic Final Forms (Sofit)

- Letters that have a final form (כ, מ, נ, פ, צ) will automatically change to their sofit form (ך, ם, ן, ף, ץ) when you type a word-ending character (e.g., Space, Period, Comma).
- **Important:**  
  - Only affects words with **two or more letters**.
  - Only within **3 seconds** of typing.

---

## 🔀 Letter Combinations (Combos)

Some Hebrew letters can also be formed by typing **two keys in a row**:

| Combination | Result |
|-------------|--------|
| `t` + `s`        | צ |
| `t` + `z`        | צ |
| `c` + `h`        | ח |
| `s` + `h`        | שׁ (Shin) |

---

## 🄳 Double-Press Keys

Pressing the **same key twice quickly** can produce alternate letters:

| Key   | Single Press | Double Press |
|-------|--------------|--------------|
| `a`   | א            | ע            |
| `s`   | ש            | ס            |

---

## ✋ Manual Overrides

Hold `Shift` to manually type final-form letters:

- Example: `Shift + m` ➜ ם

---

## 🚀 Quick Translation

This script includes a powerful shortcut to quickly translate selected text using ChatGPT.

To use it, **press the letter `t` three times in a row (`ttt`) quickly**. This works **only when Caps Lock is off**.

Here's what it does automatically:
1.  Copies any text you have currently highlighted (`Ctrl` + `C`).
2.  Opens a new tab in your browser (`Ctrl` + `T`).
3.  Navigates to `https://chatgpt.com/?temporary-chat=true`.
4.  Waits 3 seconds for the page to load.
5.  Types the prompt: `translate to english: `
6.  Pastes your copied text (`Ctrl` + `V`).
7.  Presses `Enter` to submit the translation.

**How to Use:**
1. Highlight any text you want to translate (e.g., a Hebrew word like `שלום`).
2. Quickly press `ttt`.
3. The script will handle the rest!

---

## 🗝️ Key Mapping Reference

Below is the complete reference table.

---

### 🔤 Consonants

| Character (Name)            | Phonetic Key(s)                           | Notes / How to Type                                 |
|-----------------------------|-------------------------------------------|-----------------------------------------------------|
| **Alef (א)**                | `a`                                       | Single press. For Ayin, type `a` twice.             |
| **Bet with Dagesh (בּ)**     | `Shift + b`                               |                                                     |
| **Bet (ב)**                 | `b`                                       |                                                     |
| **Gimmel (ג)**              | `g`                                       |                                                     |
| **Dalet (ד)**               | `d`                                       |                                                     |
| **Heh (ה)**                 | `h`                                       |                                                     |
| **Vav (ו)**                 | `v`                                       |                                                     |
| **Zayin (ז)**               | `z`                                       |                                                     |
| **Chet (ח)**                | `Shift + h` or `ch`                       |                                                     |
| **Tet (ט)**                 | `Shift + t`                               |                                                     |
| **Yod (י)**                 | `i`, `j`, or `y`                          |                                                     |
| **Kaf (כ)**                 | `c` or `k`                                | Auto-sofit. Manual: `Shift + c` / `Shift + k`.      |
| **Lamed (ל)**               | `l`                                       |                                                     |
| **Alef Lamed Ligature (ﭏ)** | `Shift + l`                               |                                                     |
| **Mem (מ)**                 | `m`                                       | Auto-sofit. Manual: `Shift + m`.                    |
| **Nun (נ)**                 | `n`                                       | Auto-sofit. Manual: `Shift + n`.                    |
| **Nun Hafukha (׆)**         | `Shift + nn`                              | "Backwards Nun"                                     |
| **Samech (ס)**              | `ss`                                      | `s` once is Shin.                                   |
| **Ayin (ע)**                | `aa`                                      | `a` once is Alef.                                   |
| **Pe (פ)**                  | `p` or `f`                                | Auto-sofit. Manual: `Shift + f`.                    |
| **Tsadi (צ)**               | `x`, or `ts` or `tz`                      | Auto-sofit. Manual: `Shift + x` / `Shift + z`.      |
| **Qof (ק)**                 | `q`                                       |                                                     |
| **Resh (ר)**                | `r`                                       |                                                     |
| **Shin (ש)**                | `s`                                       |                                                     |
| **Shin with Shin Dot (שׁ)**  | `Shift + s` or `sh`                       |                                                     |
| **Shin with Sin Dot (שׂ)**   | `Alt + s`                                 |                                                     |
| **Tav (ת)**                 | `t`                                       |                                                     |

---

### 🌿 Vowels (Nikkud) & Vowel Letters

| Character (Name)           | Phonetic Key(s)                           |
|----------------------------|-------------------------------------------|
| **Kamatz (ָ)**              | `Shift + q`                               |
| **Patach (ַ)**              | `Shift + p`                               |
| **Tzeirei (ֵ)**             | `Shift + a`                               |
| **Segol (ֶ)**               | `e`                                       |
| **Shva (ְ)**                | `:` (colon)                               |
| **Vav with Holam (וֹ)**     | `o`                                       |
| **Holam Haser (ֹ)**         | `Shift + o`                               |
| **Chirik (ִ)**              | `Shift + e`, `Shift + i`, `Shift + y`     |
| **Qubutz (ֻ)**              | `Shift + u`                               |
| **Vav with Shuruk (וּ)**    | `u` or `Shift + v`                        |
| **Hataf Kamatz (ֳ)**        | `Shift + qq`                              |
| **Hataf Patach (ֲ)**        | `Shift + pp`                              |
| **Hataf Segol (ֱ)**         | `ee` (double press)                       |

---

### ✨ Punctuation & Special Marks

| Character (Name)            | Phonetic Key(s)                           |
|-----------------------------|-------------------------------------------|
| **Dagesh or Shuruk Dot (ּ)** | `Shift + d`                               |
| **Meteg (ֽ)**                | `\|` (pipe character)                     |
| **Maqaf (־)**               | `-` (hyphen)                              |
| **Rafe (ֿ)**                 | `Shift + r`                               |
| **Paseq (׀)**               | `\` (backslash)                           |
| **Geresh (׳)**              | `'` (apostrophe)                          |
| **Gershayim (״)**           | `"` (quote)                               |

---
