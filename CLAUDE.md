# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 빌드 및 실행

```bash
# 릴리즈 빌드
make build
# 또는
swift build -c release

# 디버그 빌드
swift build

# 실행 (빌드 후)
.build/release/ShortcutMac
```

재시작:
```bash
make deploy   # launchctl kickstart -k gui/$(id -u)/com.shortcutmac.app
```

## 아키텍처

단일 SwiftUI 앱, 전체 코드가 `Sources/ShortcutMac/` 아래 파일 5개로 구성됩니다.

```
main.swift              ← NSApplication 진입점. .accessory 정책으로 Dock 미표시.
AppDelegate.swift       ← 메뉴바 NSStatusItem 설정, HotkeyManager/OverlayWindowController 연결
HotkeyManager.swift     ← Carbon RegisterEventHotKey로 ⌘⇧K 등록 (Accessibility 권한 불필요)
OverlayWindowController.swift ← 전체화면 NSWindow + SwiftUI OverlayView 호스팅
OverlayView.swift       ← 단축키 카테고리 카드 레이아웃 (SwiftUI)
ShortcutsData.swift     ← ShortcutCategory / ShortcutItem 데이터 정의
```

## 단축키 데이터 수정

`ShortcutsData.swift`에서 `shortcutCategories` 배열을 직접 수정합니다.

- `ShortcutCategory`: `name`, `icon`, `items`
- `ShortcutItem`: `key` (단축키 표기), `description`, `isHeader` (섹션 헤더 여부)
- `rectangleCategory`는 별도 상수로 분리되어 오른쪽 컬럼에 단독 표시됩니다.

## UI 레이아웃

- 상단 4개 카테고리: 단일 컬럼 카드
- Firefox: 2열 레이아웃 (`twoColumn: true`)
- iTerm2: 단일 컬럼, 나머지 공간 채움
- Rectangle: 우측에 고정 너비로 별도 배치
- `small` 모드: 화면 높이 < 1000px일 때 폰트/패딩 자동 축소

## 의존성

없음. Swift 표준 라이브러리 + AppKit + SwiftUI + Carbon (시스템 프레임워크).

## git 제외 파일

`.build/`
