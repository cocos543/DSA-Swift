//
//  Heap.swift
//  DSA
//
//  Created by Cocos on 2019/6/12.
//  Copyright © 2019 Cocos. All rights reserved.
//

import Foundation


/// 堆顶位置
private let HEAP_TOP_INDEX = 1
private let NODE_NOT_EXIST = -1

/// 堆
/// 因为堆是一个完全二叉树, 使用数组实现, 最节省空间;
/// 支持高效动态扩容, 无须事先定义cap
open class Heap: NSObject {
    
    /// 堆的容量
    @objc open var cap: Int {
        return _cap
    }
    
    /// 堆里的元素个数
    @objc open var count: Int {
        return _count
    }
    
    private var _cap: Int
    
    private var _count: Int = 0
    
    /// 数组初始空间为容量+1, 其中第一个位置为哨兵, 空置
    private var _heap: [Any?]
    
    
    @objc public override init() {
        
        _cap = 1
        _heap = [Any]()
        
        for _ in 0...1 {
            _heap.append(nil)
        }
    }
    
    
    /// 扩容堆容量
    ///
    /// - Parameter num: 新增大小
    private func _extendHeap(num: Int) {
        _cap += num
        for _ in 0..<num {
            _heap.append(nil)
        }
    }
}


// MARK: - Debug
extension Heap {
    open override var description: String {
        var retString = ""
        for node in _heap {
            if let e = node {
                retString += "\(e)-"
            }
        }
        return retString
    }
}


// MARK: - 堆的基本节点定位
extension Heap {
    
    /// 获取index的父节点
    ///
    /// - Parameter index: 当前节点
    /// - Returns: 父节点位置, 0表示不存在
    private func _parent(index: Int) -> Int {
        let i = index / 2
        if i == 0 {
            return NODE_NOT_EXIST
        }
        return i
    }
    
    
    /// 获取左节点
    ///
    /// - Parameter index: 当前节点
    /// - Returns: 左节点位置, NODE_NOT_EXIST表示不存在
    private func _lNode(index: Int) -> Int {
        let i = index * 2
        if i > _count {
            return NODE_NOT_EXIST
        }
        
        return i
    }
    
    /// 获取右节点
    ///
    /// - Parameter index: 当前节点
    /// - Returns: 右节点位置, NODE_NOT_EXIST表示不存在
    private func _rNode(index: Int) -> Int {
        let i = index * 2 + 1
        if i > _count {
            return NODE_NOT_EXIST
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
        if _count == _cap {
            // 扩容堆
            _extendHeap(num: _cap)
        }
        
        // 先把元素插入到数组末尾, 再进行堆化
        _count += 1
        var cIndex = _count
        _heap[cIndex] = val
        
        while true {
            // 调整节点, 使其符合堆的定义
            var parent = self._parent(index: cIndex)
            if parent != NODE_NOT_EXIST && !cmp(_heap[parent]!, val) {
                Helper.Swap(arr: &_heap, i: parent, j: cIndex)
                cIndex = parent
                parent = self._parent(index: cIndex)
            }else {
                break
            }
        }
    }
    
    
    
    /// 删除堆顶元素
    ///
    ///  删除堆顶元素之后, 将树末尾节点, 也就是数组最后一个元素直接插入到堆顶, 再向下调整堆, 直到符合堆的定义
    ///  调整堆也比较简单, 直接比较左子节点的大小, 确认是否交换即可
    ///
    /// - Parameter cmp: 排序比较函数
    /// - Returns: 被删除的值, 堆内没数据返回nil
    @objc public func DeleteTop(cmp: CompareF) -> Any? {
        let topNode = _heap[HEAP_TOP_INDEX]
        
        // 堆顶为nil说明树里没有数据
        if topNode == nil {
            return nil
        }
        
        
        // 将树最后一个节点放入堆顶
        _heap[HEAP_TOP_INDEX] = _heap[_count]
        _heap[_count] = nil
        _count -= 1
        
        // 重新调整堆
        var cIndex = HEAP_TOP_INDEX
        
        while true {
            // 找出子节点中比较大(大顶堆)的那个, 和cIndex对比
            let lNode = self._lNode(index: cIndex)
            let rNode = self._rNode(index: cIndex)
            var nIndex = 0
            
            if lNode != NODE_NOT_EXIST && rNode != NODE_NOT_EXIST {
                // 如果返回true, 表示 lNode是目标节点, 返回false表示rNode是目标节点
                if cmp(_heap[lNode]!, _heap[rNode]!) {
                    nIndex = lNode
                }else {
                    nIndex = rNode
                }
            }else if lNode != NODE_NOT_EXIST {
                // 如果只有左节点, 直接和左节点比较
                nIndex = lNode
            }else if rNode != NODE_NOT_EXIST{
                nIndex = rNode
            }else {
                // 只剩下根节点
                break
            }
            
            // 不需要交换时,退出循环
            if cmp(_heap[cIndex]!, _heap[nIndex]!) {
                break
            }

            Helper.Swap(arr: &_heap, i: cIndex, j: nIndex)
            cIndex = nIndex
        }
        return topNode
    }
    
}


// MARK: - 堆排序
extension Heap {
    @objc public static func Sort(arr: [Any], cmp: CompareF) -> [Any] {
        return []
    }
}
