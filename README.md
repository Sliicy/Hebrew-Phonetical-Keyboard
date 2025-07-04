# Hebrew-Phonetical-Keyboard
Hebrew Phonetical Keyboard generated from AutoHotKey 2.0

For those who can't or don't want to install AutoHotKey, you can [download the binaries from here](https://github.com/Sliicy/Hebrew-Phonetical-Keyboard/releases/tag/v1) to be able to type phonetically in Hebrew on Windows.

Link to original Gist with full source code: https://gist.github.com/Sliicy/61586f6a32e25e322b92a0c8855d7fb8

# Hebrew Typing Script Guide

This document describes how to use the Hebrew typing script.

---

## 🟢 Activation
This script is **ONLY active when Caps Lock is ON**.  
Turn Caps Lock OFF to return to normal typing.

---

## ✨ Automatic Final Forms (Sofit)

- Letters that have a final form (כ, מ, נ, פ, צ) will automatically change to their sofit form (ך, ם, ן, ף, ץ) when you type a word-ending character (e.g., Space, Period, Comma).
- **Important:**  
  - Only affects words with **two or more letters**.
  - Single-letter words are **not** changed.
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
