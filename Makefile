.PHONY: build app deploy cert

build:
	swift build -c release

# 자체 서명 인증서로 .app 번들 빌드 (권한 유지)
app:
	./build_app.sh

# 코드 서명용 자체 서명 인증서 1회 생성
cert:
	./create_cert.sh

# .app 빌드 후 launchd 재시작
deploy: app
	launchctl kickstart -k gui/$$(id -u)/com.shortcutmac.app
