//
//  StringMatchingTests.swift
//  DSATests
//
//  Created by Cocos on 2019/6/19.
//  Copyright © 2019 Cocos. All rights reserved.
//

import XCTest
@testable import DSA

class StringMatchingTests: XCTestCase {
    func testBF() {
        let str = "hello"
        XCTAssertEqual(-1, StringMatching.BruteForce(str: str, pattern: "ol"))
        XCTAssertEqual(2, StringMatching.BruteForce(str: str, pattern: "ll"))
        XCTAssertEqual(3, StringMatching.BruteForce(str: str, pattern: "lo"))
    }
    
    func testBoyerMoore() {
        var str = ""
        str = "ACABCBCABCABC"
        XCTAssertEqual(6, StringMatching.BoyerMoore(str: str, pattern: "CABCAB"))
        
        str = "GCTTCTGCTACCTTTTGCGCGCGCGCGGAA"
        XCTAssertEqual(10, StringMatching.BoyerMoore(str: str, pattern: "CCTTTTGC"))
        
        str = "CGTGCCTACTTACTTACTTACTTACGCGAA"
        XCTAssertEqual(8, StringMatching.BoyerMoore(str: str, pattern: "CTTACTTAC"))
        
        str = "投资赚钱工作赚钱生意赚钱😂🤣"
        XCTAssertEqual(10, StringMatching.BoyerMoore(str: str, pattern: "赚钱😂"))
        XCTAssertEqual(-1, StringMatching.BoyerMoore(str: str, pattern: "😂😂"))
    }
    
    func testKMP() {
        var str = ""
        str = "abababzabababcdef"
        print(StringMatching.KMP(str: str, pattern: "abababzabababa"))
    }

}
