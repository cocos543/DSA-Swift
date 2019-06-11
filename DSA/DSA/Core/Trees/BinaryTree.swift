//
//  BinaryTree.swift
//  DSA
//
//  Created by Cocos on 2019/6/11.
//  Copyright © 2019 Cocos. All rights reserved.
//

import Foundation


/// 二叉树节点
open class BinaryTreeNode: NSObject {
    @objc open var value: Any
    @objc open var lNode: BinaryTreeNode?
    @objc open var rNode: BinaryTreeNode?
    
    @objc public init(val: Any) {
        value = val
    }
    
    @objc public init(val: Any, l: BinaryTreeNode?, r: BinaryTreeNode?) {
        lNode = l
        rNode = r
        value = val
    }
}


// MARK: - Debug
extension BinaryTreeNode {
    
    
    /// 检测树最深层树
    ///
    /// - Parameter root: 根节点
    /// - Returns: 层数
    private func _detectLevel(root: BinaryTreeNode? ) -> Int {
        guard let root = root else {
            return 0
        }
        
        var ll = 0, lr = 0
        
        ll = _detectLevel(root: root.lNode)
        lr = _detectLevel(root: root.rNode)
        
        return max(ll, lr) + 1
    }
    
    /// 可视化二叉树(中序遍历)
    ///
    ///  算法思路:
    ///  先递归获取最高层, 然后使用层序遍历把节点存入数组, 之后根据层数从数组取值打印出可视化树
    ///
    /// - Returns: 结果
    open override var description: String {
        var retString = ""
        // 先取得树的最深层数
        let maxLevel = _detectLevel(root: self)
        
        // 通过最深层数, 我们可以知道当二叉树为满二叉树时节点最多, 数量是 N = 2^L - 1
        let N = NSDecimalNumber(decimal: pow(2, maxLevel) - 1).intValue
        
        // 把整个树都放入队列中, 如果子节点为nil, 则放入一个值为-1的元素进队列.
        let curQueue = Queue(cap: N)
        
        // print array
        var pArr = [Any]()
        
        _ = curQueue.EnQueue(ele: self)
        pArr.append(self)
        
        
        // 把二叉树转按照层序遍历, 存储在数组中, 然后直接打印数组即可(暂时只支持满二叉树)
        while let cNode = curQueue.DeQueue() as? BinaryTreeNode {
            if cNode.lNode != nil {
                _ = curQueue.EnQueue(ele: cNode.lNode!)
                pArr.append(cNode.lNode!)
            }else {
                pArr.append(-1)
            }
            
            if cNode.rNode != nil {
                _ = curQueue.EnQueue(ele: cNode.rNode!)
                pArr.append(cNode.rNode!)
            }else {
                pArr.append(-1)
            }
        }
        
        // 按照层次打印出树
        var index = 0
        for i in 1...maxLevel {
            // 第i层一共有M个节点, M = 2^(i-1)
            var count = NSDecimalNumber(decimal: pow(2, i-1)).intValue
            
            // 根据当前层数, 预留左边起始空格
            var repeationCount = NSDecimalNumber(decimal: pow(2, maxLevel - i + 0)).intValue + 8
            retString += String(repeating: " ", count: repeationCount)
            
            while count > 0 {
                let ele = pArr[index]
                
                if let node = ele as? BinaryTreeNode {
                    retString = retString + "\(node.value)"
                }else {
                    retString += "0"
                }
                
                // 节点之间的距离公式是  Space = 2^(maxLevel - level + 1) - 1
                let repeationCount = NSDecimalNumber(decimal: pow(2, maxLevel - i + 1) - 1).intValue
                retString += String(repeating: " ", count: repeationCount)
                
                index += 1
                count -= 1
            }
            retString += "\n"
            
            
            if i == maxLevel {
                continue
            }
            
            // 打印出树枝
            repeationCount = NSDecimalNumber(decimal: pow(2, maxLevel - (i + 1) )).intValue
            for j in 0..<repeationCount {
                repeationCount = NSDecimalNumber(decimal: pow(2, maxLevel - i) - 1).intValue + 8 - j
                retString += String(repeating: " ", count: repeationCount)
                retString += "/"
                
                repeationCount = 2 * (j+1) - 1
                retString += String(repeating: " ", count: repeationCount)
                retString += "\\\n" 
            }
        }
        
        return retString
    }
}



/// 二叉树
open class BinaryTree: NSObject {
    
    
    /// 生成满二叉树, 节点从字母A-Z, 不能超过26个
    ///
    /// - Parameter num: 节点个数
    /// - Returns: 根节点
    @objc public static func DefaultTree(num: Int) -> BinaryTreeNode {
        if num < 1 && 26 < num {
            fatalError("The num of nodes must be greater than 1 and less than 27")
        }
        
        let root = BinaryTreeNode(val: "A")
        
        // 用于存放已经生存的节点
        let curQueue = Queue(cap: 26)
        
        _ = curQueue.EnQueue(ele: root)
        
        for i in stride(from: 2, through: num, by: 2) {
            
            // i表示将创建第i个节点
            if i > num {
                break
            }
            
            // 取出队头节点, 继续构建子节点. 这里队列取出1个进入2个, 队列永不为空, 该if语句永远为true
            if let cNode: BinaryTreeNode = curQueue.DeQueue() as? BinaryTreeNode {
                
                cNode.lNode = BinaryTreeNode(val:"\(Character(Unicode.Scalar(64+i)!))")
                // 新节点创建之后, 加入队列
                _ = curQueue.EnQueue(ele: cNode.lNode!)
                
                // 如果条件允许, 自动创建右节点
                if i + 1 <= num {
                    cNode.rNode = BinaryTreeNode(val:"\(Character(Unicode.Scalar(65+i)!))")
                    _ = curQueue.EnQueue(ele: cNode.rNode!)
                }
            }
        }
        
        return root
    }
}


// MARK: - 二叉树遍历(递归)
extension BinaryTree {
    
    
    /// 前序遍历
    ///
    /// - Parameter root: 根节点
    @objc public static func Preorder(root: BinaryTreeNode?) -> [Any] {
        guard let root = root else {
            return [Any]()
        }
        
        var arr = [Any]()
        
        arr.append(root.value)
        arr.append(contentsOf: Preorder(root: root.lNode))
        arr.append(contentsOf: Preorder(root: root.rNode))
        return arr
    }
    
    
    /// 中序遍历
    ///
    /// - Parameter root: 根节点
    @objc public static func Inorder(root: BinaryTreeNode?) -> [Any] {
        guard let root = root else {
            return [Any]()
        }
        
        var arr = [Any]()
        
        arr.append(contentsOf: Inorder(root: root.lNode))
        arr.append(root.value)
        arr.append(contentsOf: Inorder(root: root.rNode))
        
        return arr
    }
    
    
    /// 后序遍历
    ///
    /// - Parameter root: 根节点
    @objc public static func Postorder(root: BinaryTreeNode?) -> [Any] {
        guard let root = root else {
            return [Any]()
        }
        
        var arr = [Any]()
        
        arr.append(contentsOf: Postorder(root: root.lNode))
        arr.append(contentsOf: Postorder(root: root.rNode))
        arr.append(root.value)
        
        return arr
    }
}
