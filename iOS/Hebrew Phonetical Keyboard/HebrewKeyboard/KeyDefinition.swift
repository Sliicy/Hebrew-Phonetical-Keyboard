import Foundation

// MARK: - 1. Key Alternate Struct
struct KeyAlternate: Hashable {
    let id = UUID()
    let display: String // What shows in the popup
    let input: String   // What gets typed
}

// MARK: - 2. Key Definition Struct
struct KeyDefinition: Identifiable, Hashable {
    let id = UUID()
    let label: String
    let input: String
    let alternates: [KeyAlternate]
    
    init(_ label: String, input: String? = nil, alternates: [KeyAlternate] = []) {
        self.label = label
        self.input = input ?? label
        self.alternates = alternates
    }
}

// MARK: - 3. Settings Manager
class SettingsManager {
    static let shared = SettingsManager()
    let suiteName = "group.com.sliicy.hebrewkeyboard" // Must match App Group ID
    
    var useStandardLayout: Bool {
        get {
            return UserDefaults(suiteName: suiteName)?.bool(forKey: "useStandardLayout") ?? false
        }
        set {
            UserDefaults(suiteName: suiteName)?.set(newValue, forKey: "useStandardLayout")
        }
    }
}
