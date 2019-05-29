//
//  Queue.swift
//  DSA
//
//  Created by Cocos on 2019/5/29.
//  Copyright © 2019 Cocos. All rights reserved.
//

import Foundation


/// 顺序队列
open class Queue: NSObject {
    @objc private var q: [Any]
    
    /// 实际队列容量
    @objc open var cap: Int {
        get {
            return _cap - 1
        }
    }
    
    /// 队里元素数量
    @objc private(set) var count: Int = 0
    
    @objc private var _cap: Int //数组容量, 比实际可使用容量多1
    @objc private var _front: Int = 0 // 队头下标
    @objc private var _rear: Int = 0// rear 为队尾下标
    
    @objc public init(cap: Int) {
        if cap <= 0 {
            fatalError("cap must be greater than 0")
        }
        
        q = Array(repeating: 0, count: cap + 1)
        self._cap = cap + 1
    }
    
}

// MARK: - 队列状态
extension Queue {
    
    /// 队列是否已满
    ///
    /// - Returns: 结果
    @objc open func IsFull() -> Bool {
        return (self._rear + 1) % self._cap == self._front
    }
    
    /// 队列是否已满空
    ///
    /// - Returns: 结果
    @objc open func IsEmpty() -> Bool {
        return self._front == self._rear
    }
}

// MARK: - Debug
extension Queue {
    open override var description: String {
        var descString = ""

        var r = self._rear
        while r != self._front {
            descString += "\(self.q[r - 1])-"
            r = (r - 1 + self._cap) % self._cap
        }
        
        return descString
    }
}

// MARK: - 队列操作
extension Queue {
    
    /// 入队
    ///
    /// - Parameter ele: 入队元素
    /// - Returns: 入队结果
    @objc open func EnQueue(ele: Any) -> Bool {
        if IsFull() {
            return false
        }
        
        self.q[self._rear] = ele
        self._rear = (self._rear + 1) % self._cap
        
        self.count += 1
        return true
    }
    
    
    /// 出队
    ///
    /// - Returns: 队头元素
    @objc open func DeQueue() -> Any? {
        if IsEmpty() {
            return nil
        }
        
        let ele = self.q[self._front]
        self._front = (self._front + 1) % self._cap
        
        self.count -= 1
        return ele
    }
}
