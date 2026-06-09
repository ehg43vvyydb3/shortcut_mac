import Carbon

// Carbon RegisterEventHotKey 방식: Accessibility 권한 불필요
class HotkeyManager {
    var onHotKey: (() -> Void)?      // ⌘⇧K — 오버레이 토글
    var onQRScan: (() -> Void)?      // ⌃⌥Q — QR 스캔
    private var eventHandlerRef: EventHandlerRef?
    private var hotKeyRef: EventHotKeyRef?
    private var qrHotKeyRef: EventHotKeyRef?

    func register() {
        var eventType = EventTypeSpec(
            eventClass: OSType(kEventClassKeyboard),
            eventKind: UInt32(kEventHotKeyPressed)
        )

        // C 콜백: userData로 self 전달, 이벤트에서 핫키 ID를 꺼내 분기
        let handler: EventHandlerProcPtr = { _, event, userData -> OSStatus in
            guard let ptr = userData else { return noErr }
            let manager = Unmanaged<HotkeyManager>.fromOpaque(ptr).takeUnretainedValue()

            var hkID = EventHotKeyID()
            GetEventParameter(
                event,
                EventParamName(kEventParamDirectObject),
                EventParamType(typeEventHotKeyID),
                nil,
                MemoryLayout<EventHotKeyID>.size,
                nil,
                &hkID
            )

            DispatchQueue.main.async {
                switch hkID.id {
                case 1: manager.onHotKey?()
                case 2: manager.onQRScan?()
                default: break
                }
            }
            return noErr
        }

        InstallEventHandler(
            GetApplicationEventTarget(),
            handler,
            1,
            &eventType,
            Unmanaged.passUnretained(self).toOpaque(),
            &eventHandlerRef
        )

        // ⌘⇧K
        RegisterEventHotKey(
            UInt32(kVK_ANSI_K),
            UInt32(cmdKey | shiftKey),
            EventHotKeyID(signature: 0x53435554, id: 1),
            GetApplicationEventTarget(),
            0,
            &hotKeyRef
        )

        // ⌃⌥Q — QR 스캔
        RegisterEventHotKey(
            UInt32(kVK_ANSI_Q),
            UInt32(controlKey | optionKey),
            EventHotKeyID(signature: 0x53435554, id: 2),
            GetApplicationEventTarget(),
            0,
            &qrHotKeyRef
        )
    }

    deinit {
        if let ref = hotKeyRef { UnregisterEventHotKey(ref) }
        if let ref = qrHotKeyRef { UnregisterEventHotKey(ref) }
        if let ref = eventHandlerRef { RemoveEventHandler(ref) }
    }
}
