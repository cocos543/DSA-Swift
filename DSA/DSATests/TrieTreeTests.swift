//
//  TrieTreeTests.swift
//  DSATests
//
//  Created by Cocos on 2019/6/24.
//  Copyright © 2019 Cocos. All rights reserved.
//

import XCTest

@testable import DSA

class TrieTreeTests: XCTestCase {

    func testTrie() {
        let tTree = TrieTree()
        let words = ["how", "hello", "hi", "her", "so", "see", "security", "中国", "中国人", "中华田园犬"]
        for str in words {
            tTree.Insert(str: str)
        }
        
        print(tTree.FindPrefix(prefix: "he"))
        print(tTree.FindPrefix(prefix: "s"))
        print(tTree.FindPrefix(prefix: "中国"))
        print(tTree.FindPrefix(prefix: "中国人"))
        
    }

}
