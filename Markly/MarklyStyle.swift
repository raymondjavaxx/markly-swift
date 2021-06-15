//
//  MarklyStyle.swift
//  Markly
//
//  Created by Ramon Torres on 6/14/21.
//

#if canImport(UIKit)
import UIKit
#elseif os(macOS)
import AppKit
#endif

#if canImport(UIKit)
private extension UIColor {
    class var defaultMarklyColor: UIColor {
        if #available(iOS 13.0, *) {
            return self.label
        } else {
            return self.black
        }
    }
}
#elseif os(macOS)
private extension NSColor {
    class var defaultMarklyColor: NSColor { self.labelColor }
}
#endif

public struct MarklyStyle {
#if canImport(UIKit)
    public typealias Color = UIColor
    public typealias Font = UIFont
#elseif os(macOS)
    public typealias Color = NSColor
    public typealias Font = NSFont
#endif

    /// Color of the text.
    public let color: Color

    /// Default font.
    public let font: Font

    /// Font for bold text.
    public let boldFont: Font

    /// Font for rendering bullet points
    public let bulletFont: Font?

    /// Bullet point character
    public let bulletPointCharacter: Character

    public init(
        color: Color,
        font: Font,
        boldFont: Font,
        bulletFont: Font? = nil,
        bulletPointCharacter: Character = "•"
    ) {
        self.color = color
        self.font = font
        self.boldFont = boldFont
        self.bulletFont = bulletFont
        self.bulletPointCharacter = bulletPointCharacter
    }

    /// Default Markly style.
    public static let `default` = MarklyStyle(
        color: Color.defaultMarklyColor,
        font: Font.systemFont(ofSize: Font.systemFontSize),
        boldFont: Font.boldSystemFont(ofSize: Font.systemFontSize),
        bulletFont: Font.boldSystemFont(ofSize: Font.systemFontSize)
    )
}

extension MarklyStyle {

    var defaultTextAttributes: [NSAttributedString.Key: Any] {
        return [
            .font: self.font,
            .foregroundColor: self.color
        ]
    }

    var boldTextAttributes: [NSAttributedString.Key: Any] {
        return [
            .font: self.boldFont,
            .foregroundColor: self.color
        ]
    }

    var bulletTextAttributes: [NSAttributedString.Key: Any] {
        return [
            .font: self.bulletFont ?? self.font,
            .foregroundColor: self.color
        ]
    }

}
