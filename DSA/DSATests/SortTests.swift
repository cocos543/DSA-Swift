//
//  SortTests.swift
//  DSATests
//
//  Created by Cocos on 2019/5/30.
//  Copyright © 2019 Cocos. All rights reserved.
//

import XCTest
@testable import DSA

class SortTests: XCTestCase {
    func testBubbleSort() {
        var arr:[Any] = [4,5,6,3,2,1]
        arr = Sort.BubbleSort(arr: arr) {
            ($0 as! Int) < ($1 as! Int)
        }
        XCTAssertEqual("[1, 2, 3, 4, 5, 6]", "\(arr)")
        
        arr = ["c", "c", "d", "a", "b", "e", "f"]
        arr = Sort.BubbleSort(arr: arr) {
            ($0 as! String) < ($1 as! String)
        }
        
        XCTAssertEqual("""
["a", "b", "c", "c", "d", "e", "f"]
"""
            , "\(arr)")
    }
    
    func testStraightInsertionSort() {
        var arr:[Any] = [4,5,6,1,2,3]
        arr = Sort.StraightInsertionSort(arr: arr, cmp: {
            ($0 as! Int) < ($1 as! Int)
        })
        XCTAssertEqual("[1, 2, 3, 4, 5, 6]", "\(arr)")
    }
    
    func testSelectionSort() {
        var arr:[Any] = [4,5,6,3,2,1]
        arr = Sort.SelectionSort(arr: arr, cmp: {
            ($0 as! Int) < ($1 as! Int)
        })
        XCTAssertEqual("[1, 2, 3, 4, 5, 6]", "\(arr)")
    }
}
