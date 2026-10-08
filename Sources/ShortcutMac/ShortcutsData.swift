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
        ShortcutItem(key: "⌘ + 드래그", description: "파일 강제 이동"),
        ShortcutItem(key: "⌘C → ⌥⌘V", description: "파일 잘라내기 이동"),
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

let utilsCategory = ShortcutCategory(name: "스크립트 / 도구", icon: "🔧", items: [
    ShortcutItem(key: "⌃⌥Q", description: "QR 코드 스캔 → 클립보드"),
])

let vscodeCategory = ShortcutCategory(name: "VS Code", icon: "💻", items: [
    ShortcutItem(key: "", description: "레이아웃 · 터미널", isHeader: true),
    ShortcutItem(key: "⌘B", description: "왼쪽 패널"),
    ShortcutItem(key: "⌘⌥B", description: "오른쪽 패널"),
    ShortcutItem(key: "⌃⇧`", description: "새 터미널"),
    ShortcutItem(key: "⌘J", description: "하단 패널 토글"),
    ShortcutItem(key: "", description: "파이썬 실행", isHeader: true),
    ShortcutItem(key: "⌘⇧R", description: "현재 파이썬을 같은 터미널에서 실행 (사용자 정의)"),
    ShortcutItem(key: "⇧↩", description: "선택/현재 줄 파이썬 터미널 실행"),
    ShortcutItem(key: "F5", description: "디버깅 시작/계속"),
    ShortcutItem(key: "F9", description: "중단점 토글"),
    ShortcutItem(key: "F10 / F11", description: "스텝 오버 / 인투"),
    ShortcutItem(key: "", description: "이동 · 검색", isHeader: true),
    ShortcutItem(key: "⌘P", description: "파일 빠른 열기"),
    ShortcutItem(key: "⌘⇧P", description: "명령 팔레트"),
    ShortcutItem(key: "⌘⇧O", description: "파일 내 심볼 이동"),
    ShortcutItem(key: "⌃G", description: "줄 번호로 이동"),
    ShortcutItem(key: "⌘⇧F", description: "전체 파일 검색"),
    ShortcutItem(key: "F12", description: "정의로 이동"),
    ShortcutItem(key: "⇧F12", description: "참조 찾기"),
    ShortcutItem(key: "", description: "편집", isHeader: true),
    ShortcutItem(key: "F2", description: "심볼 이름 바꾸기"),
    ShortcutItem(key: "⌘/", description: "주석 토글"),
    ShortcutItem(key: "⌥↑ / ⌥↓", description: "줄 이동"),
    ShortcutItem(key: "⌥⇧↓", description: "줄 복제"),
    ShortcutItem(key: "⌘D", description: "다음 같은 단어 선택"),
    ShortcutItem(key: "⌘⇧L", description: "같은 단어 모두 선택"),
    ShortcutItem(key: "⌥⇧F", description: "코드 포맷"),
])
