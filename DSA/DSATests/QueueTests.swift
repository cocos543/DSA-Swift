//
//  QueueTests.swift
//  DSATests
//
//  Created by Cocos on 2019/5/29.
//  Copyright © 2019 Cocos. All rights reserved.
//

import XCTest
@testable import DSA

class QueueTests: XCTestCase {
    func testQueue() {
        let q = Queue(cap: 5)
        
        XCTAssertEqual(true, q.EnQueue(ele: 1))
        XCTAssertEqual(true, q.EnQueue(ele: 2))
        XCTAssertEqual(true, q.EnQueue(ele: 3))
        XCTAssertEqual(true, q.EnQueue(ele: 4))
        XCTAssertEqual(true, q.EnQueue(ele: 5))
        XCTAssertEqual(false, q.EnQueue(ele: 6))
        XCTAssertEqual(5, q.count)
        
        XCTAssertEqual("5-4-3-2-1-", "\(q)")
        
        XCTAssertEqual(1, q.DeQueue() as! Int)
        XCTAssertEqual(2, q.DeQueue() as! Int)
        XCTAssertEqual(3, q.DeQueue() as! Int)
        XCTAssertEqual(4, q.DeQueue() as! Int)
        XCTAssertEqual(5, q.DeQueue() as! Int)
        XCTAssertEqual(true, q.DeQueue() == nil)
        XCTAssertEqual(0, q.count)
    }
}
