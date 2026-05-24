#!/bin/bash
# Swift 파일 변경 감지 → 자동 빌드 & 서비스 재시작

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
LABEL="com.shortcutmac.app"

build_and_restart() {
    echo ""
    echo "🔨 변경 감지됨 — 빌드 시작..."

    if swift build -c release --package-path "$SCRIPT_DIR" 2>&1; then
        echo "✅ 빌드 성공 — 재시작 중..."
        launchctl stop "$LABEL"
        sleep 0.5
        launchctl start "$LABEL"
        echo "🚀 재시작 완료"
    else
        echo "❌ 빌드 실패 — 서비스 유지"
    fi
    echo ""
    echo "파일 변경 대기 중..."
}

echo "👀 파일 감시 시작 (Ctrl+C로 종료)"
echo "   대상: Sources/**/*.swift, Package.swift"
echo ""
echo "파일 변경 대기 중..."

fswatch -o --latency 1 \
    "$SCRIPT_DIR/Sources" \
    "$SCRIPT_DIR/Package.swift" \
| while read; do
    build_and_restart
done
