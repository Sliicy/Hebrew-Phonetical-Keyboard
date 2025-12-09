import Foundation
import Combine

class SettingsStore: ObservableObject {
    @Published var useStandardLayout: Bool = false
    @Published var showCantillation: Bool = false
    @Published var showWideLetters: Bool = false
    
    private let suiteName = "group.com.sliicy.hebrewkeyboard"
    
    init() {
        reload()
    }
    
    func reload() {
        let defaults = UserDefaults(suiteName: suiteName)
        self.useStandardLayout = defaults?.bool(forKey: "useStandardLayout") ?? false
        self.showCantillation = defaults?.bool(forKey: "showCantillation") ?? false
        self.showWideLetters = defaults?.bool(forKey: "showWideLetters") ?? false
    }
}

class KeyboardData {
    
    // MARK: - Helpers
    static func vowel(_ mark: String) -> KeyAlternate {
        return KeyAlternate(display: "\u{25CC}" + mark, input: mark)
    }
    
    static func char(_ c: String) -> KeyAlternate {
        return KeyAlternate(display: c, input: c)
    }
    
    static func full(_ base: String, _ mark: String) -> KeyAlternate {
        return KeyAlternate(display: base + mark, input: base + mark)
    }
    
    // MARK: - Key Logic
    static func key(_ label: String, inputOverride: String? = nil, isPhonetic: Bool, showTrop: Bool, showWideLetters: Bool) -> KeyDefinition {
        var alts: [KeyAlternate] = []
        
        switch label {
            
        // --- Number Row ---
        case "4":
            // 4 holds Shekel
            alts = [char("₪")]
        
        // --- Row 1 (Top) ---
        case "ק": alts = [vowel("\u{05B8}"), vowel("\u{05B3}"), vowel("\u{05BB}")]
        
        case "-": alts = [char("־")]

        case "'": alts = [char("\""), char("׳"), char("״")]

        case "ר":
            // Rafe (Mark)
            alts = [vowel("\u{05BF}")]
            
        case "ת":
            alts = [full("ת", "\u{05BC}")]
            
        case "י":
            // Chirik, Double Yud, Double Yud Patach
            alts = [vowel("\u{05B4}"), char("ײ"), char("ײַ"), char("יִ"), char("ױ"), char("ׯ")]
            
        case "פּ":
            alts = [vowel("\u{05B7}"), vowel("\u{05B2}"), char("פ")];
            if isPhonetic {
                alts.append(char("ףּ"))
                alts.append(char("ף"))
            }
        case "פ":
            // Regular Pe (in Standard layout too) needs vowels
            alts = [vowel("\u{05B7}"), vowel("\u{05B2}"), full("פ", "\u{05BC}")];
            // Only add Sofit if Phonetic
            if isPhonetic {
                alts.append(char("ףּ"))
                alts.append(char("ף"))
            }
            
        // --- Row 2 (Middle) ---
        case "א":
            alts = [char("ﭏ"), vowel("\u{05B5}")]
            
        case "ש": alts = [full("ש", "\u{05C1}"), full("ש", "\u{05C2}"), vowel("\u{05B0}")]
            
        case "ס":
            // Segol, Chataf Segol
            alts = [vowel("\u{05B6}"), vowel("\u{05B1}")]
            
        case "ד":
            alts = [vowel("\u{05BC}")]
            


        case "ג": alts = [char("ג׳"), char("׳"), char("״")]
            
        case "כ": alts = [full("כ", "\u{05BC}")]; if isPhonetic { alts = [char("ך"), char("כּ")] } else { alts.append(char("ך")) }
        case "כּ": alts = [char("ךּ"), char("כ")]
        case "ך": alts = [char("ךּ")]
        case "ף": alts = [char("ףּ")]
        case "ל":
            alts = [char("ﭏ")]

        // --- Row 3 (Bottom) ---
        case "ז":
            // REMOVED Geresh
            break
            
        case "ח": alts = [vowel("\u{05B9}"), vowel("\u{05B4}")]
        case "ע": alts = [vowel("\u{05AB}")]
        case "צ":
            alts = [vowel("\u{05B5}")];
            if isPhonetic { alts.append(char("ץ")) }
            
        case "ו":
            // Cholam, Shuruk Dot, Kubutz
            alts = [vowel("\u{05B9}"), vowel("\u{05BC}"), vowel("\u{05BB}"), char("װ"), char("ױ")]
            
        case "ב":
            alts = [full("ב", "\u{05BC}")]
            
        case "נ":
            alts = [char("׆")]
            if isPhonetic { alts.append(char("ן")) }

        case "ן":
            alts = [char("׆")]

        case "ם":
            alts = [vowel("\u{05BD}")]

        case "וּ":
            alts = [vowel("\u{05BC}")]
        case "וֹ":
            alts = [vowel("\u{05B9}")]
        case "מ": 
            alts = [vowel("\u{05BD}")]
            if isPhonetic { alts.append(char("ם")) }

        default:
            // For numbers 1,2,3,5... just default
            break
        }
        
        // --- Cantillation (Trop) Additions ---
        if showTrop {
            switch label {
            case "פ", "פּ": alts.append(contentsOf: [vowel("\u{0599}"), vowel("\u{059F}"), vowel("\u{05A1}"), char("׀")]) // Pashta, Pazeir, Pasek
            case "ק": alts.append(contentsOf: [vowel("\u{05A8}"), vowel("\u{059F}"), vowel("\u{05C7}")]) // Kadmah, Karne Para, Kamatz Katan
            case "מ": alts.append(contentsOf: [vowel("\u{05A3}"), vowel("\u{05A4}"), vowel("\u{05A5}"), vowel("\u{05A6}"), vowel("\u{05BE}")]) // Munach Mahpach, Meircha, Mercha Kefulah, Maqaf
            case "ז": alts.append(contentsOf: [vowel("\u{05AE}"), vowel("\u{0594}"), vowel("\u{0595}")]) // Zarka, Zakeif Katan, ZakeiGadol
            case "ס": alts.append(contentsOf: [vowel("\u{0592}"), char("׃")]) // Segolta, Sof Pasuk
            case "ר": alts.append(contentsOf: [vowel("\u{0597}")]) // Rivia
            case "ט": alts.append(contentsOf: [vowel("\u{0596}")]) // Tipcha
            case "א": alts.append(contentsOf: [vowel("\u{0591}"), vowel("\u{05A2}"), vowel("\u{05AF}")]) // Etnachta, Atnah Hafukh, Masora Circle
            case "ת": alts.append(contentsOf: [vowel("\u{05A9}"), vowel("\u{05A0}"), vowel("\u{059B}")]) // Telisha Ketana, TelishGedola, Tevir
            case "ג": alts.append(contentsOf: [vowel("\u{059C}"), vowel("\u{059E}")]) // Geresh, Gershayim
            case "ד": alts.append(contentsOf: [vowel("\u{05A7}"), vowel("\u{05AD}")]) // Darga, Dehi
            case "י": alts.append(contentsOf: [vowel("\u{059A}"), vowel("\u{05AA}")]) // Yetiv, Yerach Ben Yomo
            case "ש": alts.append(contentsOf: [vowel("\u{0593}")]) // Shalshelet
            case "ע": alts.append(contentsOf: [vowel("\u{05AC}")]) // Illuy
            case "צ": alts.append(contentsOf: [vowel("\u{0598}")]) // Tsinnorit
            case "-": alts.append(contentsOf: [char("׃"), char("׀"), vowel("\u{05BE}")]) // Sof Pasuk on dash
            case "ו": alts.append(contentsOf: [vowel("\u{FB1E}")]) // Hebrew Point Judeo-Spanish Varika
            default: break
            }
        }
        if isPhonetic && showWideLetters {
            switch label {
                case "מ":
                    alts.append(char("ﬦ"))
                default:
                    break
            }
        }
        if showWideLetters {
            switch label {
            case "א":
                alts.append(char("ﬡ"))
            case "ד":
                alts.append(char("ﬢ"))
            case "ה":
                alts.append(char("ﬣ"))
            case "כ":
                alts.append(char("ﬤ"))
            case "ל":
                alts.append(char("ﬥ"))
            case "ם":
                alts.append(char("ﬦ"))
            case "ר":
                alts.append(char("ﬧ"))
            case "ע":
                alts.append(char("ﬠ"))
            case "ת":
                alts.append(char("ﬨ"))
            default:
                break
            }
        }

        return KeyDefinition(label, input: inputOverride ?? label, alternates: alts)
    }

