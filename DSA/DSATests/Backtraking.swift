//
//  Backtraking.swift
//  DSATests
//
//  Created by Cocos on 2019/6/26.
//  Copyright © 2019 Cocos. All rights reserved.
//

import XCTest
@testable import DSA

class BacktrakingTests: XCTestCase {
    func testEightQueen() {
        Backtracking.EightQueen()
    }
    
    func testKnapsack() {
        let items = [10, 20, 30, 40, 50, 55]
        print(Backtracking.Knapsack(items: items, index: 0, putIn: [Int](), cap: 100))
    }
}
