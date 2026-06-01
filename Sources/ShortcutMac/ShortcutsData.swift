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
        ShortcutItem(key: "⌘G", description: "다음 찾기"),
        ShortcutItem(key: "⌘S", description: "저장"),
        ShortcutItem(key: "⌘T", description: "새 탭"),
        ShortcutItem(key: "⌘N", description: "새 문서"),
        ShortcutItem(key: "⌘P", description: "프린트"),
    ]),
    ShortcutCategory(name: "앱 / 윈도우", icon: "🪟", items: [
        ShortcutItem(key: "⌘Q", description: "앱 종료"),
        ShortcutItem(key: "⌘W", description: "윈도우 닫기"),
        ShortcutItem(key: "⌘M", description: "최소화"),
        ShortcutItem(key: "⌃⌘F", description: "전체 화면"),
        ShortcutItem(key: "⌘H", description: "앱 숨기기"),
        ShortcutItem(key: "⌘⌥H", description: "다른 앱 숨기기"),
        ShortcutItem(key: "⌘Tab", description: "앱 전환"),
        ShortcutItem(key: "⌘`", description: "윈도우 전환"),
        ShortcutItem(key: "⌘,", description: "환경설정"),
    ]),
    ShortcutCategory(name: "스크린샷", icon: "📷", items: [
        ShortcutItem(key: "⌘⇧3", description: "전체 화면"),
        ShortcutItem(key: "⌘⇧4", description: "선택 영역"),
        ShortcutItem(key: "⌘⇧4 Space", description: "윈도우"),
        ShortcutItem(key: "⌘⇧5", description: "캡처 도구"),
        ShortcutItem(key: "⌃⌘⇧3", description: "전체→클립보드"),
        ShortcutItem(key: "⌃⌘⇧4", description: "선택→클립보드"),
    ]),
    ShortcutCategory(name: "시스템", icon: "⚙️", items: [
        ShortcutItem(key: "⌘Space", description: "Spotlight 검색"),
        ShortcutItem(key: "⌃⌘Space", description: "이모지 입력"),
        ShortcutItem(key: "⌃Space", description: "입력기 전환"),
        ShortcutItem(key: "⌘⌥Esc", description: "강제 종료"),
        ShortcutItem(key: "⌃⌘Q", description: "화면 잠금"),
        ShortcutItem(key: "⌘⇧Q", description: "로그아웃"),
        ShortcutItem(key: "⌘O", description: "열기"),
        ShortcutItem(key: "fn Q", description: "빠른 메모 생성"),
        ShortcutItem(key: "⌘⇧.", description: "파인더 숨김 파일 표시/숨김"),
    ]),
    ShortcutCategory(name: "Firefox", icon: "🦊", items: [
        ShortcutItem(key: "", description: "네비게이션", isHeader: true),
        ShortcutItem(key: "⌘[", description: "뒤로"),
        ShortcutItem(key: "⌘]", description: "앞으로"),
        ShortcutItem(key: "⌘R", description: "새로 고침"),
        ShortcutItem(key: "⌘⇧R", description: "새로 고침 (캐시 무시)"),
        ShortcutItem(key: "⌘L", description: "주소창 선택"),
        ShortcutItem(key: "", description: "탭 & 창", isHeader: true),
        ShortcutItem(key: "⌘T", description: "새 탭"),
        ShortcutItem(key: "⌘W", description: "탭 닫기"),
        ShortcutItem(key: "⌘⇧T", description: "닫은 탭 다시 열기"),
        ShortcutItem(key: "⌘⌥←", description: "이전 탭"),
        ShortcutItem(key: "⌘⌥→", description: "다음 탭"),
        ShortcutItem(key: "⌘⇧P", description: "사생활 보호 모드"),
        ShortcutItem(key: "", description: "북마크 & 기록", isHeader: true),
        ShortcutItem(key: "⌘D", description: "북마크 추가"),
        ShortcutItem(key: "⌘B", description: "북마크 사이드바"),
        ShortcutItem(key: "⌘⇧H", description: "방문 기록"),
        ShortcutItem(key: "⌘J", description: "다운로드"),
        ShortcutItem(key: "", description: "개발자 도구", isHeader: true),
        ShortcutItem(key: "⌘⌥I", description: "개발자 도구"),
        ShortcutItem(key: "⌘⌥K", description: "웹 콘솔"),
        ShortcutItem(key: "⌘⌥M", description: "반응형 디자인"),
        ShortcutItem(key: "⌘U", description: "페이지 소스"),
    ]),
    ShortcutCategory(name: "iTerm2", icon: "🖥️", items: [
        ShortcutItem(key: "", description: "창 & 탭", isHeader: true),
        ShortcutItem(key: "⌘N", description: "새 창"),
        ShortcutItem(key: "⌘T", description: "새 탭"),
        ShortcutItem(key: "⌘W", description: "탭 닫기"),
        ShortcutItem(key: "", description: "분할 창", isHeader: true),
        ShortcutItem(key: "⌘D", description: "수직 분할"),
        ShortcutItem(key: "⌘⇧D", description: "수평 분할"),
        ShortcutItem(key: "⌘[", description: "이전 분할 창"),
        ShortcutItem(key: "⌘]", description: "다음 분할 창"),
        ShortcutItem(key: "⌘/", description: "포커스 위치 표시"),
        ShortcutItem(key: "", description: "검색 & 기타", isHeader: true),
        ShortcutItem(key: "⌘F", description: "검색"),
        ShortcutItem(key: "⌘⌥E", description: "전체 검색"),
        ShortcutItem(key: "⌘⇧H", description: "클립보드 기록"),
        ShortcutItem(key: "⌘;", description: "자동 완성"),
        ShortcutItem(key: "⌘U", description: "투명도 토글"),
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
