//
//  SinglyLinkedList.swift
//  DSA
//
//  Created by Cocos on 2019/5/22.
//  Copyright © 2019 Cocos. All rights reserved.
//

import Foundation

/// 单链表节点
open class SinglyLinkedNode: NSObject {

    @objc open var value: Any!
    @objc open var next: SinglyLinkedNode?
    
    @objc public override init() {
        self.value = nil
    }
    
    @objc public init(val: Any) {
        value = val
    }
    
    @objc open func openFunc() {
    
    }
}

/// 单链表
open class SinglyLinkedList: NSObject {
    @objc private var head: SinglyLinkedNode
    @objc open private(set) var length: Int = 0
    
    /// 初始化一条只有头节点的空链表
    @objc public override init() {
        self.head = SinglyLinkedNode()
    }
    
    /// 从一个节点中构建出一个链表对象
    ///
    /// - Parameter node: 第一个节点
    @objc public init(node: SinglyLinkedNode) {
        self.head = SinglyLinkedNode()
        super.init()
        self.InsertNode(node: node)
    }
}


// MARK: - Debug
extension SinglyLinkedList {
    open override var description: String {
        var listString = ""
        var p: SinglyLinkedNode? = self.head
        while p!.next != nil {
            listString += "\(String(describing: p!.next!.value!))-->"
            p = p!.next
        }
        
        listString += "nil"
        
        return listString
    }
}

// MARK: - 插入操作
extension SinglyLinkedList {
    /// 在链表末尾插入一个节点
    ///
    /// - Parameter node: 节点
    @objc open func InsertNode(node: SinglyLinkedNode) {
        guard node.value != nil else {
            fatalError("value can't be nil")
        }
        
        var p: SinglyLinkedNode? = self.head
        while p!.next != nil {
            p = p!.next
        }
        
        p?.next = node
        
        self.length += 1
    }
    
    
    /// 将新节点插入头节点之后
    ///
    /// - Parameter node: 新节点
    @objc open func InsertNodeHead(node: SinglyLinkedNode) {
        guard node.value != nil else {
            fatalError("value can't be nil")
        }
        
        let p: SinglyLinkedNode? = self.head
        node.next = p?.next
        p?.next = node
        
        self.length += 1
    }
    
    
    /// 在dest节点之后插入一个新节点
    ///
    /// - Parameters:
    ///   - dest: 目标节点
    ///   - node: 新节点
    /// - Returns: 插入是否成功
    @objc open func InsertNodeAfterAt(dest: SinglyLinkedNode, node: SinglyLinkedNode) -> Bool {
        guard node.value != nil else {
            fatalError("value can't be nil")
        }
        
        var inserted = false
        
        // p 最终会指向dest的前一个节点, 或者指向末尾节点
        var p: SinglyLinkedNode? = self.head
        while p!.next != dest && p!.next != nil {
            p = p!.next
        }
        
        // 找到目标节点, 则将新节点插入dest之后
        if p?.next == dest {
            node.next = p?.next?.next
            p?.next?.next = node
            
            inserted = true
            self.length += 1
        }
        
        // 找不到目标节点, 插入失败
        
        return inserted
    }
    
    
    /// 将新节点插入到指定值后面
    ///
    /// - Parameters:
    ///   - dest: 指定值
    ///   - node: 新节点
    ///   - cmp: 闭包, 用来告诉框架该如何对比值, 因为Any类型编译器无法确认如何对比
    /// - Returns: 插入是否成功
    @objc open func InsertNodeAfterValueAt(dest: Any, node: SinglyLinkedNode, cmp: CompareF) -> Bool {
        guard node.value != nil else {
            fatalError("value can't be nil")
        }
        
        var inserted = false
        
        // p 最终会指向dest的前一个节点, 或者指向末尾节点
        var p: SinglyLinkedNode? = self.head
        while p!.next != nil && !cmp(p!.next!.value, dest) {
            p = p!.next
        }
        
        // 找到目标节点, 则将新节点插入dest之后
        if cmp(p!.next?.value as Any, dest) {
            node.next = p?.next?.next
            p?.next?.next = node
            
            inserted = true
            self.length += 1
        }
        
        return inserted
    }
}

// MARK: - 取值
extension SinglyLinkedList {
    
    /// 获取指定位置的节点
    ///
    /// - Parameter index: 位置, 这里就不用UInt了, 对于循环链表负数可以表示逆向节点, 所以统一使用Int
    @objc open func GetNodeAtIndex(index: Int) -> SinglyLinkedNode {
        if index > self.length-1 || index < 0 {
            fatalError("out of range")
        }
        var index = index
        var p: SinglyLinkedNode? = self.head
        while index > -1 {
            p = p?.next
            index -= 1
        }
        return p!
    }
    
    
    /// 获取第一个节点
    ///
    /// - Returns: 第一个节点
    @objc open func GetFirstNode() -> SinglyLinkedNode? {
        return self.head.next
    }
}

