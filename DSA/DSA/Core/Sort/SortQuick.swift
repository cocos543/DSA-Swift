//
//  SortQuick.swift
//  DSA
//
//  Created by Cocos on 2019/5/31.
//  Copyright © 2019 Cocos. All rights reserved.
//

import Foundation


// MARK: - 快速排序
extension Sort {
    
    static private var _quickCMP: CompareF?
    
    /// 分区函数
    ///
    /// - Parameters:
    ///   - arr: 待排序数组
    ///   - p: 数组起始位置
    ///   - r: 数组结束位置
    /// - Returns: pivot的下标; 部分有序数组: [p, pivot)区间元素都小于(大于)arr[pivot], (pivot, r]区间元素都大于(小于)arr[pivot]
    static private func partition(arr: [Any], p: Int, r: Int) -> (Int, [Any]) {
        // 下面注释以递增排序为例
        // 选择区间最后一个元素作为pivot, 计算出其所在数组位置, 并移动区间元素, 使得
        // [p, pivot)区间元素都小于(大于)arr[pivot], (pivot, r]区间元素都大于(小于)arr[pivot]
        var arr = arr
        let pivot = arr[r]
        
        // i-1 指向已处理区间最后一个元素, 其中[p, i-1]的元素小于pivot, [i+1, r-1]的元素大于pivot
        // i最终的位置就是轴点pivot元素在有序数组中的最终位置
        var i = 0
        for j in i..<r {
            if Sort._quickCMP!(arr[j], pivot) {
                Helper.Swap(arr: &arr, i: i, j: j)
                i += 1
                continue
            }
        }
        
        //将轴点和i位置元素交换
        Helper.Swap(arr: &arr, i: i, j: r)
        
        return (i, arr)
    }
    
    /// 内部排序函数
    ///
    /// - Parameters:
    ///   - arr: 待排序数组
    ///   - p: 数组起始位置
    ///   - r: 数组结束位置
    /// - Returns: 部分有序数组
    static private func sortQuick(arr: [Any], p: Int, r: Int) -> [Any] {
        // 当pivot位于区间第一个时, [p, pivot -1] 会出现 p > pivot -1的情况, 递归终止
        // 而当p=r时, 则意味着区间只有1个元素, 递归终止
        if p >= r {
            return arr
        }
        
        // 找出轴点
        var pivot = 0, arr = arr
        (pivot, arr) = Sort.partition(arr: arr, p: p, r: r)
        print("\(arr)")
        arr = Sort.sortQuick(arr: arr, p: p, r: pivot-1)
        arr = Sort.sortQuick(arr: arr, p: pivot+1, r: r)
        
        return arr
    }
    
    
    
    /// 快速排序, 不稳定的
    /// 平均时间复杂度O(nlog(n)), 最坏时间复杂度O(n), 空间复杂度O(1).
    ///
    /// 算法思想: 先找到数组轴点pivot的正确位置, 使得[p, pivot)区间元素都小于(大于)arr[pivot], (pivot, r]区间元素都大于(小于)arr[pivot]
    /// 接着一次递归处理pivot左右两部分数组, 直到p >= r, 递归终止
    ///
    /// 初始数组: [11, 8, 3, 9, 7, 1, 2, 5]
    /// [3, 1, 2, *5, 7, 8, 11, 9]
    /// [1, *2, 3, 5, 7, 8, 11, 9]
    /// [1, 2, 3, 5, 7, 8, *9, 11]
    /// [1, 2, 3, 5, 7, *8, 9, 11]
    ///
    /// - Parameters:
    ///   - arr: 待排序数组
    ///   - cmp: 排序比较闭包
    /// - Returns: 有序数组
    @objc static public func QuickSort(arr: [Any], cmp:@escaping CompareF) -> [Any] {
        Sort._quickCMP = cmp
        return Sort.sortQuick(arr: arr, p: 0, r: arr.count - 1)
    }
}


// MARK: - 快排思想的利用
extension Sort {
    
    /// 查找功能的内部函数
    ///
    /// - Parameters:
    ///   - arr: 目标数组
    ///   - p: 数组起始位置
    ///   - r: 数组结束位置
    ///   - k: 第k大
    /// - Returns: 第k大元素
    static private func findKthLargest(arr: [Any], p: Int, r: Int, k: Int) -> Any {
        if p >= r {
            return arr[r]
        }
        
        var arr = arr
        var pivot = 0
        (pivot, arr) = Sort.partition(arr: arr, p: p, r: r)
        
        // pivot从0开始的, 0就是第一大, 所以需要+1
        if pivot+1 == k {
            return arr[pivot]
        }
        if k < pivot+1 {
            return Sort.findKthLargest(arr: arr, p: p, r: pivot-1, k: k)
        }else { //pivot+1 < k
            return Sort.findKthLargest(arr: arr, p: pivot+1, r: r, k: k)
        }
    }
    
    
    /// 无序数组中查找第k大元素
    /// 时间复杂度O(n), 空间复杂度O(1).
    ///
    /// 算法思想: 利用快排分区思想, 分区一次可以找到第k大元素是轴点元素,还是轴点左区间,或者轴点右区间, 再针对目标区间继续查找k大元素即可
    /// 时间复杂度为O(n): 第一次查找遍历元素n个, 第二次n/2, 第三次n/4, ..., 最后一次为1, 等比数列求和,等于2n-1
    ///
    /// - Parameters:
    ///   - arr: 无序数组
    ///   - k: 第k大
    ///   - cmp: 比较闭包
    /// - Returns: 第k大元素
    @objc static public func FindKthLargest(arr: [Any], k: Int, cmp:@escaping CompareF) -> Any {
        guard k >= 1 && k <= arr.count else {
            fatalError("k is invalid")
        }
        
        self._quickCMP = cmp
        return findKthLargest(arr: arr, p: 0, r: arr.count-1, k: k)
    }
}
