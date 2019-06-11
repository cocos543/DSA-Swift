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
    ///  如果元素重复, 需要扩展节点, 提供一个next指针指向重复的节点, 也就是扩展成链表.
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
    /// 2. 目标节点只有一个节点, 指向父节点的指针直接指向子节点即可
    /// 3. 目标有左右子节点, 找到右子树的最小值, 替换到目标位置即可
    ///
    /// - Parameters:
    ///   - root: 根节点
    ///   - val: 目标值
    ///   - cmp: 等值比较函数
    @objc public static func Delete(root: BinaryTreeNode, val: Any, cmp: CompareF2) {
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
            return
        }
        
        // 目标有左右节点
        
        // 目标只有一个节点
        
        // 目标没有左右节点
        if p!.lNode == nil && p!.rNode == nil {
            if pf!.lNode == p {
                pf!.lNode = nil
            }else {
                pf!.rNode = nil
            }
        }
        
        
        
        
    }
}
