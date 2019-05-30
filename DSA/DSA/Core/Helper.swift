//
//  Helper.swift
//  DSA
//
//  Created by Cocos on 2019/5/30.
//  Copyright © 2019 Cocos. All rights reserved.
//

import Foundation

public class Helper: NSObject {
    
    /// 交换数组第i,j个元素的值
    ///
    /// inout关键字不支持桥接OC语言, 所以该方法只能在Swift中使用
    ///
    /// - Parameters:
    ///   - arr: 数组
    ///   - i: i
    ///   - j: j
    static public func Swap<T>(arr: inout [T], i: Int, j: Int) {
        let t = arr[j]
        arr[j] = arr[i]
        arr[i] = t
    }
}
