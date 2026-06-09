#!/bin/bash
# .app 번들을 만들고 안정적인 자체 서명 인증서로 코드 서명한다.
# 자체 서명 인증서로 서명하면 cdhash가 바뀌어도 TCC(화면 녹화 등) 권한이 유지된다.
set -e

cd "$(dirname "$0")"

SIGN_ID="ShortcutMac Self-Signed"
APP="dist/ShortcutMac.app"

echo "==> Building (release)..."
swift build -c release

echo "==> Assembling app bundle..."
rm -rf "$APP"
mkdir -p "$APP/Contents/MacOS"
cp .build/release/ShortcutMac "$APP/Contents/MacOS/ShortcutMac"
cp Info.plist "$APP/Contents/Info.plist"

echo "==> Code signing..."
if security find-certificate -c "$SIGN_ID" >/dev/null 2>&1; then
    codesign --force --options runtime --sign "$SIGN_ID" "$APP"
    echo "    Signed with: $SIGN_ID"
else
    echo "    ⚠️  '$SIGN_ID' 인증서를 찾을 수 없습니다. ad-hoc 서명으로 대체합니다."
    echo "    (영구 권한 유지를 위해 create_cert.sh 를 먼저 실행하세요)"
    codesign --force --sign - "$APP"
fi

echo "==> Verifying..."
codesign -dvvv "$APP" 2>&1 | grep -E "Authority|Identifier=" || true

echo ""
echo "✓ Built: $APP"
