//
//  TokenNode.swift
//  Markly
//
//  Created by Ramon Torres on 5/1/21.
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

/// Markly Abstract Syntax Tree node
final class TokenNode {

    enum NodeType {
        /// Root node.
        case ROOT
        /// Paragraph.
        case PARA
        /// Unordered list.
        case LIST
        /// List item.
        case LITM
        /// Text.
        case TEXT
        /// Line break.
        case LNBR
        /// Bold text.
        case BOLD
    }

    /// Type of node.
    let type: NodeType

    /// Optional content for the node.
    let content: String?

    /// Children nodes.
    var children: [TokenNode]

    init(_ type: NodeType, content: String? = nil, children: [TokenNode] = []) {
        self.type = type
        self.content = content
        self.children = children
    }

    func append(_ node: TokenNode) {
        children.append(node)
    }

    func append(nodes: [TokenNode]) {
        children.append(contentsOf: nodes)
    }

}

extension TokenNode: Equatable {

    static func == (lhs: TokenNode, rhs: TokenNode) -> Bool {
        return (
            lhs.type == rhs.type &&
            lhs.content == rhs.content &&
            lhs.children == rhs.children
        )
    }

}
