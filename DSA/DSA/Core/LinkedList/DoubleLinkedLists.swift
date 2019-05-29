//
//  DoubleLinkedLists.swift
//  DSA
//
//  Created by Cocos on 2019/5/25.
//  Copyright © 2019 Cocos. All rights reserved.
//

import Foundation

/// 单链表节点
open class DoubleLinkedNode: NSObject {
    
    @objc open var value: Any!
    @objc open var perv: DoubleLinkedNode?
    @objc open var next: DoubleLinkedNode?
    
    @objc public override init() {
        // 需要重写父类init方法, 否则无法自动继承该方法~
    }
    
    @objc public init(val: Any) {
        value = val
    }
}

// MARK: - Debug
extension DoubleLinkedLists {
    open override var description: String {
        var listString1 = ""
        var listString2 = ""
        var p: DoubleLinkedNode? = self.head
        while p!.next != nil {
            listString1 += "\(String(describing: p!.next!.value!))-->"
            p = p!.next
        }
        
        listString1 += "nil\n"
        
        while p != self.head {
            listString2 = "<--\(String(describing: p!.value!))" + listString2
            p = p?.perv
        }
        listString2 = "head" + listString2
        
        return listString1 + listString2
    }
}

open class DoubleLinkedLists: NSObject {
    
    @objc open var head: DoubleLinkedNode
    
    @objc open var length: Int = 0
    
    @objc public override init() {
        self.head = DoubleLinkedNode()
    }
    
    @objc public init(node: DoubleLinkedNode) {
        self.head = DoubleLinkedNode()
        super.init()
        self.InsertNode(node: node)
    }
}

// MARK: - 取值操作
extension DoubleLinkedLists {
    /// 获取第一个节点
    ///
    /// 注意, 不是头节点head
    /// - Returns: 链表第一个节点
    @objc open func GetFirstNode() -> DoubleLinkedNode? {
        return self.head.next
    }
    
    
    /// 获取指定位置的节点
    ///
    /// - Parameter index: 位置
    /// - Returns: 节点
    @objc open func GetNodeAtIndex(index: Int) -> DoubleLinkedNode {
        if index > self.length-1 || index < 0 {
            fatalError("out of range")
        }
        
        var index = index

        var p:DoubleLinkedNode? = self.head
        
        while (index > -1) {
            p = p?.next
            index -= 1
        }
        return p!
    }
}

// MARK: - 插入操作
extension DoubleLinkedLists {
    
    /// 在链尾插入一个新节点
    ///
    /// - Parameter node: 新节点
    @objc open func InsertNode(node: DoubleLinkedNode) {
        guard node.value != nil else {
            fatalError("value can't be nil")
        }
        
        var p:DoubleLinkedNode? = self.head
        
        while p?.next != nil {
            p = p?.next
        }
        
        // 插入节点
        node.perv = p
        p?.next = node
        
        self.length += 1
    }
    
    
    /// 将新节点插入到链头部
    ///
    /// - Parameter node: 新接地那
    @objc open func InsertNodeHead(node: DoubleLinkedNode) {
        guard node.value != nil else {
            fatalError("value can't be nil")
        }
        
        let p: DoubleLinkedNode? = self.head
        
        node.next = p?.next
        // 这里如果node.next为nil, 可以正常运行, 所以不需要额外判断node.next是否为nil
        node.next?.perv = node
        node.perv = p
        
        p?.next = node
        
        self.length += 1
    }
    
    /// 在目标节点后面插入一个新节点
    ///
    /// - Parameters:
    ///   - dest: 目标节点
    ///   - node: 新节点
    /// - Returns: 插入是否成功
    @objc open func InsertNodeAfterAt(dest: DoubleLinkedNode, node: DoubleLinkedNode) -> Bool {
        guard node.value != nil else {
            fatalError("value can't be nil")
        }
        
        var p: DoubleLinkedNode? = self.head
        
        while p != nil && p != dest {
            p = p?.next
        }
        
        if p == dest {
            // 找到目标节点, 则在其后插入一个新节点
            p?.next?.perv = node
            
            node.perv = p
            node.next = p?.next
            
            p?.next = node
            
            self.length += 1
            return true
        }
        
        return false
    }
    
    
    /// 在指定值后面插入一个新节点
    ///
    /// - Parameters:
    ///   - dest: 指定值
    ///   - node: 新节点
    ///   - cmp: 比较闭包, 调用者需要告诉框架如何做等值比较
    /// - Returns: 插入是否成功
    
    @objc open func InsertNodeAfterValueAt(dest: Any, node: DoubleLinkedNode, cmp: CompareF) -> Bool {
        guard node.value != nil else {
            fatalError("value can't be nil")
        }
        
        // 因为下面要做值比较, 所以这里p就直接指向第一个数据节点吧, head是没有值的.
        var p: DoubleLinkedNode? = self.head.next
        
        while p != nil && !cmp(p!.value, dest) {
            p = p?.next
        }
        
        if cmp(p!.value, dest) {
            // 找到目标节点, 则在其后插入一个新节点
            p?.next?.perv = node
            
            node.perv = p
            node.next = p?.next
            
            p?.next = node
            
            self.length += 1
            return true
        }
        
        return false
    }
}

// MARK: - 删除操作
extension DoubleLinkedLists {
    
    /// 删除指定节点
    ///
    /// 温馨提示:在单向链表中, 要删除指定节点需要知道前置节点, 所以一般我们会使用head哨兵节点, 当p.next=node时则停止循环, 开始删除操作;
    /// 但是双向链表的删除操作, 我们可以不用遍历, 直接就把要删除的节点给删了, 因为我们有前置节点, 也不需要再遍历前置节点了, 所以删除操作时间复杂度可以为O(1);
    /// 但是! 这里我们的需求是删除链上的指定节点, 并且返回是否成功, 所以如果直接删除节点不遍历前置节点的话, 我们就不知道指定节点是否在链上,
    /// 从而无法得到是否删除成功, 所以我们必须跟单向链表一样遍历出前置节点再操作了, 时间复杂度为O(n)
    ///
    /// - Parameter node: 指定节点
    /// - Returns: 删除是否成功
    @objc open func DeleteNode(node: DoubleLinkedNode) -> Bool {
        var p: DoubleLinkedNode? = self.head
        
        while p?.next != nil && p?.next != node {
            p = p?.next
        }
        
        if p?.next == node {
            // 删除节点
            node.next?.perv = p
            p?.next = node.next
            
            print("delete \(String(describing: node.value ?? 0))")
            
            self.length -= 1
            
            return true
        }
        return false
    }
    
    
    /// 删除指定位置节点
    ///
    /// - Parameter index: 指定位置
    /// - Returns: 删除是否成功
    @objc open func DeleteNodeAtIndex(index: Int) {
        if index > self.length-1 || index < 0 {
            fatalError("out of range")
        }
        
        var p: DoubleLinkedNode? = self.head
        var index = index
        while index > -1 {
            p = p?.next
            index -= 1
        }
        
        // 删除节点
        p?.next?.perv = p?.perv
        p?.perv?.next = p?.next
        
        // p 节点没人引用的话会被自动回收
        print("delete \(String(describing: p?.value ?? 0))")
        
        self.length -= 1
    }
}
