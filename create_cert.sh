#!/bin/bash
# 코드 서명용 자체 서명 인증서를 1회 생성해 로그인 키체인에 등록한다.
# 이 인증서로 서명하면 재빌드(cdhash 변경) 후에도 TCC 권한이 유지된다.
# Apple 개발자 인증서(유료)는 필요 없다.
set -e

CERT_NAME="ShortcutMac Self-Signed"

if security find-certificate -c "$CERT_NAME" >/dev/null 2>&1; then
    echo "✓ '$CERT_NAME' 인증서가 이미 존재합니다."
    exit 0
fi

TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

cat > "$TMP/cert.conf" <<EOF
[ req ]
distinguished_name = req_dn
x509_extensions = v3_ext
prompt = no
[ req_dn ]
CN = $CERT_NAME
[ v3_ext ]
keyUsage = critical, digitalSignature
extendedKeyUsage = critical, codeSigning
basicConstraints = critical, CA:false
EOF

echo "==> 키 + 자체 서명 인증서 생성 (유효기간 10년)..."
openssl req -x509 -newkey rsa:2048 -keyout "$TMP/key.pem" -out "$TMP/cert.pem" \
    -days 3650 -nodes -config "$TMP/cert.conf" 2>/dev/null

echo "==> PKCS#12 묶기 (macOS 호환 -legacy 형식)..."
openssl pkcs12 -export -legacy -inkey "$TMP/key.pem" -in "$TMP/cert.pem" \
    -out "$TMP/cert.p12" -name "$CERT_NAME" -passout pass:shortcutmac 2>/dev/null

echo "==> 로그인 키체인에 등록..."
security import "$TMP/cert.p12" -k ~/Library/Keychains/login.keychain-db \
    -P "shortcutmac" -T /usr/bin/codesign -A

echo ""
echo "✓ '$CERT_NAME' 인증서 생성 완료. 이제 ./build_app.sh 로 빌드하세요."
