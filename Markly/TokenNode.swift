//
//  TokenNode.swift
//  Markly
//
//  Created by Ramon Torres on 5/1/21.
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
