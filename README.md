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
| Basic editing | ⌘C, ⌘V, ⌘Z, ⌘A, ⌘F, ⌘S … ⌘+drag (force move), ⌘C→⌥⌘V (cut-move) |
| App / Window | ⌘Q, ⌘W, ⌘M, ⌘Tab, ⌘` … |
| Screenshot | ⌘⇧3, ⌘⇧4, ⌘⇧5 … |
| System | ⌘Space, ⌃⌘Q, ⌘⌥Esc … |
| Firefox | Navigation, Tabs, Bookmarks, DevTools … |
| Terminal | tmux, vim, zsh … |
| Tools | **⌃⌥Q** — scan a QR code on screen |

### QR code scanner (⌃⌥Q)

Press **⌃⌥Q**, drag to select a region containing a QR code. The result is
copied to the clipboard, and if it's a URL it opens in your default browser.
Capture goes to a temp file, decoded with `zbarimg`, then deleted.

### Requirements

- macOS 13 Ventura or later
- Swift 5.9 / Xcode 15 (or Swift toolchain via `swiftly`)
- `zbar` (for QR scanning): `brew install zbar`

### Build & run

```bash
# (once) create a self-signed code-signing certificate
make cert

# build the signed .app bundle and restart via launchctl
make deploy
```

Or just the raw binary (no signing):

```bash
make build          # → swift build -c release
.build/release/ShortcutMac
```

The app hides from the Dock (`NSApp.setActivationPolicy(.accessory)`) and appears only as a menu-bar icon.

**Why the certificate?** macOS asks for Screen Recording permission the first
time the app captures the screen. With a stable self-signed certificate, the
permission survives rebuilds (the cdhash can change without TCC re-prompting).
No paid Apple Developer account is needed. The first capture still prompts
once — allow it, and you're set.

### Usage

| Action | Trigger |
|--------|---------|
| Show / hide shortcut overlay | **⌘⇧K** |
| Scan a QR code on screen | **⌃⌥Q** |
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
| 기본 편집 | ⌘C, ⌘V, ⌘Z, ⌘A, ⌘F, ⌘S … ⌘+드래그 (강제 이동), ⌘C→⌥⌘V (잘라내기 이동) |
| 앱 / 윈도우 | ⌘Q, ⌘W, ⌘M, ⌘Tab, ⌘` … |
| 스크린샷 | ⌘⇧3, ⌘⇧4, ⌘⇧5 … |
| 시스템 | ⌘Space, ⌃⌘Q, ⌘⌥Esc … |
| Firefox | 내비게이션, 탭, 북마크, 개발자 도구 … |
| 터미널 | tmux, vim, zsh … |
| 도구 | **⌃⌥Q** — 화면의 QR 코드 스캔 |

### QR 코드 스캐너 (⌃⌥Q)

**⌃⌥Q**를 누르고 QR 코드가 있는 영역을 드래그하면, 디코드 결과가
클립보드에 복사되고 URL이면 기본 브라우저에서 자동으로 열립니다.
캡처는 임시 파일로 저장 → `zbarimg`로 디코드 → 삭제됩니다.

### 요구사항

- macOS 13 Ventura 이상
- Swift 5.9 / Xcode 15 (또는 `swiftly`로 설치한 Swift 툴체인)
- `zbar` (QR 스캔용): `brew install zbar`

### 빌드 및 실행

```bash
# (최초 1회) 코드 서명용 자체 서명 인증서 생성
make cert

# 서명된 .app 번들 빌드 + launchctl 재시작
make deploy
```

또는 서명 없이 바이너리만:

```bash
make build          # → swift build -c release
.build/release/ShortcutMac
```

앱은 독에서 숨겨지고(`NSApp.setActivationPolicy(.accessory)`) 메뉴바에만 아이콘으로 표시됩니다.

**인증서가 왜 필요한가요?** macOS는 앱이 처음 화면을 캡처할 때 화면 녹화
권한을 요구합니다. 안정적인 자체 서명 인증서로 서명하면 재빌드해도 권한이
유지됩니다(cdhash가 바뀌어도 TCC가 다시 묻지 않음). 유료 Apple 개발자 계정은
필요 없습니다. 첫 캡처 때 권한 팝업이 한 번 뜨는데, 허용하면 끝입니다.

### 사용법

| 동작 | 트리거 |
|------|--------|
| 단축키 오버레이 표시 / 닫기 | **⌘⇧K** |
| 화면의 QR 코드 스캔 | **⌃⌥Q** |
| 앱 종료 | 메뉴바 아이콘 클릭 → Quit |
