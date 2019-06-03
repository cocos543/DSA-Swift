//
//  Sort.swift
//  DSA
//
//  Created by Cocos on 2019/5/30.
//  Copyright © 2019 Cocos. All rights reserved.
//

import Foundation

open class Sort: NSObject {
    
    /// 冒泡排序, 稳定的.
    /// 时间复杂度O(n^2), 空间复杂度O(1).
    ///
    ///  算法思路: 每一次循环结束, 都让未排序区间的最大元素上浮到区间尾部, 进入已冒泡区间的头部
    ///  所以我们设计了两个循环,外层循环用于记录已冒泡元素(右区间), 内层循环用于进行冒泡操作, 参考下面示意
    ///  原始数组: [4,5,6,3,2,1]
    ///  [4, 5, 3, 2, 1, |6]
    ///  [4, 3, 2, 1, |5, 6]
    ///  [3, 2, 1, |4, 5, 6]
    ///  [2, 1, |3, 4, 5, 6]
    ///  [1, |2, 3, 4, 5, 6]
    /// - Parameters:
    ///   - arr: 未排序数组
    ///   - cmp: 比较函数
    /// - Returns: 有序数组
    @objc static public func BubbleSort(arr: [Any], cmp: CompareF) -> [Any] {
        var arr = arr
        // 外层循环记录已排序元素数量
        for i in 0 ..< arr.count {
            // j 第一轮只需要到倒数第二个元素即可, 因为j需要和j+1的位置比较;其他情况下同理, 所以条件为 0 ..< count-1-i
            var swap = false
            for j in 0 ..< arr.count - 1 - i {
                if !cmp(arr[j], arr[j+1]) {
                    Helper.Swap(arr: &arr, i: j, j: j+1)
                    swap = true
                }
            }
            // 如果元素没有交换, 说明已有序
            if swap == false {
                break
            }
            print("\(arr)")
        }
        
        return arr
    }
    
    
    /// 直接插入排序, 稳定的, 性能比冒泡好, 推荐
    /// 时间复杂度O(n^2), 空间复杂度O(1).
    ///
    /// 算法思路: 数组左边区间为排序区间, 右边为未排序区间, 初始时有序区间只有1个元素[0,0], 未排序区间[1, n).
    ///  每轮循环我们都让未排序区间的最左元素B跟有序区间从右往左对比, 发现小于对比的元素, 则将对比的元素和B交换位置, 参考下面示意
    /// 温馨提示: 元素交换的代码可以优化成直接将比较元素往后移动一位, 直到当B找到合适位置时, B可以直接赋值到目标位置,
    ///  这样就从交换元素时的三次操作简化成移动一位的1次操作.
    ///
    /// 初始数组: [4,5,6,1,2,3]
    ///  [4|, 5, 6, 1, 2, 3]
    ///  [4, 5|, 6, 1, 2, 3]
    ///  [4, 5, 6|, 1, 2, 3]
    ///  [1, 4, 5, 6|, 2, 3]
    ///  [1, 2, 4, 5, 6|, 3]
    ///  [1, 2, 3, 4, 5, 6|]
    ///
    /// - Parameters:
    ///   - arr: 未排序数组
    ///   - cmp: 比较函数
    /// - Returns: 有序数组
    @objc static public func StraightInsertionSort(arr: [Any], cmp: CompareF) -> [Any] {
        var arr = arr
        
        //外层循环表示已排序元素区间, 初始区间是[0,0]
        for i in 0 ..< arr.count - 1 {
            var j = i + 1
            let val = arr[j]
            while j > 0 {
                if !cmp(arr[j-1], val) {
                    arr[j] = arr[j-1]
                    j -= 1
                    continue
                }
                // 必须要交换, 则表示j已经位于有序的位置, 直接跳出本轮循环
                break
            }
            arr[j] = val
            
            print("\(arr)")
        }
        return arr
    }
    
    
    /// 选择排序, 不稳定的
    /// 时间复杂度O(n^2), 空间复杂度O(1).
    ///
    /// 算法思路: 在未排序区间找到一个最小的元素, 放到左边有序区间的尾部, 参考下面示意
    ///
    /// 初始数组: [4,5,6,3,2,1]
    /// [1|, 5, 6, 3, 2, 4]
    /// [1, 2|, 6, 3, 5, 4]
    /// [1, 2, 3|, 6, 5, 4]
    /// [1, 2, 3, 4|, 5, 6]
    /// [1, 2, 3, 4, 5|, 6]
    /// [1, 2, 3, 4, 5, 6|]
    ///
    /// - Parameters:
    ///   - arr: 未排序数组
    ///   - cmp: 比较函数
    /// - Returns: 有序数组
    @objc static public func SelectionSort(arr: [Any], cmp: CompareF) -> [Any] {
        var arr = arr
        
        //外层循环表示已排序区间, 初始值为空
        for i in 0 ..< arr.count {
            var min = arr[i]
            var minIndex = i
            for j in i ..< arr.count {
                if !cmp(min, arr[j]) {
                    min = arr[j]
                    minIndex = j
                }
            }
            
            Helper.Swap(arr: &arr, i: i, j: minIndex)
            print("\(arr)")
        }
        
        return arr
    }
    
    
    /// 计数排序, 稳定的, 要求数据必须是正整数,范围越小越好
    /// 时间复杂度O(n)
    ///
    /// 算法思路: 先使用一个数组c, 下标值表示元素值, 下标对应的数组内容表示小于等于该元素的元素个数;
    /// 例如数组[2,1,2], 得到c[0,1,3] , 表示小于等于2的数字有3个, 小于等于1的数字有1个, 小于等于0的数字有0个
    /// 接着用一个临时数组, 和原数组一样大小, 然后从c中逐个查出所有元素的最终位置, 直接赋值到临时数组上即可.
    ///
    /// - Parameters:
    ///   - arr: 未排序数组
    ///   - cmp: 大小函数, 该算法只支持从小到大排序
    /// - Returns: 有序数组
    @objc static public func CountingSort(arr: [Int], cmp: CompareF2) -> [Int] {
        
        var max = 0
        for i in 0..<arr.count {
            if cmp(max, arr[i]) == -1 {
                max = arr[i]
            }
        }
        
        var c = Array(repeating: 0, count: max+1)
        for ele in arr {
            c[ele] += 1
        }
        
        //对c进行累加运行
        for i in 1..<c.count {
            c[i] = c[i-1] + c[i]
        }
        
        var tempArr = Array(repeating: 0, count: arr.count)
        for ele in arr {
            // 获取元素的最终位置
            let index = c[ele] - 1
            tempArr[index] = ele
            c[ele] -= 1
         }
        
        return tempArr
    }
}
