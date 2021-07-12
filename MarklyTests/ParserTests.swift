//
//  ParserTests.swift
//  MarklyTests
//
//  Created by Ramon Torres on 6/15/21.
//  Copyright (c) 2021 Ramon Torres
//

import XCTest
@testable import Markly

class ParserTests: XCTestCase {

    func testParseSingleParagraph() throws {
        let parser = Parser()
        let result = parser.parse("Hello world.")

        // ROOT -> PARA -> TEXT("Hello world.")
        let expected = TokenNode(.ROOT, children: [
            TokenNode(.PARA, children: [
                TokenNode(.TEXT, content: "Hello world.")
            ])
        ])

        XCTAssertEqual(result, expected)
    }

    func testMultipleParagraphs() throws {
        let parser = Parser()
        let result = parser.parse("Hello world.\n\nHola mundo.")

        // ROOT -> PARA -> TEXT("Hello world.")
        //              └> TEXT("Hola Mundo.")
        let expected = TokenNode(.ROOT, children: [
            TokenNode(.PARA, children: [
                TokenNode(.TEXT, content: "Hello world.")
            ]),
            TokenNode(.PARA, children: [
                TokenNode(.TEXT, content: "Hola mundo.")
            ])
        ])

        XCTAssertEqual(result, expected)
    }

    func testLineBreak() throws {
        let parser = Parser()
        let result = parser.parse("Hello\nworld.")

        // ROOT -> PARA -> TEXT("Hello")
        //              └> LNBR
        //              └> TEXT("world.")
        let expected = TokenNode(.ROOT, children: [
            TokenNode(.PARA, children: [
                TokenNode(.TEXT, content: "Hello"),
                TokenNode(.LNBR),
                TokenNode(.TEXT, content: "world.")
            ])
        ])

        XCTAssertEqual(result, expected)
    }

    func testBoldText() throws {
        let parser = Parser()
        let result = parser.parse("Hello *world*.")

        // ROOT -> PARA -> TEXT("Hello ")
        //              └> BOLD -> TEXT("world")
        //              └> TEXT(".")
        let expected = TokenNode(.ROOT, children: [
            TokenNode(.PARA, children: [
                TokenNode(.TEXT, content: "Hello "),
                TokenNode(.BOLD, children: [
                    TokenNode(.TEXT, content: "world")
                ]),
                TokenNode(.TEXT, content: ".")
            ])
        ])

        XCTAssertEqual(result, expected)
    }

    func testList() throws {
        let parser = Parser()
        let result1 = parser.parse("* Item one\n* Item two")
        let result2 = parser.parse("- Item one\n- Item two")

        // ROOT -> LIST -> LITM -> TEXT("Item one")
        //              └> LITM -> TEXT("Item two")
        let expected = TokenNode(.ROOT, children: [
            TokenNode(.LIST, children: [
                TokenNode(.LITM, children: [
                    TokenNode(.TEXT, content: "Item one")
                ]),
                TokenNode(.LITM, children: [
                    TokenNode(.TEXT, content: "Item two")
                ])
            ])
        ])

        XCTAssertEqual(result1, expected)
        XCTAssertEqual(result2, expected)
    }

    func testEdgeCases() throws {
        let parser = Parser()
        let result = parser.parse("Hello world.\n\n* Item *one*\n* Item two")

        // ROOT -> LIST -> PARA -> TEXT("Hello world.")
        //              └> LITM -> TEXT("Item ")
        //                      └> LITM -> BOLD -> TEXT("one")
        //              └> LITM -> TEXT("Item two")
        let expected = TokenNode(.ROOT, children: [
            TokenNode(.PARA, children: [
                TokenNode(.TEXT, content: "Hello world.")
            ]),
            TokenNode(.LIST, children: [
                TokenNode(.LITM, children: [
                    TokenNode(.TEXT, content: "Item "),
                    TokenNode(.BOLD, children: [
                        TokenNode(.TEXT, content: "one")
                    ])
                ]),
                TokenNode(.LITM, children: [
                    TokenNode(.TEXT, content: "Item two")
                ])
            ])
        ])

        XCTAssertEqual(result, expected)
    }

}
