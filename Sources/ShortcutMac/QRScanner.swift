import AppKit

// 화면 영역을 드래그 캡처한 뒤 zbarimg로 QR 코드를 디코드한다.
// 결과는 클립보드에 복사되고 시스템 알림으로 표시된다.
// screencapture가 블로킹이므로 백그라운드 큐에서 호출할 것.
enum QRScanner {
    // zbarimg 후보 경로 (Apple Silicon / Intel Homebrew)
    private static let zbarCandidates = [
        "/opt/homebrew/bin/zbarimg",
        "/usr/local/bin/zbarimg",
    ]

    static func scan() {
        guard let zbarPath = zbarCandidates.first(where: { FileManager.default.isExecutableFile(atPath: $0) }) else {
            notify("zbar가 설치되지 않았습니다", "brew install zbar 를 실행하세요")
            return
        }

        let tmp = NSTemporaryDirectory() + "qr_\(UUID().uuidString).png"

        // 1) 영역 드래그 캡처
        let capture = Process()
        capture.executableURL = URL(fileURLWithPath: "/usr/sbin/screencapture")
        capture.arguments = ["-i", tmp]
        do {
            try capture.run()
        } catch {
            notify("캡처 실패", error.localizedDescription)
            return
        }
        capture.waitUntilExit()

        // 사용자가 ESC로 취소하면 파일이 없거나 비어 있음 → 조용히 종료
        let size = (try? FileManager.default.attributesOfItem(atPath: tmp)[.size] as? Int) ?? nil
        guard FileManager.default.fileExists(atPath: tmp), (size ?? 0) > 0 else {
            try? FileManager.default.removeItem(atPath: tmp)
            return
        }

        // 2) zbarimg 디코드
        let zbar = Process()
        zbar.executableURL = URL(fileURLWithPath: zbarPath)
        zbar.arguments = ["--raw", "-q", tmp]
        let outPipe = Pipe()
        zbar.standardOutput = outPipe
        zbar.standardError = FileHandle.nullDevice

        var output = ""
        do {
            try zbar.run()
            let data = outPipe.fileHandleForReading.readDataToEndOfFile()
            zbar.waitUntilExit()
            output = String(data: data, encoding: .utf8) ?? ""
        } catch {
            notify("디코드 실패", error.localizedDescription)
        }
        try? FileManager.default.removeItem(atPath: tmp)

        let result = output.trimmingCharacters(in: .whitespacesAndNewlines)
        if result.isEmpty {
            notify("QR Scan", "QR 코드를 찾을 수 없습니다")
            return
        }

        // 항상 클립보드에 복사
        DispatchQueue.main.async {
            NSPasteboard.general.clearContents()
            NSPasteboard.general.setString(result, forType: .string)
        }

        // 열 수 있는 링크면 기본 앱(브라우저 등)에서 바로 열기
        if let url = openableURL(from: result) {
            DispatchQueue.main.async { NSWorkspace.shared.open(url) }
            notify("QR Scan — 링크 열림 (복사됨)", result)
        } else {
            notify("QR Scan — 클립보드에 복사됨", result)
        }
    }

    // http/https 등 열 수 있는 스킴이면 URL을 돌려준다. 그 외(텍스트·WiFi·vCard)는 nil.
    private static func openableURL(from text: String) -> URL? {
        let openableSchemes: Set<String> = [
            "http", "https", "mailto", "tel", "facetime", "sms", "maps",
        ]
        guard let url = URL(string: text),
              let scheme = url.scheme?.lowercased(),
              openableSchemes.contains(scheme) else {
            return nil
        }
        return url
    }

    private static func notify(_ title: String, _ text: String) {
        let osa = Process()
        osa.executableURL = URL(fileURLWithPath: "/usr/bin/osascript")
        let safeText = text.replacingOccurrences(of: "\\", with: "\\\\")
            .replacingOccurrences(of: "\"", with: "\\\"")
        let safeTitle = title.replacingOccurrences(of: "\\", with: "\\\\")
            .replacingOccurrences(of: "\"", with: "\\\"")
        osa.arguments = ["-e", "display notification \"\(safeText)\" with title \"\(safeTitle)\" sound name \"Glass\""]
        try? osa.run()
    }
}
