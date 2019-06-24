//
//  TrieTree.swift
//  DSA
//
//  Created by Cocos on 2019/6/24.
//  Copyright © 2019 Cocos. All rights reserved.
//

import Foundation


/// 字典树节点
open class TrieNode: NSObject {
    @objc open var value: String
    // 这里使用散列表存储子节点指针. 也可以使用数组, 这样数组就要事先开辟字符集大小的空间了.
    @objc open var children: AddressingHashMap
    
    @objc open var ending: Bool = false
    
    @objc open var deleted: Bool = false
    
    @objc public init(value: String) {
        self.value = value
        self.children = AddressingHashMap(cap: 2)
    }
}


/// 字典树; 单词查找树; 前缀树;
open class TrieTree: NSObject {
    @objc open private(set) var root: TrieNode
    
    @objc public override init() {
        self.root = TrieNode(value: "root")
    }
}


// MARK: - 字典树相关操作
extension TrieTree {
    
    /// 删除一个字符串
    ///
    /// - Parameter str: 要删除的字符串
    /// - Returns: 字符串存在时删除后返回true, 不存在返回false
    @objc open func Delete(str: String) -> Bool {
        if str == "" {
            return false
        }
        
        var root = self.root
        for i in 0..<str.count {
            let c = String(str[i])
            
            if let node = root.children.get(c) as? TrieNode {
                root = node
            }else {
                // 不存在
                return false
            }
        }
        
        // 字符串存在时, 删除并返回true
        if root.deleted == false {
            root.deleted = true
            return true
        }
        
        return false
    }
    
    /// 插入一个字符串
    ///
    /// - Parameter str: 字符串
    @objc open func Insert(str: String) {
        //找到适合的节点, 将字符插入
        var root = self.root
        for i in 0..<str.count {
            let c = String(str[i])
            
            if let node = root.children.get(c) as? TrieNode {
                root = node
            }else {
                let node = TrieNode(value: c)
                root.children.put(key: c, val: node)
                root = node
                
                if i == str.count - 1 {
                    node.ending = true
                }
            }
        }
        
        // 如果节点是被标记为删除的, 直接恢复即可
        if root.deleted == true {
            root.deleted = false
        }
    }
    
    
    /// 查找前缀匹配的字符串
    ///
    /// 算法思路:
    ///
    ///
    ///
    /// 例如: hello, her, hi; 查找he,返回[hello, her]
    ///
    /// - Parameter prefix: 字符串前缀
    /// - Returns: 所有前缀匹配的字符数组, 无任何匹配返回空数组
    @objc open func FindPrefix(prefix: String) -> [String] {
        if prefix == "" {
            return []
        }
        
        var root = self.root
        for c in prefix {
            if let node = root.children.get(String(c)) as? TrieNode {
                root = node
                continue
            }else {
                return []
            }
        }
        
        // 当前没有子节点, 直接返回前缀即可
        if root.children.keys().count == 0 {
            return [prefix]
        }
        
        // 此时root已经指向前缀结尾字符的所在节点了, 接下来递归遍历子节点即可得到全部匹配字符串
        var ret = [String]()
        _getSubString(root: root, pre: String(prefix[0..<prefix.count-1]), arr: &ret)
        
        return ret
    }
    
    /// 传入根节点, 返回所有根节点下的字符串
    ///
    /// 算法思路: 使用递归遍历, 递归公式:
    ///
    /// f(1) = c
    ///
    /// f(n) = f(n-1) + c
    ///
    /// - Parameters:
    ///   - root: 根节点
    ///   - pre: 前缀, 不包括root.value字符
    ///   - arr: 存储字符串
    private func _getSubString(root: TrieNode, pre: String, arr: inout [String]) {
        if root.ending == true && root.deleted == false {
            arr.append(pre + root.value)
        }
        
        for key in root.children.keys() {
            let node = root.children.get(key) as! TrieNode
            _getSubString(root: node, pre: pre+root.value, arr: &arr)
        }
    }
}
