//
//  Dynamic.swift
//  DSATests
//
//  Created by Cocos on 2019/6/27.
//  Copyright © 2019 Cocos. All rights reserved.
//

import XCTest
@testable import DSA

class DynamicTests: XCTestCase {

    func testKnapsack() {
        print(Dynamic.Knapsack(items: [2, 2, 4, 6, 3], cap: 9))
        
        print(Dynamic.Knapsack(items: [1, 2, 3, 4, 5, 7], cap: 20))
        
        print(Dynamic.Knapsack(items: [1, 2, 3, 4, 5, 7, 12, 23, 24, 35, 68, 2, 3], cap: 100))
        
        print(Dynamic.KnapsackLite(items: [1, 2, 3, 4, 5, 7, 12, 23, 24, 35, 68, 2, 3], cap: 100))
        
    }
    
    func testTriangle() {
        Dynamic.LikePascaltriangle()
    }
    
    func testMinCoins() {
        print(Dynamic.MinCoins(coins: [1,3,5], money: 9))
    }

}
