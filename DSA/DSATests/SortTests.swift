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
    
    func testSortMerging() {
        var arr:[Any] = [11,8,3,9,7,1,2,5]
        arr = Sort.MergingSort(arr:arr) {
            ($0 as! Int) < ($1 as! Int)
        }
        
        XCTAssertEqual("[1, 2, 3, 5, 7, 8, 9, 11]", "\(arr)")
        
    }
    
    func testSortQuick() {
        var arr:[Any] = [6,11,3,9,8]
        arr = Sort.QuickSort(arr: arr) {
            ($0 as! Int) < ($1 as! Int)
        }
        
        XCTAssertEqual("[3, 6, 8, 9, 11]", "\(arr)")
        
        arr = [11,8,3,9,7,1,2,5]
        arr = Sort.QuickSort(arr:arr) {
            ($0 as! Int) < ($1 as! Int)
        }

        XCTAssertEqual("[1, 2, 3, 5, 7, 8, 9, 11]", "\(arr)")
        
        arr = [11,8,3,9,7,1,2,5,12]
        var k = Sort.FindKthLargest(arr:arr, k: 9) {
            // 这里是找k大, 所以需要逆序, 大的在前
            ($0 as! Int) > ($1 as! Int)
        }
        
        XCTAssertEqual("1", "\(k)")
        
        arr = [12,23]
        k = Sort.FindKthLargest(arr:arr, k: 2) {
            // 这里是找k大, 所以需要逆序, 大的在前
            ($0 as! Int) > ($1 as! Int)
        }
        
        XCTAssertEqual("12", "\(k)")
    }
    
    func testCountingSort() {
        var arr = [11,8,3,9,7,1,2,5]
    }
}
