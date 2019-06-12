//
//  Heap.swift
//  DSA
//
//  Created by Cocos on 2019/6/12.
//  Copyright © 2019 Cocos. All rights reserved.
//

import Foundation


/// 堆
/// 因为堆是一个满二叉树, 使用数组实现, 最节省空间
open class Heap: NSObject {
    
    /// 堆的容量
    var cap: Int {
        return _cap
    }
    let _cap: Int
    
    /// 堆里的元素个数
    var count: Int {
        return _count
    }
    var _count: Int = 0
    
    /// 数组初始空间为容量+1, 其中第一个位置为哨兵, 空置
    var heap: [Any]
    
    @objc public init(cap: Int) {
        _cap = cap
        heap = Array(repeating: 0, count: cap + 1)
    }
}


// MARK: - 堆的基本节点定位
extension Heap {
    
    /// 获取index的父节点
    ///
    /// - Parameter index: 当前节点
    /// - Returns: 父节点位置, 0表示不存在
    private func _parent(index: Int) -> Int {
        return index / 2
    }
    
    
    /// 获取左节点
    ///
    /// - Parameter index: 当前节点
    /// - Returns: 左节点位置, 0表示不存在
    private func _lNode(index: Int) -> Int {
        let i = index * 2
        if i > self.cap {
            return 0
        }
        
        return i
    }
    
    /// 获取右节点
    ///
    /// - Parameter index: 当前节点
    /// - Returns: 右节点位置, 0表示不存在
    private func _rNode(index: Int) -> Int {
        let i = index * 2 + 1
        if i > self.cap {
            return 0
        }
        
        return i
    }
}


// MARK: - 堆的基本操作
extension Heap {

    /// 插入数据
    ///
    /// 以大顶堆为例: 先把元素插入到树的末尾, 也就是数组的末尾, 然后依次和父节点比较, 如果比父节点大, 则和父节点交换位置, 然后继续比较直到堆顶
    ///
    ///
    /// - Parameters:
    ///   - val: 新数据
    ///   - cmp: 排序比较函数
    @objc public func Insert(val: Any, cmp: CompareF) {
        // 先把元素插入到数组末尾, 再进行堆化
        _count += 1
        self.heap[_count] = val
        
        // 进行堆化
        var parent = self._parent(index: _count)
        while parent > 0 && !cmp(val, self.heap[parent]) {
            
        }
    }
    
    
    
    /// 删除堆顶元素
    ///
    /// - Parameter cmp: 排序比较函数
    /// - Returns: 被删除的值, 堆内没数据返回nil
    @objc public func DeleteTop(cmp: CompareF) -> Any? {
        return nil
    }
    
}


// MARK: - 堆排序
extension Heap {
    @objc public static func Sort(arr: [Any], cmp: CompareF) -> [Any] {
        return []
    }
}
