import AppKit

let app = NSApplication.shared
app.setActivationPolicy(.accessory)  // 독 아이콘 없이 메뉴바에만 표시
let delegate = AppDelegate()
app.delegate = delegate
app.run()
