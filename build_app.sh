#!/bin/bash
set -e

APP_NAME="ShortcutMac"
BUILD_DIR=".build/release"
APP_DIR="dist/${APP_NAME}.app/Contents"

echo "빌드 중..."
swift build -c release

echo ".app 번들 생성 중..."
rm -rf dist
mkdir -p "${APP_DIR}/MacOS"

# 실행 파일 복사
cp "${BUILD_DIR}/${APP_NAME}" "${APP_DIR}/MacOS/${APP_NAME}"

# Info.plist 생성
cat > "${APP_DIR}/Info.plist" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleExecutable</key>
    <string>ShortcutMac</string>
    <key>CFBundleIdentifier</key>
    <string>com.local.ShortcutMac</string>
    <key>CFBundleName</key>
    <string>ShortcutMac</string>
    <key>CFBundlePackageType</key>
    <string>APPL</string>
    <key>CFBundleShortVersionString</key>
    <string>1.0</string>
    <key>CFBundleVersion</key>
    <string>1</string>
    <key>LSMinimumSystemVersion</key>
    <string>13.0</string>
    <key>LSUIElement</key>
    <true/>
    <key>NSHighResolutionCapable</key>
    <true/>
    <key>NSAccessibilityUsageDescription</key>
    <string>키보드 단축키 표시를 위해 접근성 권한이 필요합니다.</string>
</dict>
</plist>
EOF

# 실행 권한 부여
chmod +x "${APP_DIR}/MacOS/${APP_NAME}"

# ad-hoc 서명 (손상된 파일 오류 방지)
codesign --force --deep --sign - "dist/${APP_NAME}.app"

# quarantine 속성 제거
xattr -cr "dist/${APP_NAME}.app" 2>/dev/null || true

echo ""
echo "완료! dist/${APP_NAME}.app 생성됨"
echo ""
echo "전달 방법:"
echo "  1. dist/ 폴더의 ${APP_NAME}.app 을 zip으로 압축"
echo "  2. 카카오톡/이메일로 전달"
echo "  3. 받는 사람: zip 풀기 → 앱 우클릭 → '열기' → '열기' 클릭"
