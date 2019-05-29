//
//  Stack.swift
//  DSA
//
//  Created by Cocos on 2019/5/29.
//  Copyright © 2019 Cocos. All rights reserved.
//

import Foundation

open class Stack: NSObject {
    @objc private var items: [Any]
    
    /// 栈中元素数量
    @objc open private(set) var count: Int = 0
    
    /// 栈最大容量
    @objc open private(set) var cap: Int
    
    @objc public init(cap: Int) {
        if cap <= 0 {
            fatalError("cap must be greater than 0")
        }
        self.items = []
        self.cap = cap
    }
}

// MARK: - Debug
extension Stack {
    open override var description: String {
        var descString = ""
        for i in 0..<self.count {
            descString += "\(self.items[i])-"
        }
        return descString
    }
}

// MARK: - 栈操作
extension Stack {
    
    
    /// 入栈
    ///
    /// - Parameter ele: 入栈的元素
    /// - Returns: 入栈结果
    @objc open func Push(ele: Any) -> Bool {
        if self.cap == self.count {
            return false
        }
        
        self.count += 1
        self.items.append(ele)
        return true
    }
    
    
    /// 出栈
    ///
    /// - Returns: 出栈的元素
    @objc open func Pop() -> Any? {
        if self.count == 0 {
            return nil
        }
        
        self.count -= 1
        
        // 其实就是获取数组最后一个元素, 并且把它从数组里删除
        let ele = self.items.popLast()
        
        return ele
    }
}
