import SwiftUI

struct ContentView: View {
    let defaults = UserDefaults(suiteName: "group.com.sliicy.hebrewkeyboard")
    
    @State private var isStandardLayout: Bool = false
    @State private var testText: String = ""
    
    // 1. Add Focus State
    @FocusState private var isInputActive: Bool
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Keyboard Type")) {
                    Toggle("Use Standard Hebrew Layout", isOn: $isStandardLayout)
                        .onChange(of: isStandardLayout) { val in
                            defaults?.set(val, forKey: "useStandardLayout")
                            // If keyboard is open, close it, wait 0.1s, then reopen it to force refresh
                            if isInputActive { isInputActive = false; DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { isInputActive = true } }
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
                        // 3. Bind to Focus State
                        .focused($isInputActive)
                        .multilineTextAlignment(.leading)
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
        }
    }
}
