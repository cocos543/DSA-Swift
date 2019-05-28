//
//  SwiftTest.swift
//  AlgorithmDemo
//
//  Created by Cocos on 2019/5/27.
//  Copyright © 2019 Cocos. All rights reserved.
//

import Foundation
import DSA

class TestInheritance: SinglyLinkedNode {
    var testVal: Int
    
    override init(val: Any) {
        testVal = 0
        super.init(val: val)
    }
    
    override func openFunc() {
        print("Hi \(value)~")
    }
}
