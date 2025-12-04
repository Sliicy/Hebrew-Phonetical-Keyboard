import Foundation
import Combine

class SettingsStore: ObservableObject {
    @Published var useStandardLayout: Bool = false
    private let suiteName = "group.com.sliicy.hebrewkeyboard"
    
    init() {
        reload()
    }
    
    func reload() {
        self.useStandardLayout = UserDefaults(suiteName: suiteName)?.bool(forKey: "useStandardLayout") ?? false
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
    static func key(_ label: String, inputOverride: String? = nil, isPhonetic: Bool) -> KeyDefinition {
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
            // REMOVED Geresh. Added Dagesh.
            alts = [full("ת", "\u{05BC}")]
            
        case "י":
            // Chirik, Double Yud, Double Yud Patach
            alts = [vowel("\u{05B4}"), char("ײ"), char("ײַ")]
            
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
            alts = [vowel("\u{05B9}"), vowel("\u{05BC}"), vowel("\u{05BB}")]
            
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
        
        return KeyDefinition(label, input: inputOverride ?? label, alternates: alts)
    }

    // --- Layout Generation ---
    static func getRows(useStandard: Bool) -> ([KeyDefinition], [KeyDefinition], [KeyDefinition], [KeyDefinition]) {
        // Number Row is constant
        let nums = ["1","2","3","4","5","6","7","8","9","0"].map { key($0, isPhonetic: false) }
        
        if useStandard {
            return (
                nums,
                [key("'", isPhonetic: false), key("-", isPhonetic: false), key("ק", isPhonetic: false), key("ר", isPhonetic: false), key("א", isPhonetic: false), key("ט", isPhonetic: false), key("ו", isPhonetic: false), key("ן", isPhonetic: false), key("ם", isPhonetic: false), key("פ", isPhonetic: false)],
                [key("ש", isPhonetic: false), key("ד", isPhonetic: false), key("ג", isPhonetic: false), key("כ", isPhonetic: false), key("ע", isPhonetic: false), key("י", isPhonetic: false), key("ח", isPhonetic: false), key("ל", isPhonetic: false), key("ך", isPhonetic: false), key("ף", isPhonetic: false)],
                [key("ז", isPhonetic: false), key("ס", isPhonetic: false), key("ב", isPhonetic: false), key("ה", isPhonetic: false), key("נ", isPhonetic: false), key("מ", isPhonetic: false), key("צ", isPhonetic: false), key("ת", isPhonetic: false), key("ץ", isPhonetic: false)]
            )
        } else {
            return (
                nums,
                [key("ק", isPhonetic: true), key("ר", isPhonetic: true), key("ת", isPhonetic: true), key("ט", isPhonetic: true), key("י", isPhonetic: true), key("וּ", isPhonetic: true), key("וֹ", isPhonetic: true), key("פּ", isPhonetic: true)],
                [key("א", isPhonetic: true), key("ע", isPhonetic: true), key("ש", isPhonetic: true), key("ס", isPhonetic: true), key("ד", isPhonetic: true), key("פ", isPhonetic: true), key("ג", isPhonetic: true), key("ה", isPhonetic: true), key("י", isPhonetic: true), key("כּ", isPhonetic: true), key("ל", isPhonetic: true)],
                [key("ז", isPhonetic: true), key("צ", isPhonetic: true), key("ח", isPhonetic: true), key("כ", isPhonetic: true), key("ו", isPhonetic: true), key("ב", isPhonetic: true), key("נ", isPhonetic: true), key("מ", isPhonetic: true)]
            )
        }
    }
}
