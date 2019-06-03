//
//  SearchTests.swift
//  DSATests
//
//  Created by Cocos on 2019/6/3.
//  Copyright © 2019 Cocos. All rights reserved.
//

import XCTest
@testable import DSA

class SearchTests: XCTestCase {

    func testBinarySearch() {
        let arr = [1,3,4,5,7,8,9,12,14,17,19,20]
        let index = Search.BinarySearch(arr: arr, target: 1) {
            if ($0 as! Int) == ($1 as! Int) {
                return CompareF2Result.equal
            }else if ($0 as! Int) > ($1 as! Int) {
                return CompareF2Result.greater
            }else {
                return CompareF2Result.less
            }
        }
        
        XCTAssertEqual(0, index)
    }
    
    func testSquare() {
        let v = Search.Square(n: 17)
        print(v)
    }
    
    func testBinarySearch1() {
        let arr = [1,1,3,4,5,7,8,8,8,9,12,14,17,19,20]
        var index = Search.BinarySearch1(arr: arr, target: 8) {
            if ($0 as! Int) == ($1 as! Int) {
                return CompareF2Result.equal
            }else if ($0 as! Int) > ($1 as! Int) {
                return CompareF2Result.greater
            }else {
                return CompareF2Result.less
            }
        }
        
        XCTAssertEqual(6, index)
        
        index = Search.BinarySearch1(arr: arr, target: 1) {
            if ($0 as! Int) == ($1 as! Int) {
                return CompareF2Result.equal
            }else if ($0 as! Int) > ($1 as! Int) {
                return CompareF2Result.greater
            }else {
                return CompareF2Result.less
            }
        }
        
        XCTAssertEqual(0, index)
        
    }
    
    func testBinarySearch2() {
        let arr = [1,1,3,4,5,7,8,8,8,9,12,14,17,19,20,20]
        var index = Search.BinarySearch2(arr: arr, target: 8) {
            if ($0 as! Int) == ($1 as! Int) {
                return CompareF2Result.equal
            }else if ($0 as! Int) > ($1 as! Int) {
                return CompareF2Result.greater
            }else {
                return CompareF2Result.less
            }
        }
        
        XCTAssertEqual(8, index)
        
        index = Search.BinarySearch2(arr: arr, target: 20) {
            if ($0 as! Int) == ($1 as! Int) {
                return CompareF2Result.equal
            }else if ($0 as! Int) > ($1 as! Int) {
                return CompareF2Result.greater
            }else {
                return CompareF2Result.less
            }
        }
        
        XCTAssertEqual(15, index)
        
    }
    
    func testBinarySearch3() {
        let arr = [1,1,3,4,5,7,8,8,8,9,12,14,17,18,20,20]
        var index = Search.BinarySearch3(arr: arr, target: 9) {
            if ($0 as! Int) == ($1 as! Int) {
                return CompareF2Result.equal
            }else if ($0 as! Int) > ($1 as! Int) {
                return CompareF2Result.greater
            }else {
                return CompareF2Result.less
            }
        }
        
        XCTAssertEqual(9, index)
        
        index = Search.BinarySearch3(arr: arr, target: 19) {
            if ($0 as! Int) == ($1 as! Int) {
                return CompareF2Result.equal
            }else if ($0 as! Int) > ($1 as! Int) {
                return CompareF2Result.greater
            }else {
                return CompareF2Result.less
            }
        }
        
        XCTAssertEqual(14, index)
        
    }
    
    func testBinarySearch4() {
        let arr = [1,1,3,4,5,7,8,8,8,9,12,14,17,18,20,20]
        var index = Search.BinarySearch4(arr: arr, target: 8) {
            if ($0 as! Int) == ($1 as! Int) {
                return CompareF2Result.equal
            }else if ($0 as! Int) > ($1 as! Int) {
                return CompareF2Result.greater
            }else {
                return CompareF2Result.less
            }
        }
        
        XCTAssertEqual(8, index)
        
        index = Search.BinarySearch4(arr: arr, target: 20) {
            if ($0 as! Int) == ($1 as! Int) {
                return CompareF2Result.equal
            }else if ($0 as! Int) > ($1 as! Int) {
                return CompareF2Result.greater
            }else {
                return CompareF2Result.less
            }
        }
        
        XCTAssertEqual(15, index)
        
    }
}
