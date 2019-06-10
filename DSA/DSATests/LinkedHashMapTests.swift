//
//  LinkedHashMapTests.swift
//  DSATests
//
//  Created by Cocos on 2019/6/10.
//  Copyright © 2019 Cocos. All rights reserved.
//

import XCTest
@testable import DSA

class LinkedHashMapTests: XCTestCase {
    func testHashMapOperate() {
        let map = LinkedHashMap(cap: 1)
        map.put(key: "k1", val: 100)
        map.put(key: "k2", val: 102)
        map.put(key: "k3", val: 103)
        map.put(key: "k4", val: 104)
        map.put(key: "k5", val: 105)
        map.put(key: "k6", val: 106)
        
        var keys = map.keys()
        XCTAssertEqual(true, keys.contains("k1"))
        XCTAssertEqual(true, keys.contains("k2"))
        XCTAssertEqual(true, keys.contains("k3"))
        XCTAssertEqual(false, keys.contains("k7"))
        
        XCTAssertEqual(6, map.count)
        
        XCTAssertEqual(100, map["k1"] as! Int)
        
        XCTAssertEqual(true, map.remove("k1"))
        XCTAssertEqual(true, map.remove("k3"))
        XCTAssertEqual(true, map.get("k1") == nil)
        
        keys = map.keys()
        XCTAssertEqual(4, map.count)
    }
    
    func testHashMapDynamicExtension() {
        var i = 1
        let total = 1000000
        var map = LinkedHashMap(cap: 1)
        self.measure {
            map = LinkedHashMap(cap: i)
            for i in 1...total {
                map.put(key: "k\(i)", val: i)
            }
            i += 1
        }
        
        XCTAssertEqual(total, map.count)
    }
    
    func testHashMapGet() {
        let map = LinkedHashMap(cap: 1)
        let total = 1000000
        
        for i in 1...total {
            map.put(key: "k\(i)", val: i)
        }
        
        
        var array: [Int] = []
        var i = 0
        self.measure {
            i += 1
            for i in 1...total {
                array.append(map.get("k\(i)") as! Int)
            }
        }
        XCTAssertEqual(total*i, array.count)
    }
    
    func testHashMapRandomPut() {
        let total = 1000000
        let map = LinkedHashMap(cap: total)
        self.measure {
            let val = Int.random(in: 1...total)
            map.put(key: "k\(val)", val: val)
        }
    }
    
    func testHashMapRandomGet() {
        let total = 1000000
        let map = LinkedHashMap(cap: total)
        for i in 1...total {
            map.put(key: "k\(i)", val: i)
        }
        
        self.measure {
            let val = Int.random(in: 1...total)
            _ = map.get("k\(val)")
        }
    }
}
