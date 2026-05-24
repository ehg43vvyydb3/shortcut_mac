import SwiftUI

struct OverlayView: View {
    let onDismiss: () -> Void

    var body: some View {
        ZStack {
            Color(red: 0.05, green: 0.05, blue: 0.1)
                .opacity(0.93)
                .ignoresSafeArea()

            VStack(spacing: 32) {
                headerView

                // 2×2 바둑판식 배치
                LazyVGrid(
                    columns: Array(repeating: GridItem(.flexible(), spacing: 24), count: 2),
                    spacing: 24
                ) {
                    ForEach(shortcutCategories) { category in
                        CategoryCard(category: category)
                    }
                }
                .padding(.horizontal, 80)

                Text("ESC 또는 화면을 클릭하면 닫힙니다")
                    .font(.system(size: 14))
                    .foregroundColor(.white.opacity(0.3))
            }
            .padding(.top, 80)
            .padding(.bottom, 48)
        }
        .onTapGesture { onDismiss() }
    }

    private var headerView: some View {
        VStack(spacing: 8) {
            Text("macOS 기본 단축키")
                .font(.system(size: 38, weight: .bold))
                .foregroundColor(.white)
            Text("자주 사용하는 키보드 단축키 모음")
                .font(.system(size: 16))
                .foregroundColor(.white.opacity(0.45))
        }
    }
}

struct CategoryCard: View {
    let category: ShortcutCategory

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(spacing: 8) {
                Text(category.icon)
                    .font(.system(size: 20))
                Text(category.name)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
            }

            Divider()
                .background(Color.white.opacity(0.12))
                .padding(.vertical, 2)

            ForEach(category.items) { item in
                HStack(spacing: 0) {
                    Text(spacedKey(item.key))
                        .font(.system(size: 15, weight: .semibold, design: .monospaced))
                        .foregroundColor(Color(red: 1.0, green: 0.84, blue: 0.2))
                        .frame(width: 130, alignment: .leading)

                    Text(item.description)
                        .font(.system(size: 15))
                        .foregroundColor(.white.opacity(0.85))

                    Spacer(minLength: 0)
                }
                .padding(.vertical, 3)
            }
        }
        .padding(24)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
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
