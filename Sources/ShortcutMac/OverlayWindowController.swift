import AppKit
import SwiftUI

private class OverlayWindow: NSWindow {
    // borderless 윈도우는 기본적으로 key window가 될 수 없어서 override 필요
    override var canBecomeKey: Bool { true }
}

class OverlayWindowController: NSWindowController {
    private var localMonitor: Any?
    private var previousApp: NSRunningApplication?

    init() {
        let screen = NSScreen.main ?? NSScreen.screens[0]

        let window = OverlayWindow(
            contentRect: screen.frame,
            styleMask: [.borderless],
            backing: .buffered,
            defer: false
        )
        window.level = .screenSaver
        window.backgroundColor = .clear
        window.isOpaque = false
        window.hasShadow = false
        window.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
        window.alphaValue = 0

        super.init(window: window)

        window.contentView = NSHostingView(
            rootView: OverlayView { [weak self] in self?.hide() }
        )
    }

    required init?(coder: NSCoder) { fatalError() }

    var isVisible: Bool { window?.isVisible ?? false }

    func show() {
        previousApp = NSWorkspace.shared.frontmostApplication
        window?.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)

        localMonitor = NSEvent.addLocalMonitorForEvents(matching: .keyDown) { [weak self] event in
            if event.keyCode == 53 { // ESC
                self?.hide()
                return nil
            }
            return event
        }

        NSAnimationContext.runAnimationGroup { ctx in
            ctx.duration = 0.2
            window?.animator().alphaValue = 1
        }
    }

    func hide() {
        if let monitor = localMonitor {
            NSEvent.removeMonitor(monitor)
            localMonitor = nil
        }

        NSAnimationContext.runAnimationGroup { ctx in
            ctx.duration = 0.15
            window?.animator().alphaValue = 0
        } completionHandler: { [weak self] in
            self?.window?.orderOut(nil)
            self?.previousApp?.activate(options: .activateIgnoringOtherApps)
            self?.previousApp = nil
        }
    }
}
