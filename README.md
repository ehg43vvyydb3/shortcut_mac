# ShortcutMac

> 단축키 ⌘⇧K 하나로 언제든 꺼내 보는 macOS 단축키 레퍼런스 메뉴바 앱  
> A macOS menu-bar app that pops up a keyboard shortcut reference with ⌘⇧K — no Dock icon, no Accessibility permission.

[English](#english) · [한국어](#한국어)

![platform](https://img.shields.io/badge/platform-macOS%2013%2B-lightgrey?logo=apple)
![swift](https://img.shields.io/badge/Swift-5.9-orange?logo=swift)

---

## English

### What it does

ShortcutMac lives in your menu bar and shows a categorized shortcut reference overlay whenever you press **⌘⇧K**.  
It uses the Carbon `RegisterEventHotKey` API so **no Accessibility permission is required**.

**Shortcut categories included**

| Category | Examples |
|----------|---------|
| Basic editing | ⌘C, ⌘V, ⌘Z, ⌘A, ⌘F, ⌘S … |
| App / Window | ⌘Q, ⌘W, ⌘M, ⌘Tab, ⌘` … |
| Screenshot | ⌘⇧3, ⌘⇧4, ⌘⇧5 … |
| System | ⌘Space, ⌃⌘Q, ⌘⌥Esc … |
| Firefox | Navigation, Tabs, Bookmarks, DevTools … |
| Terminal | tmux, vim, zsh … |

### Requirements

- macOS 13 Ventura or later
- Swift 5.9 / Xcode 15 (or Swift toolchain via `swiftly`)

### Build & run

```bash
# Build release binary
make build          # → swift build -c release

# Deploy (restart via launchctl)
make deploy
```

Or manually:

```bash
swift build -c release
.build/release/ShortcutMac
```

The app hides from the Dock (`NSApp.setActivationPolicy(.accessory)`) and appears only as a menu-bar icon.

### Usage

| Action | Trigger |
|--------|---------|
| Show / hide shortcut overlay | **⌘⇧K** |
| Quit | Click the menu-bar icon → Quit |

---

## 한국어

### 무엇인가요

**⌘⇧K** 단축키 하나로 macOS 키보드 단축키 레퍼런스 오버레이를 바로 불러오는 메뉴바 앱입니다.  
Carbon `RegisterEventHotKey` API를 사용해 **손쉬운 사용(Accessibility) 권한이 필요 없습니다**.  
독(Dock)에는 아이콘이 표시되지 않고 메뉴바에만 존재합니다.

**포함된 단축키 카테고리**

| 카테고리 | 예시 |
|----------|------|
| 기본 편집 | ⌘C, ⌘V, ⌘Z, ⌘A, ⌘F, ⌘S … |
| 앱 / 윈도우 | ⌘Q, ⌘W, ⌘M, ⌘Tab, ⌘` … |
| 스크린샷 | ⌘⇧3, ⌘⇧4, ⌘⇧5 … |
| 시스템 | ⌘Space, ⌃⌘Q, ⌘⌥Esc … |
| Firefox | 내비게이션, 탭, 북마크, 개발자 도구 … |
| 터미널 | tmux, vim, zsh … |

### 요구사항

- macOS 13 Ventura 이상
- Swift 5.9 / Xcode 15 (또는 `swiftly`로 설치한 Swift 툴체인)

### 빌드 및 실행

```bash
# 릴리스 빌드
make build          # → swift build -c release

# 배포 (launchctl로 재시작)
make deploy
```

또는 직접:

```bash
swift build -c release
.build/release/ShortcutMac
```

앱은 독에서 숨겨지고(`NSApp.setActivationPolicy(.accessory)`) 메뉴바에만 아이콘으로 표시됩니다.

### 사용법

| 동작 | 트리거 |
|------|--------|
| 단축키 오버레이 표시 / 닫기 | **⌘⇧K** |
| 앱 종료 | 메뉴바 아이콘 클릭 → Quit |
