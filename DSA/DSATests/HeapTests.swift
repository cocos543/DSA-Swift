//
//  HeapTests.swift
//  DSATests
//
//  Created by Cocos on 2019/6/13.
//  Copyright © 2019 Cocos. All rights reserved.
//

import XCTest
@testable import DSA

class HeapTests: XCTestCase {
    
    let cmp = { (a: Any, b: Any) -> Bool in
        return (a as! Int) > (b as! Int)
    }

    func testHeapOperate() {
        var heap = Heap()
        heap.Insert(val: 33, cmp: cmp)
        heap.Insert(val: 17, cmp: cmp)
        heap.Insert(val: 21, cmp: cmp)
        heap.Insert(val: 16, cmp: cmp)
        heap.Insert(val: 13, cmp: cmp)
        heap.Insert(val: 15, cmp: cmp)
        heap.Insert(val: 9, cmp: cmp)
        heap.Insert(val: 5, cmp: cmp)
        heap.Insert(val: 6, cmp: cmp)
        heap.Insert(val: 7, cmp: cmp)
        heap.Insert(val: 8, cmp: cmp)
        heap.Insert(val: 1, cmp: cmp)
        heap.Insert(val: 2, cmp: cmp)
        
        XCTAssertEqual("33-17-21-16-13-15-9-5-6-7-8-1-2-", "\(heap)")
        
        heap.Insert(val: 22, cmp: cmp)
        XCTAssertEqual("33-17-22-16-13-15-21-5-6-7-8-1-2-9-", "\(heap)")
        
        XCTAssertEqual(true, heap.DeleteTop(cmp: cmp) as! Int == 33)
        XCTAssertEqual("22-17-21-16-13-15-9-5-6-7-8-1-2-", "\(heap)")
        
        XCTAssertEqual(true, heap.DeleteTop(cmp: cmp) as! Int == 22)
        XCTAssertEqual("21-17-15-16-13-2-9-5-6-7-8-1-", "\(heap)")
        
        heap = Heap()
        heap.Insert(val: 33, cmp: cmp)
        XCTAssertEqual(true, heap.DeleteTop(cmp: cmp) as! Int == 33)
        
        XCTAssertEqual(true, heap.DeleteTop(cmp: cmp) == nil)
        
    }
}