    // --- Layout Generation ---
    static func getRows(useStandard: Bool, showTrop: Bool, showWideLetters: Bool) -> ([KeyDefinition], [KeyDefinition], [KeyDefinition], [KeyDefinition]) {
        // Number Row is constant
        let nums = ["1","2","3","4","5","6","7","8","9","0"].map { key($0, isPhonetic: false, showTrop: showTrop, showWideLetters: showWideLetters) }
        
        if useStandard {
            return (
                            nums,
                            [key("'", isPhonetic: false, showTrop: showTrop, showWideLetters: showWideLetters), key("-", isPhonetic: false, showTrop: showTrop, showWideLetters: showWideLetters), key("ק", isPhonetic: false, showTrop: showTrop, showWideLetters: showWideLetters), key("ר", isPhonetic: false, showTrop: showTrop, showWideLetters: showWideLetters), key("א", isPhonetic: false, showTrop: showTrop, showWideLetters: showWideLetters), key("ט", isPhonetic: false, showTrop: showTrop, showWideLetters: showWideLetters), key("ו", isPhonetic: false, showTrop: showTrop, showWideLetters: showWideLetters), key("ן", isPhonetic: false, showTrop: showTrop, showWideLetters: showWideLetters), key("ם", isPhonetic: false, showTrop: showTrop, showWideLetters: showWideLetters), key("פ", isPhonetic: false, showTrop: showTrop, showWideLetters: showWideLetters)],
                            [key("ש", isPhonetic: false, showTrop: showTrop, showWideLetters: showWideLetters), key("ד", isPhonetic: false, showTrop: showTrop, showWideLetters: showWideLetters), key("ג", isPhonetic: false, showTrop: showTrop, showWideLetters: showWideLetters), key("כ", isPhonetic: false, showTrop: showTrop, showWideLetters: showWideLetters), key("ע", isPhonetic: false, showTrop: showTrop, showWideLetters: showWideLetters), key("י", isPhonetic: false, showTrop: showTrop, showWideLetters: showWideLetters), key("ח", isPhonetic: false, showTrop: showTrop, showWideLetters: showWideLetters), key("ל", isPhonetic: false, showTrop: showTrop, showWideLetters: showWideLetters), key("ך", isPhonetic: false, showTrop: showTrop, showWideLetters: showWideLetters), key("ף", isPhonetic: false, showTrop: showTrop, showWideLetters: showWideLetters)],
                            [key("ז", isPhonetic: false, showTrop: showTrop, showWideLetters: showWideLetters), key("ס", isPhonetic: false, showTrop: showTrop, showWideLetters: showWideLetters), key("ב", isPhonetic: false, showTrop: showTrop, showWideLetters: showWideLetters), key("ה", isPhonetic: false, showTrop: showTrop, showWideLetters: showWideLetters), key("נ", isPhonetic: false, showTrop: showTrop, showWideLetters: showWideLetters), key("מ", isPhonetic: false, showTrop: showTrop, showWideLetters: showWideLetters), key("צ", isPhonetic: false, showTrop: showTrop, showWideLetters: showWideLetters), key("ת", isPhonetic: false, showTrop: showTrop, showWideLetters: showWideLetters), key("ץ", isPhonetic: false, showTrop: showTrop, showWideLetters: showWideLetters)]
                        )
        } else {
            return (
                            nums,
                            [key("ק", isPhonetic: true, showTrop: showTrop, showWideLetters: showWideLetters), key("ר", isPhonetic: true, showTrop: showTrop, showWideLetters: showWideLetters), key("ת", isPhonetic: true, showTrop: showTrop, showWideLetters: showWideLetters), key("ט", isPhonetic: true, showTrop: showTrop, showWideLetters: showWideLetters), key("י", isPhonetic: true, showTrop: showTrop, showWideLetters: showWideLetters), key("וּ", isPhonetic: true, showTrop: showTrop, showWideLetters: showWideLetters), key("וֹ", isPhonetic: true, showTrop: showTrop, showWideLetters: showWideLetters), key("פּ", isPhonetic: true, showTrop: showTrop, showWideLetters: showWideLetters)],
                            [key("א", isPhonetic: true, showTrop: showTrop, showWideLetters: showWideLetters), key("ע", isPhonetic: true, showTrop: showTrop, showWideLetters: showWideLetters), key("ש", isPhonetic: true, showTrop: showTrop, showWideLetters: showWideLetters), key("ס", isPhonetic: true, showTrop: showTrop, showWideLetters: showWideLetters), key("ד", isPhonetic: true, showTrop: showTrop, showWideLetters: showWideLetters), key("פ", isPhonetic: true, showTrop: showTrop, showWideLetters: showWideLetters), key("ג", isPhonetic: true, showTrop: showTrop, showWideLetters: showWideLetters), key("ה", isPhonetic: true, showTrop: showTrop, showWideLetters: showWideLetters), key("י", isPhonetic: true, showTrop: showTrop, showWideLetters: showWideLetters), key("כּ", isPhonetic: true, showTrop: showTrop, showWideLetters: showWideLetters), key("ל", isPhonetic: true, showTrop: showTrop, showWideLetters: showWideLetters)],
                            [key("ז", isPhonetic: true, showTrop: showTrop, showWideLetters: showWideLetters), key("צ", isPhonetic: true, showTrop: showTrop, showWideLetters: showWideLetters), key("ח", isPhonetic: true, showTrop: showTrop, showWideLetters: showWideLetters), key("כ", isPhonetic: true, showTrop: showTrop, showWideLetters: showWideLetters), key("ו", isPhonetic: true, showTrop: showTrop, showWideLetters: showWideLetters), key("ב", isPhonetic: true, showTrop: showTrop, showWideLetters: showWideLetters), key("נ", isPhonetic: true, showTrop: showTrop, showWideLetters: showWideLetters), key("מ", isPhonetic: true, showTrop: showTrop, showWideLetters: showWideLetters)]
                        )
        }
    }
}
