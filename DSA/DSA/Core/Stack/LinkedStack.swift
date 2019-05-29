//
//  LikedStack.swift
//  DSA
//
//  Created by Cocos on 2019/5/29.
//  Copyright © 2019 Cocos. All rights reserved.
//

import Foundation


/// 链式栈, 底层为双向链表
open class LinkedStack: NSObject {
    @objc private var items: DoubleLinkedLists
    @objc private var _topNode: DoubleLinkedNode?
    
    
    /// 栈中元素数量
    @objc open private(set) var count: Int = 0
    
    /// 栈最大容量
    @objc open private(set) var cap: Int
    
    @objc public init(cap: Int) {
        if cap <= 0 {
            fatalError("cap must be greater than 0")
        }
        self.items = DoubleLinkedLists()
        self.cap = cap
    }
}

// MARK: - Debug
extension LinkedStack {
    open override var description: String {
        var descString = ""
        var p = self.items.GetFirstNode()
        while p != nil {
            descString += "\(String(describing: p!.value!))-"
            p = p?.next
        }
        return descString
    }
}

// MARK: - 栈操作
extension LinkedStack {
    
    /// 入栈
    ///
    /// - Parameter ele: 入栈的元素
    /// - Returns: 入栈结果
    @objc open func Push(ele: Any) -> Bool {
        if self.cap == self.count {
            return false
        }
        
        let node = DoubleLinkedNode(val: ele)
        if self.count == 0 {
            self._topNode = node
            self.items.DropNodes()
            self.items.InsertNode(node: node)
        }else {
            DoubleLinkedNode.InsertNodeAfter(target: self._topNode!, node: node)
        }
        
        self._topNode = node
        self.count += 1

        return true
    }
    
    
    /// 出栈
    ///
    /// - Returns: 出栈的元素
    @objc open func Pop() -> Any? {
        if self.count == 0 {
            return nil
        }
        
        
        let node = self._topNode
        self._topNode = node?.perv
        DoubleLinkedNode.DeleteNode(target: node!)
        
        self.count -= 1
        
        return node?.value
    }
}


