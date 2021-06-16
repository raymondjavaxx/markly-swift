//
//  NSAttributedString+Render.swift
//  Markly
//
//  Created by Ramon Torres on 5/2/21.
//

import Foundation

public extension NSAttributedString {

    /// Creates and returns an `NSAttributedString` from a Markly-formatted string.
    /// - Parameters:
    ///   - text: Markly-formatted string.
    ///   - style: Markly styling configuration.
    /// - Returns: Attributed string resulting from parsing and converting the Markly-formatted content.
    static func markly(_ text: String, style: MarklyStyle = .default) -> NSAttributedString {
        let parser = Parser()
        let root = parser.parse(text)
        return Self.render(root.children, style: style)
    }

}

extension NSAttributedString {

    // swiftlint:disable cyclomatic_complexity
    static func render(_ nodes: [TokenNode], style: MarklyStyle) -> NSMutableAttributedString {
        let result = NSMutableAttributedString()

        for node in nodes {
            switch node.type {
            case .ROOT:
                result.append(render(node.children, style: style))
            case .PARA:
                result.append(render(node.children, style: style))
            case .TEXT:
                guard let text = node.content else {
                    fatalError("Missing text content")
                }

                result.append(NSAttributedString(string: text, attributes: style.defaultTextAttributes))
            case .LIST:
                result.append(render(node.children, style: style))
            case .LITM:
                result.append(NSAttributedString(
                    string: "\(style.bulletPointCharacter) ",
                    attributes: style.bulletTextAttributes
                ))

                result.append(render(node.children, style: style))
            case .BOLD:
                let content = render(node.children, style: style)
                content.setAttributes(style.boldTextAttributes, range: NSRange(location: 0, length: content.length))
                result.append(content)
            case .LNBR:
                result.append(NSAttributedString(string: "\n"))
            }

            // Line breaks between elements
            if node !== nodes.last {
                switch node.type {
                case .LIST, .PARA:
                    result.append(NSAttributedString(string: "\n\n", attributes: style.defaultTextAttributes))
                case .LITM:
                    result.append(NSAttributedString(string: "\n", attributes: style.defaultTextAttributes))
                default:
                    break
                }

            }
        }

        return result
    }
    // swiftlint:enable cyclomatic_complexity

}
