import Foundation

struct ShortcutItem: Identifiable {
    let id = UUID()
    let key: String
    let description: String
}

struct ShortcutCategory: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
    let items: [ShortcutItem]
}

let shortcutCategories: [ShortcutCategory] = [
    ShortcutCategory(name: "기본 편집", icon: "✏️", items: [
        ShortcutItem(key: "⌘C", description: "복사"),
        ShortcutItem(key: "⌘V", description: "붙여넣기"),
        ShortcutItem(key: "⌘X", description: "잘라내기"),
        ShortcutItem(key: "⌘Z", description: "실행 취소"),
        ShortcutItem(key: "⌘⇧Z", description: "다시 실행"),
        ShortcutItem(key: "⌘A", description: "전체 선택"),
        ShortcutItem(key: "⌘F", description: "찾기"),
        ShortcutItem(key: "⌘S", description: "저장"),
    ]),
    ShortcutCategory(name: "앱 / 윈도우", icon: "🪟", items: [
        ShortcutItem(key: "⌘Q", description: "앱 종료"),
        ShortcutItem(key: "⌘W", description: "윈도우 닫기"),
        ShortcutItem(key: "⌘M", description: "최소화"),
        ShortcutItem(key: "⌘H", description: "앱 숨기기"),
        ShortcutItem(key: "⌘⌥H", description: "다른 앱 숨기기"),
        ShortcutItem(key: "⌘Tab", description: "앱 전환"),
        ShortcutItem(key: "⌘`", description: "윈도우 전환"),
        ShortcutItem(key: "⌘,", description: "환경설정"),
    ]),
    ShortcutCategory(name: "스크린샷", icon: "📷", items: [
        ShortcutItem(key: "⌘⇧3", description: "전체 화면 캡처"),
        ShortcutItem(key: "⌘⇧4", description: "선택 영역 캡처"),
        ShortcutItem(key: "⌘⇧4 Space", description: "윈도우 캡처"),
        ShortcutItem(key: "⌘⇧5", description: "캡처 도구"),
    ]),
    ShortcutCategory(name: "시스템", icon: "⚙️", items: [
        ShortcutItem(key: "⌘Space", description: "Spotlight 검색"),
        ShortcutItem(key: "⌃Space", description: "입력기 전환"),
        ShortcutItem(key: "⌘⌥Esc", description: "강제 종료"),
        ShortcutItem(key: "⌃⌘Q", description: "화면 잠금"),
        ShortcutItem(key: "⌘N", description: "새 문서"),
        ShortcutItem(key: "⌘O", description: "열기"),
        ShortcutItem(key: "⌘P", description: "프린트"),
    ]),
]
