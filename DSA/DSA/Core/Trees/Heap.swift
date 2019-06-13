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
    ///  从下往上堆化
    /// 以大顶堆为例: 先把元素插入到树的末尾, 也就是数组的末尾, 然后依次和父节点比较, 如果比父节点大, 则和父节点交换位置, 然后继续比较直到堆顶
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
    
    
    
    /// 删除堆顶元素, 时间复杂度O(logn)
    ///
    //   从上往下堆化
    ///  删除堆顶元素之后, 将树末尾节点, 也就是数组最后一个元素直接插入到堆顶, 再向下调整堆, 直到符合堆的定义
    ///  调整堆也比较简单, 直接比较左子节点的大小, 确认是否交换即可.
    ///  堆化堆顶的时间复杂度和树高度成正比, 高度为logn
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
            }else {
                // 只剩下根节点,(完全二叉树不存在只有右节点的情况)
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
    
    private static var _cmp: CompareF?
    
    /// 堆化
    ///
    ///
    /// - Parameters:
    ///   - arr: 原始数组
    ///   - i: 关注的位置
    ///   - cap: 要堆化的数组区间, [1-cap]
    /// - Returns: 被堆化的数组
    private static func _heapify(arr: inout [Any], index: Int, cap: Int) {
        // 关注位置
        var cIndex = index
        
        while true {
            // 找出子节点中比较大(大顶堆)的那个, 和cIndex对比
            var lNode = cIndex * 2
            if lNode > cap {
                lNode = NODE_NOT_EXIST
            }
            
            var rNode = cIndex * 2 + 1
            if rNode > cap {
                rNode = NODE_NOT_EXIST
            }
            
            var nIndex = 0
            
            if lNode != NODE_NOT_EXIST && rNode != NODE_NOT_EXIST {
                // 如果返回true, 表示 lNode是目标节点, 返回false表示rNode是目标节点
                if Heap._cmp!(arr[lNode], arr[rNode]) {
                    nIndex = lNode
                }else {
                    nIndex = rNode
                }
            }else if lNode != NODE_NOT_EXIST {
                // 如果只有左节点, 直接和左节点比较
                nIndex = lNode
            }else {
                // 只剩下根节点
                return
            }
            
            // 不需要交换时,退出循环
            if Heap._cmp!(arr[cIndex], arr[nIndex]) {
                return
            }
            
            Helper.Swap(arr: &arr, i: cIndex, j: nIndex)
            cIndex = nIndex
        }
    }
    
    
    /// 建堆, 时间复杂度O(logn)
    ///
    /// 算法思想: 堆化的思路和上面删除堆顶的堆化类似, 也是从上往下堆化;
    /// 依次从后向前关注每一个非叶子节点, 被关注的节点将和子节点比较, 确定是否交换位置, 直到最前(堆顶)节点被关注和堆化, 退出循环.
    /// 这种算法的时间复杂度为O(n), 如果采用插入节点的算法, 从下往上堆化全部节点, 时间复杂度O(n*logn)
    ///
    /// - Parameters:
    ///   - arr: 普通数组
    ///   - cmp: 比较函数
    /// - Returns: 堆化数组, 数组第0个位置为空置节点
    @objc public static func Build(arr: [Any], cmp: @escaping CompareF) -> [Any] {
        _cmp = cmp
        // 堆化数组
        var arr = [0] + arr
        for i in stride(from: (arr.count-1)/2, through: 1, by: -1) {
            Heap._heapify(arr: &arr, index: i, cap: arr.count - 1)
        }
        
        return arr
    }
    
    /// 堆排序, 时间复杂度O(n*logn)
    ///
    /// 算法思路:
    ///
    /// (最大堆为例) 第一步先对整个数组建堆, 然后将堆顶(最大值)和最后一个元素交换位置, 关注堆顶,继续堆化, 直到未排序区间只有1个元素时停止循环.
    ///
    /// 复杂度分析:
    ///
    /// 建堆的时间复杂度是O(n);
    /// 排序的时间复杂度:循n-1次, 每次都是关注堆顶开始堆化, 单次循环时间复杂度logn, 所以排序的时间复杂度是n*logn
    /// 综合起来堆排序的时间复杂度是 n*logn
    ///
    /// - Parameters:
    ///   - arr: 未排序数组, 数组的数据部分从下标为1的地方开始
    ///   - cmp: 比较函数
    /// - Returns: 有序数组
    @objc public static func Sort(arr: [Any], cmp: @escaping CompareF) -> [Any] {
        var arr = Heap.Build(arr: arr, cmp: cmp)
        
        // 每次取出未排序部分的最后一个元素和堆顶交换
        // 元素的数量
        var cap = arr.count - 1
        
        for i in stride(from: cap, to: 1, by: -1) {
            Helper.Swap(arr: &arr, i: 1, j: i)
            
            cap -= 1
            // 继续堆化堆顶
            Heap._heapify(arr: &arr, index: 1, cap: cap)
        }
        
        
        // 按照其他排序规则一样, 这里大顶堆排出来的是顺序(小顶堆排除的是逆序),需要反转一次, 顺便把空置节点移除
        return arr[1...arr.count-1].reversed()
    }
}
