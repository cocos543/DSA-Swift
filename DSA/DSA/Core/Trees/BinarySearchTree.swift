//
//  BinarySearchTree.swift
//  DSA
//
//  Created by Cocos on 2019/6/11.
//  Copyright © 2019 Cocos. All rights reserved.
//

import Foundation


/// 二叉查找树
///
/// 任意一个节点, 其左子树的值都小于自身, 右子树的值都大于自身
open class BinarySearchTree: NSObject {
    
}


// MARK: - 二叉查找树节点的查找, 插入, 删除
extension BinarySearchTree {
    
    /// 查找
    ///
    /// - Parameters:
    ///   - root: 根节点
    ///   - val: 目标值
    ///   - cmp: 比较函数
    /// - Returns: 查找到的节点
    @objc public static func Find(root: BinaryTreeNode, val: Any, cmp: CompareF2) -> BinaryTreeNode? {
        
        var p: BinaryTreeNode? = root
        while p != nil {
            // 目标小于p, 则目标在左子树
            if cmp(val, p!.value) == CompareF2Result.less {
                p = p!.lNode
            }else if cmp(val, p!.value) == CompareF2Result.greater {
                // 目标大于p, 则目标在右子树
                p = p!.rNode
            }else {
                return p
            }
        }
        
        return nil
    }
    
    
    /// 插入新节点(假设元素不重复)
    ///
    ///  如果元素重复, 需要扩展节点, 提供一个next指针指向重复的节点, 也就是单个节点扩展成链表.
    ///  一般都不会直接使用二叉查找树这种数据结构(一般使用红黑树), 所以这里就简单实现基本功能即可.
    ///
    /// - Parameters:
    ///   - root: 根节点
    ///   - node: 新节点
    @objc public static func Insert(root: BinaryTreeNode, val: Any, cmp: CompareF2) {
        var p: BinaryTreeNode? = root
        while p != nil {
            // 目标小于p, 则目标在左子树
            if cmp(val, p!.value) == CompareF2Result.less {
                if p!.lNode == nil {
                    p!.lNode = BinaryTreeNode(val: val)
                    return
                }
                p = p!.lNode
            }else if cmp(val, p!.value) == CompareF2Result.greater {
                // 目标大于p, 则目标在右子树
                if p!.rNode == nil {
                    p!.rNode = BinaryTreeNode(val: val)
                    return
                }
                p = p!.rNode
            }else {
                fatalError("Duplicate value")
            }
        }
    }
    
    
    /// 删除节点
    ///
    /// 算法思路: 删除节点分3种情况处理
    /// 1. 目标节点没有子节点, 直接删除
    /// 2. 目标节点只有一个子节点, 指向目标节点的指针直接指向子节点即可
    /// 3. 目标有左右子节点, 找到右子树的最小值, 替换到目标位置即可
    ///
    /// - Parameters:
    ///   - root: 根节点
    ///   - val: 目标值
    ///   - cmp: 等值比较函数
    /// - Returns: 树根节点
    @objc public static func Delete(root: BinaryTreeNode, val: Any, cmp: CompareF2) -> BinaryTreeNode? {
        // 先找到目标节点的父节点
        var p: BinaryTreeNode? = root
        
        //目标节点的父节点
        var pf: BinaryTreeNode?
        while p != nil && cmp(val, p!.value) != CompareF2Result.equal {
            // 目标小于p, 则目标在左子树
            pf = p
            if cmp(val, p!.value) == CompareF2Result.less {
                p = p!.lNode
            }else if cmp(val, p!.value) == CompareF2Result.greater {
                // 目标大于p, 则目标在右子树
                p = p!.rNode
            }
        }
        
        // 找不到目标,直接返回
        if p == nil {
            return root
        }
        
        
        // loanerNode 节点用于指向要被替换到删除位置的节点
        var loanerNode: BinaryTreeNode?
        
        // 目标有左右节点
        if p!.lNode != nil && p!.rNode != nil {
            // 用于指向右子树最小节点的父节点(father)
            var fMinNode = p!
            var minNode = p!.rNode!
            
            while minNode.lNode != nil {
                fMinNode = minNode
                minNode = minNode.lNode!
            }
            
            // 这是一个技巧
            // 将右子树最小节点的值直接赋值到即将被删除的节点的位置, 这样比整个节点替换过去要方便, 因为整个节点的替换需要类似链表一样插入
            p!.value = minNode.value
            
            // 最小节点需要被删除, 所以直接将p指向最小节点即可, 后续代码会对p进行判断确定删除逻辑
            p = minNode
            pf = fMinNode
        }
        
        // 目标只有一个子节点, 或者没有子节点
        if p!.lNode != nil {
            loanerNode = p!.lNode
        }else if p!.rNode != nil {
            loanerNode = p!.rNode
        }else {
            loanerNode = nil
        }
        
        
        // 如果目标是根节点, 则loanerNode会成为新的根节点, 如果loanerNode为空, 则意味着整棵树都删光了.
        if pf == nil {
            return loanerNode
        }else if pf!.lNode == p {
            pf!.lNode = loanerNode
        }else {
            pf!.rNode = loanerNode
        }
        
        return root
    }
}



/// 红黑树的节点
class RBTreeNode: BinaryTreeNode {
    
}

// MARK: - 红黑树
extension BinarySearchTree {
    ///
    /// 红黑树的实现有点像玩魔方, 步骤和方法都是固定的, 我们玩魔方的时候都没有去理解为什么是这个步骤, 所以实现红黑树的时候也不要去理解了.
    /// 只能说, 很佩服天才的大脑, 这样的东西都能想出来...
    ///
    
    
    /// 查找
    ///
    /// - Parameters:
    ///   - root: 根节点
    ///   - val: 删除的值
    ///   - cmp: 大小比较函数
    /// - Returns: 根节点
    private func RBTreeFind(root: RBTreeNode, val: Any, cmp: CompareF2) -> RBTreeNode {
        return root
    }
    
    /// 节点插入
    ///
    /// - Parameters:
    ///   - root: 根节点
    ///   - val: 删除的值
    ///   - cmp: 大小比较函数
    /// - Returns: 根节点
    private func RBTreeInsert(root: RBTreeNode, val: Any, cmp: CompareF2) -> RBTreeNode {
        /// 等待实现
        return root
    }
    
    
    /// 节点删除
    ///
    /// - Parameters:
    ///   - root: 根节点
    ///   - val: 删除的值
    ///   - cmp: 大小比较函数
    /// - Returns: 根节点
    private func RBTreeDelete(root: RBTreeNode, val: Any, cmp: CompareF2) -> RBTreeNode? {
        /// 等待实现
        return root
    }
}
