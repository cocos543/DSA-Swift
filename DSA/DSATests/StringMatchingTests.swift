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

}
