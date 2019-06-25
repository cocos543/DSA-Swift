//
//  ACTreeTests.swift
//  DSATests
//
//  Created by Cocos on 2019/6/25.
//  Copyright © 2019 Cocos. All rights reserved.
//

import XCTest
@testable import DSA

class ACTreeTests: XCTestCase {

    func testACTree() {
        let acTree = ACTree()
        let words = ["how", "hello", "hi", "her", "so", "see", "security", "中国", "中国人", "中华田园犬"]
        for str in words {
            acTree.Insert(str: str)
        }
        
        XCTAssertEqual(true, acTree.Delete(str: "hello"))
    }
    
    func testACTreeMatch() {
        let acTree = ACTree()
        let words = ["abce", "bcd", "ce", "ec"]
        for str in words {
            acTree.Insert(str: str)
        }
        
        print(acTree.Match(str: "abcdaaaacecece"))
        
        
    }

}
