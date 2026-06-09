import AppKit

class AppDelegate: NSObject, NSApplicationDelegate {
    private var statusItem: NSStatusItem?
    private let hotkeyManager = HotkeyManager()
    private lazy var overlayController = OverlayWindowController()

    func applicationDidFinishLaunching(_ notification: Notification) {
        setupStatusBar()
        hotkeyManager.onHotKey = { [weak self] in
            self?.toggleOverlay()
        }
        hotkeyManager.onQRScan = {
            // screencapture는 블로킹이므로 백그라운드에서 실행
            DispatchQueue.global(qos: .userInitiated).async {
                QRScanner.scan()
            }
        }
        hotkeyManager.register()
    }

    private func setupStatusBar() {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
        if let button = statusItem?.button {
            button.image = NSImage(systemSymbolName: "keyboard", accessibilityDescription: "단축키 보기")
        }

        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "단축키 보기  ⌘⇧K", action: #selector(toggleOverlay), keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: "QR 코드 스캔  ⌃⌥Q", action: #selector(runQRScan), keyEquivalent: ""))
        menu.addItem(.separator())
        menu.addItem(NSMenuItem(title: "종료", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
        statusItem?.menu = menu
    }

    @objc func toggleOverlay() {
        if overlayController.isVisible {
            overlayController.hide()
        } else {
            overlayController.show()
        }
    }

    @objc func runQRScan() {
        DispatchQueue.global(qos: .userInitiated).async {
            QRScanner.scan()
        }
    }
}
