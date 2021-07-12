//
//  NSAttributedString+Render.swift
//  Markly
//
//  Created by Ramon Torres on 5/2/21.
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

import Foundation

public extension NSAttributedString {

    /// Creates an attributed string from a Markly-formatted string.
    /// - Parameters:
    ///   - markly: Markly-formatted string.
    ///   - style: Markly styling configuration.
    convenience init(markly: String, style: MarklyStyle = .default) {
        let parser = Parser()
        let root = parser.parse(markly)
        let attributedString = Self.render(root.children, style: style)
        self.init(attributedString: attributedString)
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
