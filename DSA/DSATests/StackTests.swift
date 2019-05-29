//
//  StackTests.swift
//  DSATests
//
//  Created by Cocos on 2019/5/29.
//  Copyright © 2019 Cocos. All rights reserved.
//

import XCTest
@testable import DSA

class StackTests: XCTestCase {
    
    func testStack() {
        let stack = Stack(cap: 5)
        XCTAssertEqual(true, stack.Push(ele: 1))
        XCTAssertEqual(true, stack.Push(ele: 2))
        XCTAssertEqual(true, stack.Push(ele: 3))
        XCTAssertEqual(true, stack.Push(ele: 4))
        XCTAssertEqual(4, stack.count)
        XCTAssertEqual(true, stack.Push(ele: 5))
        XCTAssertEqual(false, stack.Push(ele: 6))
        XCTAssertEqual("1-2-3-4-5-", "\(stack)")
        XCTAssertEqual(5, stack.count)
        
        XCTAssertEqual(5, stack.Pop()! as! Int)
        XCTAssertEqual(4, stack.Pop()! as! Int)
        XCTAssertEqual(3, stack.Pop()! as! Int)
        XCTAssertEqual(2, stack.Pop()! as! Int)
        XCTAssertEqual(1, stack.Pop()! as! Int)
        XCTAssertEqual(0, stack.count)
        XCTAssertEqual(true, stack.Pop() == nil)
    }
    
    func testLinkedStack() {
        let stack = LinkedStack(cap: 5)
        
        XCTAssertEqual(true, stack.Push(ele: 1))
        XCTAssertEqual(true, stack.Push(ele: 2))
        XCTAssertEqual(true, stack.Push(ele: 3))
        XCTAssertEqual(true, stack.Push(ele: 4))
        XCTAssertEqual(4, stack.count)
        XCTAssertEqual(true, stack.Push(ele: 5))
        XCTAssertEqual(false, stack.Push(ele: 6))
        XCTAssertEqual("1-2-3-4-5-", "\(stack)")
        XCTAssertEqual(5, stack.count)
        
        XCTAssertEqual(5, stack.Pop()! as! Int)
        XCTAssertEqual(4, stack.Pop()! as! Int)
        XCTAssertEqual(3, stack.Pop()! as! Int)
        XCTAssertEqual(2, stack.Pop()! as! Int)
        XCTAssertEqual(1, stack.Pop()! as! Int)
        XCTAssertEqual(0, stack.count)
        XCTAssertEqual(true, stack.Pop() == nil)
    }
}
