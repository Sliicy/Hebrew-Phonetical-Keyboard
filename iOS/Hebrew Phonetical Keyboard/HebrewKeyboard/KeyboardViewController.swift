import UIKit
import SwiftUI

class KeyboardViewController: UIInputViewController {
    
    private var hostingController: UIHostingController<RootView>?
    private var settingsStore = SettingsStore()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1. Create the view ONCE here, not in viewWillAppear
        let rootView = RootView(
            insertText: { [weak self] text in self?.textDocumentProxy.insertText(text) },
            deleteBackward: { [weak self] in self?.textDocumentProxy.deleteBackward() },
            dismissKeyboard: { [weak self] in self?.dismissKeyboard() },
            nextKeyboard: { [weak self] in self?.advanceToNextInputMode() },
            settings: settingsStore
        )
        
        hostingController = UIHostingController(rootView: rootView)
        
        guard let hc = hostingController else { return }
        
        // 2. Add to hierarchy
        addChild(hc)
        view.addSubview(hc.view)
        hc.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hc.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            hc.view.rightAnchor.constraint(equalTo: view.rightAnchor),
            hc.view.topAnchor.constraint(equalTo: view.topAnchor),
            hc.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        hc.didMove(toParent: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 3. Just refresh data, don't rebuild UI
        settingsStore.reload()
    }
    
    override func textWillChange(_ textInput: UITextInput?) {}
    override func textDidChange(_ textInput: UITextInput?) {}
}

struct RootView: View {
    var insertText: (String) -> Void
    var deleteBackward: () -> Void
    var dismissKeyboard: () -> Void
    var nextKeyboard: () -> Void
    var settings: SettingsStore
    
    var body: some View {
        KeyboardView(
            insertText: insertText,
            deleteBackward: deleteBackward,
            dismissKeyboard: dismissKeyboard,
            nextKeyboard: nextKeyboard,
            settings: settings
        )
    }
}
