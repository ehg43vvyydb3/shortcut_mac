import SwiftUI
import AppKit

struct OverlayView: View {
    let onDismiss: () -> Void

    private var menuBarHeight: CGFloat {
        guard let screen = NSScreen.main else { return 37 }
        return screen.frame.maxY - screen.visibleFrame.maxY
    }

    var body: some View {
        ZStack {
            Color(red: 0.05, green: 0.05, blue: 0.1)
                .opacity(0.93)
                .ignoresSafeArea()

            GeometryReader { geo in
                let small = geo.size.height < 1000

                VStack(spacing: small ? 12 : 18) {
                    HStack(alignment: .top, spacing: 14) {
                        VStack(alignment: .leading, spacing: 10) {
                            // 상단: 기본 4카드 — 콘텐츠 높이만큼만
                            HStack(alignment: .top, spacing: 10) {
                                ForEach(shortcutCategories.prefix(4)) { cat in
                                    CategoryCard(category: cat, small: small)
                                }
                            }
                            // 하단: Firefox (2열) + iTerm2 — 나머지 공간 채움
                            HStack(alignment: .top, spacing: 10) {
                                CategoryCard(
                                    category: shortcutCategories[4],
                                    small: small,
                                    twoColumn: true,
                                    fillHeight: true
                                )
                                CategoryCard(
                                    category: shortcutCategories[5],
                                    small: small,
                                    fillHeight: true
                                )
                                .frame(maxWidth: 230)
                            }
                            .frame(maxHeight: .infinity)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)

                        VStack(alignment: .leading, spacing: 10) {
                            CategoryCard(category: rectangleCategory, small: small, compact: true)
                                .fixedSize(horizontal: true, vertical: false)
                            CategoryCard(category: utilsCategory, small: small, compact: true)
                                .fixedSize(horizontal: true, vertical: false)
                        }
                        .frame(maxHeight: .infinity, alignment: .top)
                    }
                    .padding(.horizontal, small ? 28 : 44)
                    .frame(maxHeight: .infinity)

                    Text("ESC 또는 화면 클릭으로 닫기")
                        .font(.system(size: 12))
                        .foregroundColor(.white.opacity(0.3))
                }
                .padding(.top, menuBarHeight + (small ? 12 : 20))
                .padding(.bottom, small ? 18 : 30)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .onTapGesture { onDismiss() }
    }

}

struct CategoryCard: View {
    let category: ShortcutCategory
    var small: Bool = false
    var compact: Bool = false
    var twoColumn: Bool = false
    var fillHeight: Bool = false

    var body: some View {
        let keySize: CGFloat   = small ? 12 : 13
        let descSize: CGFloat  = small ? 12 : 13
        let titleSize: CGFloat = small ? 14 : 16
        let iconSize: CGFloat  = small ? 15 : 18
        let keyWidth: CGFloat  = compact ? (small ? 76 : 86) : (small ? 105 : 120)
        let pad: CGFloat       = small ? 14 : 18
        let vSpc: CGFloat      = small ? 8 : 10

        VStack(alignment: .leading, spacing: vSpc) {
            HStack(spacing: 6) {
                Text(category.icon).font(.system(size: iconSize))
                Text(category.name)
                    .font(.system(size: titleSize, weight: .semibold))
                    .foregroundColor(.white)
            }
            Divider().background(Color.white.opacity(0.12)).padding(.vertical, 1)

            if twoColumn {
                twoColumnContent(vSpc: vSpc, keySize: keySize, descSize: descSize, keyWidth: keyWidth)
            } else {
                ForEach(category.items) { item in
                    itemRow(item, keySize: keySize, descSize: descSize, keyWidth: keyWidth)
                }
            }
        }
        .padding(pad)
        .frame(
            maxWidth: compact ? nil : .infinity,
            maxHeight: fillHeight ? .infinity : nil,
            alignment: .topLeading
        )
        .background(Color.white.opacity(0.06))
        .cornerRadius(14)
        .overlay(RoundedRectangle(cornerRadius: 14).stroke(Color.white.opacity(0.09), lineWidth: 1))
    }

    @ViewBuilder
    private func twoColumnContent(vSpc: CGFloat, keySize: CGFloat, descSize: CGFloat, keyWidth: CGFloat) -> some View {
        let sections = bySections(category.items)
        let mid   = (sections.count + 1) / 2
        let left  = Array(sections.prefix(mid).joined())
        let right = Array(sections.dropFirst(mid).joined())

        HStack(alignment: .top, spacing: 12) {
            VStack(alignment: .leading, spacing: vSpc) {
                ForEach(left)  { item in itemRow(item, keySize: keySize, descSize: descSize, keyWidth: keyWidth) }
            }
            .frame(maxWidth: .infinity, alignment: .topLeading)

            VStack(alignment: .leading, spacing: vSpc) {
                ForEach(right) { item in itemRow(item, keySize: keySize, descSize: descSize, keyWidth: keyWidth) }
            }
            .frame(maxWidth: .infinity, alignment: .topLeading)
        }
    }

    @ViewBuilder
    private func itemRow(_ item: ShortcutItem, keySize: CGFloat, descSize: CGFloat, keyWidth: CGFloat) -> some View {
        if item.isHeader {
            Text(item.description.uppercased())
                .font(.system(size: 10, weight: .semibold))
                .foregroundColor(.white.opacity(0.35))
                .padding(.top, 5)
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
            .padding(.vertical, 1)
        }
    }

    private func bySections(_ items: [ShortcutItem]) -> [[ShortcutItem]] {
        var result: [[ShortcutItem]] = []
        var cur: [ShortcutItem] = []
        for item in items {
            if item.isHeader && !cur.isEmpty { result.append(cur); cur = [] }
            cur.append(item)
        }
        if !cur.isEmpty { result.append(cur) }
        return result
    }
}

private func spacedKey(_ key: String) -> String {
    let mods: Set<Character> = ["⌘", "⇧", "⌥", "⌃"]
    var tokens: [String] = []
    var word = ""
    for ch in key {
        if mods.contains(ch) {
            if !word.isEmpty { tokens.append(word); word = "" }
            tokens.append(String(ch))
        } else if ch == " " {
            if !word.isEmpty { tokens.append(word); word = "" }
        } else {
            word.append(ch)
        }
    }
    if !word.isEmpty { tokens.append(word) }
    return tokens.joined(separator: " ")
}
