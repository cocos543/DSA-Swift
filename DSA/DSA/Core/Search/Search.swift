//
//  Search.swift
//  DSA
//
//  Created by Cocos on 2019/6/3.
//  Copyright © 2019 Cocos. All rights reserved.
//

import Foundation


/// 搜索
open class Search: NSObject {
    
    static private var _binaryCMP: CompareF2?
    
    
    /// 二分查找内部函数
    ///
    /// - Parameters:
    ///   - arr: 目标数组
    ///   - target: 查找目标
    ///   - low: 数组起始位置
    ///   - height: 数组结束位置
    /// - Returns: 目标位置
    static private func searchBinary(arr: [Any], target: Any, low: Int, height: Int) -> Int {
        
        if low > height {
            return -1
        }
        
        print("search in:\(arr[low...height])")
        
        let mid = low + (height - low) / 2
        let r = Search._binaryCMP!(arr[mid], target)
        if r == CompareF2Result.equal {
            return mid
        }else if r == CompareF2Result.greater {
            return Search.searchBinary(arr: arr, target: target, low: 0, height: mid - 1)
        }else {
            return Search.searchBinary(arr: arr, target: target, low: mid + 1, height: height)
        }
    }
    
    /// 二分查找
    /// 算法思路: 先找到数组中点, 对比中点元素和目标元素的值, 如果中点元素不是目标元素, 则递归查找左或者右部分, 直到low > height递归终止
    ///
    /// 初始数组: [1,3,4,5,7,8,9,12,14,17,19,20]
    /// search in:[1, 3, 4, 5, 7, 8, 9, 12, 14, 17, 19, 20]
    /// search in:[1, 3, 4, 5, 7]
    /// search in:[1, 3]
    ///
    /// - Parameters:
    ///   - arr: 目标数组
    ///   - target: 查找目标
    ///   - cmp: 比较函数
    /// - Returns: 目标位置, -1表示不存在
    @objc static public func BinarySearch(arr: [Any], target: Any, cmp: @escaping CompareF2) -> Int {
        self._binaryCMP = cmp
        
        return searchBinary(arr: arr, target: target, low: 0, height: arr.count - 1)
    }
}


// MARK: - 二分查找思想的利用
extension Search {
    
    /// 求一个数的平方根
    ///
    /// - Parameter n: 要开根的数
    /// - Returns: 计算结果
    @objc static public func Square(n: Float64) -> Float64 {
        
        // 先简单取出中间值, 可以理解为将分区分成[0,ret] [ret,n]两部分
        var mid = n / 2
        var low = 0.0, height = n
        repeat {
            let t = mid*mid
            print("\(mid) * \(mid) = \(t)")
            // 判断t^2大于小于n, 然后再取一个合适的分区的中间值, 继续求平方.
            if t > n {
                height = mid
                mid -= (mid - low) / 2
            } else if t < n {
                low = mid
                mid += (height - mid) / 2
            }

        } while fabs(mid*mid - n) > 0.00000000000001
        
        return mid
    }
}


// MARK: - 二分查找的四种变形算法
extension Search {
    
    /// 查找第一个值等于给定值的元素
    ///
    /// - Parameters:
    ///   - arr: 目标数组
    ///   - target: 目标元素
    ///   - cmp: 比较函数
    /// - Returns: 目标位置, -1表示不存在
    @objc static public func BinarySearch1(arr: [Any], target: Any, cmp: @escaping CompareF2) -> Int {
        
        //这里就不用递归了, 直接在循环内处理即可
        var low = 0, height = arr.count - 1
        var mid = 0
        while low <= height {
            mid = low + (height - low) >> 1 //右移1位等价于 /2
            if cmp(target, arr[mid]) == CompareF2Result.less {
                height = mid - 1
            }else if cmp(target, arr[mid]) == CompareF2Result.greater {
                low = mid + 1
            }else {
                // 如果mid是数组第一的位置或者mid前一个不等于target, 说明mid就是第一个等于目标的元素
                if mid == 0 || cmp(arr[mid - 1], target) != CompareF2Result.equal {
                    return mid
                }else {
                    height = mid - 1
                }
            }
        }
        
        return -1
    }
    
    /// 查找最后一个值等于给定值的元素
    ///
    /// - Parameters:
    ///   - arr: 目标数组
    ///   - target: 目标元素
    ///   - cmp: 比较函数
    /// - Returns: 目标位置, -1表示不存在
    @objc static public func BinarySearch2(arr: [Any], target: Any, cmp: @escaping CompareF2) -> Int {
        
        //这里就不用递归了, 直接在循环内处理即可
        var low = 0, height = arr.count - 1
        var mid = 0
        while low <= height {
            mid = low + (height - low) >> 1 //右移1位等价于 /2
            if cmp(target, arr[mid]) == CompareF2Result.less {
                height = mid - 1
            }else if cmp(target, arr[mid]) == CompareF2Result.greater {
                low = mid + 1
            }else {
                // 如果mid是数组最后一个或者mid后一个不等于target, 说明mid就是最后一个等于目标的元素
                if mid == arr.count-1 || cmp(arr[mid + 1], target) != CompareF2Result.equal {
                    return mid
                }else {
                    low = mid + 1
                }
            }
        }
        
        return -1
    }
    
    /// 查找第一个大于等于给定值的元素
    ///
    /// - Parameters:
    ///   - arr: 目标数组
    ///   - target: 目标元素
    ///   - cmp: 比较函数
    /// - Returns: 目标位置, -1表示不存在
    @objc static public func BinarySearch3(arr: [Any], target: Any, cmp: @escaping CompareF2) -> Int {
        
        //这里就不用递归了, 直接在循环内处理即可
        var low = 0, height = arr.count - 1
        var mid = 0
        while low <= height {
            mid = low + (height - low) >> 1 //右移1位等价于 除2
            if cmp(arr[mid], target) == CompareF2Result.less {
                low = mid + 1
            }else {
                // 如果mid是数组第一个或者mid前一个小于target, 说明mid就是第一个大于等于给定值的元素
                if mid == 0 || cmp(arr[mid - 1], target) == CompareF2Result.less {
                    return mid
                }
                height = mid - 1
            }
        }
        
        return -1
    }
    
    /// 查找最后一个小于等于给定值的元素
    ///
    /// - Parameters:
    ///   - arr: 目标数组
    ///   - target: 目标元素
    ///   - cmp: 比较函数
    /// - Returns: 目标位置, -1表示不存在
    @objc static public func BinarySearch4(arr: [Any], target: Any, cmp: @escaping CompareF2) -> Int {
        
        //这里就不用递归了, 直接在循环内处理即可
        var low = 0, height = arr.count - 1
        var mid = 0
        while low <= height {
            mid = low + (height - low) >> 1 //右移1位等价于 除2
            if cmp(arr[mid], target) == CompareF2Result.greater {
                height = height - 1
            }else {
                // 如果mid是数组最后一个或者mid后一个大于target, 说明mid就是最后一个小于等于给定值的元素
                if mid == arr.count-1 || cmp(arr[mid + 1], target) == CompareF2Result.greater {
                    return mid
                }
                low = mid + 1
            }
        }
        
        return -1
    }
}
