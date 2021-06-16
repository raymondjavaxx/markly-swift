//
//  MarklyStyle.swift
//  Markly
//
//  Created by Ramon Torres on 6/14/21.
//
//  Copyright (c) 2021 Ramon Torres
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
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

/// Markly styling configuration
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
