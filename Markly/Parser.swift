//
//  Parser.swift
//  Markly
//
//  Created by Ramon Torres on 5/1/21.
//

/// Markly parser
struct Parser {

    /// Parse Markly formatted text.
    /// - Parameter text: Markly formatted text.
    /// - Returns: Root node of the of the Abstract Syntax Tree resulting from parsing the Markly formatted text.
    func parse(_ text: String) -> TokenNode {
        let result = TokenNode(.ROOT)

        let chunks = extractChunks(text)

        for chunk in chunks {
            result.append(nodes: parseChunk(chunk))
        }

        return result
    }

}

private extension Parser {

    func parseChunk(_ chunk: String) -> [TokenNode] {
        let lines = extractLines(chunk)

        let isList: Bool = (
            lines.count > 1 &&
            (
                lines.allSatisfy { $0.starts(with: "* ") } ||
                lines.allSatisfy { $0.starts(with: "- ") }
            )
        )

        if isList {
            let listNode = TokenNode(.LIST)

            for line in lines {
                // Consume asterisk/dash and space
                let text = line[line.index(line.startIndex, offsetBy: 2)...]
                listNode.append(
                    TokenNode(.LITM, children: parseLine(String(text)))
                )
            }

            return [
                listNode
            ]
        }

        let paragraphNode = TokenNode(.PARA)
        paragraphNode.append(nodes: parseLine(chunk))
        return [
            paragraphNode
        ]
    }

    func parseLine(_ line: String) -> [TokenNode] {
        var cursor: String.Index = line.startIndex

        var lastSegmentStart = line.startIndex
        var nodeStack = Stack<String.Index>()

        var nodes: [TokenNode] = []

        while true {
            guard let next = line.indexOf("*", from: cursor) else { break }

            cursor = next

            if let start = nodeStack.pop() {
                if lastSegmentStart < start {
                    let text = line[lastSegmentStart..<start]
                    nodes.append(contentsOf: parseLineBreaks(text))
                }

                let text = line[line.index(after: start)..<cursor]

                let boldNode = TokenNode(.BOLD, children: parseLineBreaks(text))
                nodes.append(boldNode)

                lastSegmentStart = line.index(after: cursor)
            } else {
                nodeStack.push(next)
            }

            cursor = line.index(next, offsetBy: 1)
        }

        if lastSegmentStart < line.endIndex {
            let text = line[lastSegmentStart...]
            nodes.append(contentsOf: parseLineBreaks(text))
        }

        return nodes
    }

    func parseLineBreaks(_ text: String.SubSequence) -> [TokenNode] {
        var nodes: [TokenNode] = []

        let parts = text.split(separator: "\n")

        for (index, part) in parts.enumerated() {
            if index >= 1 {
                nodes.append(TokenNode(.LNBR))
            }

            nodes.append(TokenNode(.TEXT, content: String(part)))
        }

        return nodes
    }

    func extractLines(_ text: String) -> [String] {
        let lines = text.split(separator: "\n")
        return lines.map { $0.trimmingCharacters(in: .whitespaces) }
    }

    func extractChunks(_ text: String) -> [String] {
        let text = text.replacingOccurrences(of: "\n\r", with: "\n")
        return text.components(separatedBy: "\n\n")
    }

}