// MARK: - 删除
extension SinglyLinkedList {
    
    /// 删除指定节点
    ///
    /// - Parameter node: 指定节点
    /// - Returns: 删除结果
    @objc open func DeleteNode(node: SinglyLinkedNode) -> Bool {
        var deleted = false
        
        var p: SinglyLinkedNode? = self.head
        while p?.next != node && p?.next != nil {
            p = p?.next
        }
        
        if p?.next == node {
            p?.next = p?.next?.next
            // 节点node会被自动回收, 所以不需要其他处理
            self.length -= 1
            deleted = true
        }
        
        // 指定节点不存在, 删除失败返回false
        
        return deleted
    }
    
    @objc open func DeleteNodeAtIndex(index: Int) {
        if index > self.length-1 || index < 0 {
            fatalError("out of range")
        }
        
        var index = index
        
        // p 指向目标节点的前一个
        var p: SinglyLinkedNode? = self.head
        while index > 0 {
            p = p?.next
            index -= 1
        }
        
        p?.next = p?.next?.next
        // 节点node会被自动回收, 所以不需要其他处理
        self.length -= 1
    }
}

//MARK: - 常见链表操作
extension SinglyLinkedList {
    
    /// 反转链表
    /// 算法思路: 使用三个指针分别指向已反转和未反转部分, 当未反转部分为空时, 反转结束
    ///
    ///   nil   a--> b-->c-->d-->e-->f-->nil (循环开始前状态m, curNext定义在循环内)
    ///    ↑    ↑    ↑
    ///   per  cur curNext
    ///
    ///    a-->nil b-->c-->d-->e-->f-->nil (第1次循环执行之后的结果)
    ///    ↑       ↑   ↑
    ///   per     cur curNext
    ///
    ///    b-->a-->nil c-->d-->e-->f-->nil (第2次循环执行之后的结果)
    ///    ↑           ↑   ↑
    ///   per         cur curNext
    ///
    ///
    /// - Parameter node: 第一个节点
    /// - Returns: 反转后的第一个节点
    @objc static public func ReverseList(node: SinglyLinkedNode) -> SinglyLinkedNode {
        // cur 在每轮循环之后, 始终指向已反转的区间的第一个节点
        // cur.next 在每轮循环之后, 始终指向未被反转的区间的第一个节点, 所以当cur.next为空时, 表示不需要再继续反转了
        var cur: SinglyLinkedNode? = node
        var per: SinglyLinkedNode? = nil
        
        while cur != nil {
            let curNext = cur!.next
            cur?.next = per
            per = cur
            cur = curNext
        }
        
        return per!
    }
    
    
    /// 查找中间节点
    /// 算法思路: 利用快慢指针定位中间节点
    ///
    ///   a,ab 返回a.
    ///   abcd, 返回b.
    ///   abcde, 返回c.
    ///
    /// - Parameter node: 头节点
    /// - Returns: 中间节点
    @objc static public func GetMedianNode(node: SinglyLinkedNode) -> SinglyLinkedNode {
        
        // 哨兵节点, 方便实现当只有一个节点时, 正确返回节点
        let head = SinglyLinkedNode()
        head.next = node
        
        var slow: SinglyLinkedNode? = head
        var quick: SinglyLinkedNode? = head
        
        // slow 每次走一步, quick每次走两步
        while quick != nil && quick?.next != nil  {
            // 这里可以知道slow永远都不可能为nil
            slow = slow!.next
            
            // quick 一次走两步
            quick = quick?.next?.next
        }
        
        return slow!
    }
    
    
    /// 判断链表里的内容是否未回文串, value应该是string类型, 就不需要再传入比较函数了
    ///
    ///  算法原理: 先找到中间节点, 反转右半部分节点, 接着开始比较第一个节点和右半部分第一个节点, 分别逐个前进, 最后再还原右半部分数据
    ///
    /// - Parameter node: 第一个节点
    /// - Returns: 是否为回文串
    @objc static public func IsPalindrome(node: SinglyLinkedNode) -> Bool {
        guard let _ = node.value as? String else {
            fatalError("value must be type of string")
        }
        
        // 哨兵, 方便让pl和pr都处于同等位置
        let head = SinglyLinkedNode()
        head.next = node
        
        let pm: SinglyLinkedNode? = SinglyLinkedList.GetMedianNode(node: node)
        
        // 只有一个节点时, 为回文串
        if pm?.next == nil {
            return true
        }
        
        // 反转右半部分
        pm?.next = SinglyLinkedList.ReverseList(node: pm!.next!)
        
        // pl.next 指向左半部分第一个节点
        var pl: SinglyLinkedNode? = head
        // pr.next即为右半部分第一个节点
        var pr: SinglyLinkedNode? = pm
        
        var isPalined = true
        
        while pr?.next != nil {
            if pl?.next?.value as! String != pr?.next?.value as! String {
                isPalined = false
                break;
            }
            pl = pl?.next
            pr = pr?.next
        }
        
        //还原右半部分
        pm?.next = SinglyLinkedList.ReverseList(node: pm!.next!)
        return isPalined
    }
    
    
    /// 检查链表是否有环
    ///
    /// 算法思路:用两个指针, 一个一次走一步, 一个一次走两步, 假设有环时, 两个指针的相对速度为1, 所以快指针一定会经过循环后从后面追上慢指针
    ///
    /// - Parameter node: 第一个节点
    /// - Returns: 是否有环
    @objc static public func IsLoopLinkedList(node: SinglyLinkedNode) -> Bool {
        var ps: SinglyLinkedNode? = node
        var pq: SinglyLinkedNode? = node
        
        while pq?.next != nil && pq?.next?.next != nil {
            ps = ps?.next
            pq = pq?.next?.next
            if ps == pq {
                return true
            }
        }
        return false
    }
    
    
    /// 删除倒数第n个节点
    ///
    ///  算法原理: 使用两个指针pn, plast, 其中pn指向头节点, plast指向pn之后的第n个节点;
    ///  pn和plast同时向后逐步移动, 当plast.next为nil时,plast就是倒数第一个, 而pn位于plast的前n个, 所以pn位于倒数第n+1个, pn.next则为倒数第n个;
    ///
    /// - Parameters:
    ///   - node: 第一个节点
    ///   - n: 倒数第n, 这里没对n的合法性进行判断, 请传入时确保有效性
    /// - Returns: 处理过的第一个节点, 如果链表只有一个节点, 删除了则返回nil
    @objc static public func RemoveNthNodeFromEndOfList(node: SinglyLinkedNode, n: Int) -> SinglyLinkedNode? {
        
        // 哨兵节点, 方便让pn指向倒数第n个节点的前一个节点, 方便删除操作
        let head = SinglyLinkedNode()
        head.next = node
        
        var pn: SinglyLinkedNode? = head
        var plast: SinglyLinkedNode? = pn
        for _ in 0 ..< n {
            plast = plast?.next
        }
        
        // 两个指针同时前进, 直到plast指向最后一个节点
        while plast?.next != nil {
            pn = pn?.next
            plast = plast?.next
        }
        
        // 如果没有人再引用deleteNode了, 它会被回收释放
        print("delete \(String(describing: pn?.next?.value ?? 0))")
        pn?.next = pn?.next?.next
        
        return head.next
    }
    
    
    /// 合并两个有序链表: 这里规定两个链表的顺序相同, 比较规则由用户自行传入闭包确定
    ///
    ///  算法思路: 使用两个指针分别指向两条链的头部, 比较节点大小关系, 将其中一个指针指向的节点插入新链的末尾, 并将该指针往后移动1, 直到其中一个指针指向末尾, 则如果另一个指针还没到末尾, 需要把全部节点都搬移到新链末尾, 合并结束.
    ///
    /// - Parameters:
    ///   - nodeA: A链第一个节点
    ///   - nodeB: B链第二个节点
    ///   - cmp: 比较闭包, 返回true时表示a在b前, false表示b在a前
    /// - Returns:
    @objc static public func MergeTowOrderedList(nodeA: SinglyLinkedNode, nodeB: SinglyLinkedNode, cmp: CompareF) -> SinglyLinkedNode {
        
        // 哨兵节点, 方便实现对p.next直接赋值, 而不需要判断p是否为nil
        let head: SinglyLinkedNode = SinglyLinkedNode()
        var p = head
        var pa: SinglyLinkedNode? = nodeA
        var pb: SinglyLinkedNode? = nodeB
        
        while pa != nil && pb != nil {
            if cmp(pa!.value, pb!.value) {
                p.next = pa
                p = p.next!
                
                pa = pa?.next
            } else {
                p.next = pb
                p = p.next!
                
                pb = pb?.next
                
            }
        }
        
        // 将剩余部分直接并入新链
        if pa != nil {
            p.next = pa
        }else {
            p.next = pb
        }
        
        return head.next!
    }
}


