//
//  SortMerging.swift
//  DSA
//
//  Created by Cocos on 2019/5/31.
//  Copyright © 2019 Cocos. All rights reserved.
//

import Foundation

// MARK: - 归并排序
extension Sort {
    
    static private var _mergingCMP: CompareF?
    
    /// 合并两个有序数组
    ///
    ///  合并数组[p-q], [q+1, r]
    ///
    /// - Parameters:
    ///   - arr: 等待合并的数组
    ///   - p: 左数组起始位置
    ///   - q: 左数组结束位置
    ///   - r: 右数组结束位置
    /// - Returns: 有序数组
    static private func merge(arr: [Any], p: Int, q: Int, r: Int) -> [Any] {
        var arr = arr
        
        // 创建一个新数组, 最终容量大小等于r-p+1个元素.
        var mergedArr = [Any]()
        // il就是左数组索引, ir是右数组索引
        var il = p, ir = q+1
        
        while il <= q && ir <= r {
            if self._mergingCMP!(arr[il], arr[ir]) {
                mergedArr.append(arr[il])
                il += 1
            }else {
                mergedArr.append(arr[ir])
                ir += 1
            }
        }
        
        // 将剩余的元素直接追加到有序数组的末尾
        if il > q {
            mergedArr.append(contentsOf: arr[ir...r])
        }
        
        if ir > r {
            mergedArr.append(contentsOf: arr[il...q])
        }
        
        
        // 把有序部分覆盖进原数组
        for i in p...r {
            arr[i] = mergedArr[i-p]
        }
        
        print("\(mergedArr)")
        
        return arr
    }
    
    
    /// 归并排序的内部递归函数
    ///
    /// - Parameters:
    ///   - arr: 等待排序数组
    ///   - p: 数组起始位置
    ///   - r: 数组结束位置
    /// - Returns: 有序数组
    static private func sortMerging(arr: [Any], p: Int, r: Int) -> [Any] {
        var arr = arr

        // 如果只有一个元素的时候, 递归终止. 这里不论数组是如何, 只有1个元素时p必定等于r, 而不是大于等于.
        // 例如[0,8] -> [0,4][5,8], 两个数组分别是5,4个元素
        // [0,4] -> [0,2],[3,4], 两个数组分别是3,2个元素
        // [0,2] -> [0,1],[2,2], 两个数组分别是2,1个元素
        // [0,1] -> [0,0], [1,1], 两个数组分别是1,1个元素, 只有1个元素时, p==r
        //
        // 下面是4个元素的情况
        // [5,8] -> [5,6],[7,8], 两个数组分别是2,2个元素, 2个元素可以参考上面分析, 最终剩下1个元素时, p==r
        // 其他更长的数组, 比如10个, 可以分解成5,5,所以还是适用上面的分析过程
        if p == r {
            return arr
        }
        
        let q = (p + r) / 2
        
        arr = sortMerging(arr: arr, p: p, r: q)
        arr = sortMerging(arr: arr, p: q+1, r: r)
        arr = merge(arr: arr, p: p, q: q, r: r)
        
        return arr
    }
    
    
    /// 归并排序, 稳定的
    /// 时间复杂度O(nlog(n)), 空间复杂度O(n).
    ///
    /// 算法思路: 将数组分成两部分, 分别递归排序, 直到只有1个元素的时候, 递归终止
    ///  然后将两个数组使用merge函数进行有序合并, 之后再返回到上层. 这样返回到上层的时候, 被拆分的数组就是有序的.
    ///
    /// 初始数组: [11,8,3,9,7,1,2,5]
    /// [8, 11]
    /// [3, 9]
    /// [3, 8, 9, 11]
    /// [1, 7]
    /// [2, 5]
    /// [1, 2, 5, 7]
    /// [1, 2, 3, 5, 7, 8, 9, 11]
    ///
    /// - Parameters:
    ///   - arr: 待排序数组
    ///   - cmp: 排序比较闭包
    /// - Returns: 有序数组
    @objc static public func MergingSort(arr: [Any], cmp:@escaping CompareF) -> [Any] {
        Sort._mergingCMP = cmp
        return sortMerging(arr: arr, p: 0, r: arr.count - 1)
    }
}
