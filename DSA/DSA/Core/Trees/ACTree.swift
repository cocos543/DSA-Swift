//
//  ACTree.swift
//  DSA
//
//  Created by Cocos on 2019/6/25.
//  Copyright © 2019 Cocos. All rights reserved.
//

import Foundation

class ACNode: TrieNode {
    
    /// 用于确定主串匹配位置
    @objc open var length: Int = 0
    
    /// 失败指针, 指向其他模式串的前缀子串在Trie树的最后一个节点, 该前缀子串能与当前模式串的最长后缀子串匹配. 若不存在这样的前缀子串, 则指向root
    @objc open var failNode: ACNode?
    
}


/// AC自动机(AhoCorasick), 多模匹配算法
class ACTree: NSObject {
    @objc open private(set) var root: ACNode
    
    @objc public override init() {
        self.root = ACNode(value: "root")
    }
}


// MARK: - AC自动机模式串操作
extension ACTree {
    
    /// 插入一个模式串
    ///
    /// - Parameter str: 模式串
    @objc open func Insert(str: String) {
        //找到适合的节点, 将字符插入
        TrieTree.Insert(str: str, root: self.root)
        
        // 为每一个节点的长度赋值
        var root = self.root
        
        for i in 0..<str.count {
            let c = String(str[i])
            let node = root.children.get(c) as! ACNode
            node.length = i + 1
            root = node
        }
    }
    
    /// 删除一个模式串
    ///
    /// - Parameter str: 要删除的模式串
    /// - Returns: 模式串存在时删除后返回true, 不存在返回false
    @objc open func Delete(str: String) -> Bool {
        return TrieTree.Delete(str: str, root: self.root)
    }
    
    
    /// 构建失败指针
    ///
    /// 算法思想: 按层遍历节点, 第n层节点p的最长可匹配后缀子串对应的其他模式串前缀子串指向的节点q, 只可能是出现在第n-1层,
    /// 或者再上一层(直到root节点时为止).
    /// 按照这个思路, 可以逐层遍历, 假设当前节点是pc, pc的父节点是p, p.fail指向的节点我们称为q.
    /// 1. 我们直接对比q的子节点是否存在和pc内容相同的, 如果有, 则直接把pc.fail指向qc, 结束, 继续层次遍历下一个节点.
    /// 2. 如果没有, 则q指向q.fail, 然后继续第1步. 直到q指向null, 还不满足条件时, 则pc.fail指向root, 结束, 继续层次遍历下一个节点.
    ///
    ///             root                  root
    ///             / | \                 / | \
    ///            a  b  c ←q.fail       a  b   c ←q
    ///           /   |    \            /   |    \
    ///          b    c ←q  e          b    c     e ←qc
    ///         /     |               /     |
    ///    p → c      d           p→ c      d
    ///       /                     /
    /// pc → e                 pc→ e
    ///
    ///
    ///
    ///
    private func _buildFailurePointer() {
        // 使用队列保存子节点, 实现层序遍历
        // DSA类库里的Queue类是用循环数组实现, 不支持扩容
        // 这里直接用系统的数组做队列, 当前函数只会在预处理被调用, 出队时间复杂度O(n)可以接受
        var queue = [ACNode]()
        self.root.failNode = nil
        queue.append(self.root)
        
        while !queue.isEmpty {
            let p = queue.removeFirst()
            // 依次遍历子节点, 并且子节点入队
            for k in p.children.keys() {
                let pc = p.children.get(k) as! ACNode
                
                // 如果p节点是root, 则子节点pc.fail直接指向root
                if p == self.root {
                    pc.failNode =  self.root
                }else {
                    var q = p.failNode
                    
                    while q != nil {
                        let qc = q!.children.get(pc.value) as? ACNode
                        
                        // 当p.fail指向的上层节点q, 有一个子节点qc.value和pc.value相同, 则直接将pc.fail指向qc, 退出循环
                        if qc != nil {
                            pc.failNode = qc
                            break
                        }else {
                            q = q!.failNode
                        }
                    }
                    
                    // 如果退出循环时q == nil, 则说明pc的最长可匹配后缀子串不存在
                    if q == nil {
                        pc.failNode = root
                    }
                }
                
                // 子节点入队
                queue.append(pc)
            }
        }
    }
}


// MARK: - AC自动机功能
extension ACTree {
    @objc open func Match(str: String) -> [String: [Int]] {
        // 预处理字典树fail指针
        _buildFailurePointer()
        var ret = [String: [Int]]()
        
        // 指向父节点, 其子节点将要被调查
        var p = self.root
        for i in 0..<str.count {
            let c = String(str[i])
            
            if p.children.get(c) == nil && p != root {
                p = p.failNode!
            }
            
            if var node = p.children.get(c) as? ACNode {
                p = node
                while node != self.root {
                    // 如果节点是模式串的结尾字符, 当前被匹配的主串下标减去模式串长度+1, 得到的就是模式串在主串的起始下标
                    if node.ending {
                        let startIndex = i-node.length+1
                        let subS = String(str[startIndex..<startIndex+node.length])
                        if ret[subS] == nil {
                            ret[subS] = [startIndex]
                        }else {
                            ret[subS]!.append(startIndex)
                        }
                    }
                    
                    // 继续获取可能存在的其他模式串的最长可匹配前缀子串
                    node = node.failNode!
                }
                
            }else {
                // 找不到匹配的字符, 直接退回模式串根节点
                p = self.root
            }
        }
        
        return ret
    }
}
