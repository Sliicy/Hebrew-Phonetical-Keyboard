import SwiftUI

struct ContentView: View {
    let defaults = UserDefaults(suiteName: "group.com.sliicy.hebrewkeyboard")
    
    @State private var isStandardLayout: Bool = false
    @State private var showCantillation: Bool = false
    @State private var showWideLetters: Bool = false
    @State private var testText: String = ""
    
    @FocusState private var isInputActive: Bool
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Keyboard Settings")) {
                    // Standard Layout Toggle
                    Toggle("Use Standard Hebrew Layout", isOn: $isStandardLayout)
                        .onChange(of: isStandardLayout) { _, newValue in
                            defaults?.set(newValue, forKey: "useStandardLayout")
                            refreshKeyboard()
                        }
                    
                    // Cantillation Toggle
                    Toggle("Show Cantillation (Trop)", isOn: $showCantillation)
                        .onChange(of: showCantillation) { _, newValue in
                            defaults?.set(newValue, forKey: "showCantillation")
                            refreshKeyboard()
                        }
                    Toggle("Show Wide Letters", isOn: $showWideLetters)
                        .onChange(of: showWideLetters) { _, newValue in
                            defaults?.set(newValue, forKey: "showWideLetters")
                            refreshKeyboard()
                        }
                }
                
                Section(header: Text("Test Your Keyboard")) {
                    Text("Tap inside the box below:")
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    TextEditor(text: $testText)
                        .frame(height: 120)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                        .environment(\.layoutDirection, .rightToLeft)
                        .multilineTextAlignment(.leading)
                        .focused($isInputActive)
                }
                
                Section(header: Text("Installation")) {
                    Text("1. Open iPhone Settings")
                    Text("2. General > Keyboard > Keyboards")
                    Text("3. Add New Keyboard...")
                    Text("4. Select 'Hebrew Phonetical Keyboard'")
                }
                
                Button("Open Settings") {
                    if let url = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(url)
                    }
                }
            }
            .navigationTitle("Hebrew Phonetic")
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            isStandardLayout = defaults?.bool(forKey: "useStandardLayout") ?? false
            showCantillation = defaults?.bool(forKey: "showCantillation") ?? false
        }
    }
    
    func refreshKeyboard() {
        if isInputActive {
            isInputActive = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                isInputActive = true
            }
        }
    }
}

