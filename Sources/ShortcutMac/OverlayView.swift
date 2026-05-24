import SwiftUI

struct OverlayView: View {
    let onDismiss: () -> Void

    var body: some View {
        ZStack {
            Color(red: 0.05, green: 0.05, blue: 0.1)
                .opacity(0.93)
                .ignoresSafeArea()

            GeometryReader { geo in
                let isSmall = geo.size.height < 900
                let vSpacing: CGFloat = isSmall ? 16 : 24
                let hPad: CGFloat = isSmall ? 32 : 48
                let topPad: CGFloat = isSmall ? 32 : 48

                VStack(spacing: vSpacing) {
                    headerView(small: isSmall)

                    HStack(alignment: .top, spacing: 20) {
                        LazyVGrid(
                            columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 2),
                            spacing: 16
                        ) {
                            ForEach(shortcutCategories) { category in
                                CategoryCard(category: category, small: isSmall)
                            }
                        }
                        .frame(maxWidth: .infinity)

                        CategoryCard(category: rectangleCategory, small: isSmall, compact: true)
                            .fixedSize(horizontal: true, vertical: false)
                            .frame(maxHeight: .infinity, alignment: .top)
                    }
                    .padding(.horizontal, hPad)

                    Text("ESC 또는 화면 클릭으로 닫기")
                        .font(.system(size: isSmall ? 12 : 14))
                        .foregroundColor(.white.opacity(0.3))
                }
                .padding(.top, topPad)
                .padding(.bottom, isSmall ? 24 : 36)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .onTapGesture { onDismiss() }
    }

    private func headerView(small: Bool) -> some View {
        VStack(spacing: 6) {
            Text("macOS 기본 단축키")
                .font(.system(size: small ? 28 : 36, weight: .bold))
                .foregroundColor(.white)
            Text("자주 사용하는 키보드 단축키 모음")
                .font(.system(size: small ? 13 : 15))
                .foregroundColor(.white.opacity(0.45))
        }
    }
}

struct CategoryCard: View {
    let category: ShortcutCategory
    var small: Bool = false
    var compact: Bool = false

    var body: some View {
        let keySize: CGFloat = small ? 12 : 13
        let descSize: CGFloat = small ? 12 : 13
        let headerSize: CGFloat = small ? 14 : 16
        let iconSize: CGFloat = small ? 15 : 18
        let keyWidth: CGFloat = compact ? (small ? 76 : 86) : (small ? 105 : 120)
        let pad: CGFloat = small ? 14 : 18
        let vSpacing: CGFloat = small ? 8 : 10
        let rowPad: CGFloat = small ? 1 : 2

        VStack(alignment: .leading, spacing: vSpacing) {
            HStack(spacing: 6) {
                Text(category.icon)
                    .font(.system(size: iconSize))
                Text(category.name)
                    .font(.system(size: headerSize, weight: .semibold))
                    .foregroundColor(.white)
            }

            Divider()
                .background(Color.white.opacity(0.12))
                .padding(.vertical, 1)

            ForEach(category.items) { item in
                if item.isHeader {
                    Text(item.description.uppercased())
                        .font(.system(size: 10, weight: .semibold))
                        .foregroundColor(.white.opacity(0.35))
                        .padding(.top, 6)
                } else {
                    HStack(spacing: 0) {
                        Text(spacedKey(item.key))
                            .font(.system(size: keySize, weight: .semibold, design: .monospaced))
                            .foregroundColor(Color(red: 1.0, green: 0.84, blue: 0.2))
                            .frame(width: keyWidth, alignment: .leading)

                        Text(item.description)
                            .font(.system(size: descSize))
                            .foregroundColor(.white.opacity(0.85))

                        if !compact { Spacer(minLength: 0) }
                    }
                    .padding(.vertical, rowPad)
                }
            }
        }
        .padding(pad)
        .frame(maxWidth: compact ? nil : .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color.white.opacity(0.06))
        .cornerRadius(14)
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(Color.white.opacity(0.09), lineWidth: 1)
        )
    }
}

// 수식키 기호(⌘⇧⌥⌃)는 한 글자씩 분리, Space/Tab 등 단어는 그대로 유지
private func spacedKey(_ key: String) -> String {
    let modifiers: Set<Character> = ["⌘", "⇧", "⌥", "⌃"]
    var tokens: [String] = []
    var word = ""

    for char in key {
        if modifiers.contains(char) {
            if !word.isEmpty { tokens.append(word); word = "" }
            tokens.append(String(char))
        } else if char == " " {
            if !word.isEmpty { tokens.append(word); word = "" }
        } else {
            word.append(char)
        }
    }
    if !word.isEmpty { tokens.append(word) }

    return tokens.joined(separator: " ")
}
