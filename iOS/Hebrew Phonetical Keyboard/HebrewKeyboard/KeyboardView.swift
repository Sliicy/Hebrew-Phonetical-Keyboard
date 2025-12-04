import SwiftUI

struct KeyboardView: View {
    var insertText: (String) -> Void
    var deleteBackward: () -> Void
    var dismissKeyboard: () -> Void
    var nextKeyboard: () -> Void
    
    @ObservedObject var settings: SettingsStore
    @Environment(\.colorScheme) var colorScheme // Detect Dark Mode
    
    var body: some View {
        let rows = KeyboardData.getRows(useStandard: settings.useStandardLayout)
        
        // Dynamic Colors
        let bgColor = colorScheme == .dark ? Color(UIColor.systemGray6) : Color(red: 209/255, green: 213/255, blue: 219/255)
        
        ZStack {
            bgColor.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 8) {
                Spacer().frame(height: 55)
                
                // Number Row
                HStack(spacing: 5) {
                    ForEach(Array(rows.0.enumerated()), id: \.element) { index, key in
                        KeyButton(key: key, insertText: insertText)
                    }
                }
                
                // Row 1
                HStack(spacing: 5) {
                    ForEach(Array(rows.1.enumerated()), id: \.element) { index, key in
                        KeyButton(key: key, insertText: insertText)
                    }
                }
                
                // Row 2
                HStack(spacing: 5) {
                    ForEach(Array(rows.2.enumerated()), id: \.element) { index, key in
                        KeyButton(key: key, insertText: insertText)
                    }
                }
                
                // Row 3
                HStack(spacing: 5) {
                    SystemButton(iconName: "shift", action: {}) // Visual only
                    
                    ForEach(Array(rows.3.enumerated()), id: \.element) { index, key in
                        KeyButton(key: key, insertText: insertText)
                    }
                    
                    SystemButton(iconName: "delete.left", action: deleteBackward)
                }
                
                // Bottom Row
                HStack(spacing: 5) {
                    // Globe
                    SystemButton(iconName: "globe", action: nextKeyboard)
                        .frame(width: 42)
                    
                    // Space
                    Button(action: { insertText(" ") }) {
                        Text("רווח")
                            .font(.system(size: 16))
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                            .frame(maxWidth: .infinity)
                            .frame(height: 42)
                            .background(colorScheme == .dark ? Color(UIColor.systemGray2) : Color.white)
                            .cornerRadius(5)
                            .shadow(color: .black.opacity(0.3), radius: 0, x: 0, y: 1)
                    }
                    
                    // Hide Keyboard Button (Rightmost)
                    SystemButton(iconName: "keyboard.chevron.compact.down", action: dismissKeyboard)
                        .frame(width: 42)
                    
                    // Enter
                    Button(action: { insertText("\n") }) {
                        Text("↵")
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                            .frame(width: 75)
                            .frame(height: 42)
                            .background(Color.blue)
                            .cornerRadius(5)
                            .shadow(color: .black.opacity(0.3), radius: 0, x: 0, y: 1)
                    }
                    

                }
            }
            .padding(.horizontal, 4)
            .padding(.bottom, 4)
        }
    }
}

struct KeyButton: View {
    let key: KeyDefinition
    let insertText: (String) -> Void
    
    @Environment(\.colorScheme) var colorScheme
    
    @State private var isPressed = false
    @State private var showPopup = false
    @State private var selectedAltIndex: Int? = nil
    
    let popupWidth: CGFloat = 40
    let popupHeight: CGFloat = 50
    
    var body: some View {
        GeometryReader { geo in
            let keyWidth = geo.size.width
            let totalPopupWidth = CGFloat(key.alternates.count) * popupWidth
            
            // --- DYNAMIC EDGE DETECTION LOGIC ---
            let globalFrame = geo.frame(in: .global)
            let screenWidth = UIScreen.main.bounds.width
            
            // Default: Center
            var idealX = (keyWidth - totalPopupWidth) / 2
            
            // Check Left Edge
            if globalFrame.minX + idealX < 5 {
                idealX = -globalFrame.minX + 5
            }
            
            // Check Right Edge
            if globalFrame.minX + idealX + totalPopupWidth > screenWidth - 5 {
                idealX = (screenWidth - 5) - (globalFrame.minX + totalPopupWidth)
            }
            
            let popupOffset = idealX
            
            // Dynamic Colors
            let keyBg = colorScheme == .dark ? (isPressed ? Color(UIColor.systemGray) : Color(UIColor.systemGray2)) : (isPressed ? Color.gray.opacity(0.4) : Color.white)
            let textColor = colorScheme == .dark ? Color.white : Color.black
            let popupBg = colorScheme == .dark ? Color(UIColor.systemGray3) : Color.white
            
            // FIX: Added 'return' here to make Swift happy
            return ZStack(alignment: .topLeading) {
                
                // --- THE POPUP ---
                if showPopup && !key.alternates.isEmpty {
                    HStack(spacing: 0) {
                        ForEach(Array(key.alternates.enumerated()), id: \.offset) { index, alt in
                            ZStack {
                                Color(selectedAltIndex == index ? .blue : popupBg)
                                Text(alt.display)
                                    .font(.custom("Arial", size: 28))
                                    .foregroundColor(selectedAltIndex == index ? .white : textColor)
                            }
                            .frame(width: popupWidth, height: popupHeight)
                            .border(Color.gray.opacity(0.3), width: 0.5)
                        }
                    }
                    .background(popupBg)
                    .cornerRadius(8)
                    .shadow(radius: 5)
                    .offset(y: -popupHeight - 12)
                    .offset(x: popupOffset)
                    .zIndex(100)
                }
                
                // --- THE KEY ---
                Text(key.label)
                    .font(.custom("Arial", size: 24))
                    .foregroundColor(textColor)
                    .frame(width: geo.size.width, height: 42)
                    .background(keyBg)
                    .cornerRadius(5)
                    .shadow(color: .black.opacity(0.3), radius: 0, x: 0, y: 1)
            }
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        if !isPressed {
                            isPressed = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                if isPressed && !key.alternates.isEmpty { showPopup = true }
                            }
                        }
                        
                        if value.location.y > 60 || value.location.y < -200 {
                            showPopup = false
                            selectedAltIndex = nil
                            return
                        }
                        
                        if showPopup {
                            let touchX = value.location.x
                            let relativeX = touchX - popupOffset
                            
                            if relativeX >= 0 && relativeX < totalPopupWidth {
                                selectedAltIndex = Int(relativeX / popupWidth)
                            } else {
                                selectedAltIndex = nil
                            }
                        }
                    }
                    .onEnded { value in
                        if showPopup, let index = selectedAltIndex {
                            insertText(key.alternates[index].input)
                        } else {
                            if isPressed && !showPopup && value.location.y < 60 {
                               insertText(key.input)
                            } else if !showPopup && value.location.y < 60 {
                                insertText(key.input)
                            }
                        }
                        isPressed = false
                        showPopup = false
                        selectedAltIndex = nil
                    }
            )
        }
        .frame(height: 42)
    }
}

struct SystemButton: View {
    let iconName: String
    let action: () -> Void
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Button(action: action) {
            Image(systemName: iconName)
                .foregroundColor(colorScheme == .dark ? .white : .black)
                .frame(width: 42, height: 42)
                .background(colorScheme == .dark ? Color(UIColor.systemGray2) : Color(red: 172/255, green: 179/255, blue: 188/255))
                .cornerRadius(5)
                .shadow(color: .black.opacity(0.3), radius: 0, x: 0, y: 1)
        }
    }
}
