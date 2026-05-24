import Foundation

struct ShortcutItem: Identifiable {
    let id = UUID()
    let key: String
    let description: String
    var isHeader: Bool = false
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

let rectangleCategory = ShortcutCategory(name: "Rectangle", icon: "🟦", items: [
    ShortcutItem(key: "", description: "절반", isHeader: true),
    ShortcutItem(key: "⌃⌥←", description: "왼쪽"),
    ShortcutItem(key: "⌃⌥→", description: "오른쪽"),
    ShortcutItem(key: "⌃⌥↑", description: "위쪽"),
    ShortcutItem(key: "⌃⌥↓", description: "아래쪽"),
    ShortcutItem(key: "", description: "사분면", isHeader: true),
    ShortcutItem(key: "⌃⌥U", description: "왼쪽 위"),
    ShortcutItem(key: "⌃⌥I", description: "오른쪽 위"),
    ShortcutItem(key: "⌃⌥J", description: "왼쪽 아래"),
    ShortcutItem(key: "⌃⌥K", description: "오른쪽 아래"),
    ShortcutItem(key: "", description: "1/3 · 2/3", isHeader: true),
    ShortcutItem(key: "⌃⌥D", description: "첫 1/3"),
    ShortcutItem(key: "⌃⌥F", description: "가운데 1/3"),
    ShortcutItem(key: "⌃⌥G", description: "마지막 1/3"),
    ShortcutItem(key: "⌃⌥E", description: "첫 2/3"),
    ShortcutItem(key: "⌃⌥R", description: "가운데 2/3"),
    ShortcutItem(key: "⌃⌥T", description: "마지막 2/3"),
    ShortcutItem(key: "", description: "기타", isHeader: true),
    ShortcutItem(key: "⌃⌥↩", description: "최대화"),
    ShortcutItem(key: "⌃⌥⇧↩", description: "거의 최대화"),
    ShortcutItem(key: "⌃⌥C", description: "가운데"),
    ShortcutItem(key: "⌃⌥⌫", description: "복원"),
])
