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

// MARK: - 扩展系统的String类, 支持整型下下标访问
extension String {
    internal subscript(i: Int) -> Character {
        get {
            return self[self.index(self.startIndex, offsetBy: i)]
        }
    }
    
    internal subscript(r: Range<Int>) -> Substring {
        get {
            let startIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
            let endIndex = self.index(self.startIndex, offsetBy: r.upperBound)
            return self[startIndex..<endIndex]
        }
    }
    
    internal subscript(r: ClosedRange<Int>) -> Substring {
        get {
            let startIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
            let endIndex = self.index(self.startIndex, offsetBy: r.upperBound)
            return self[startIndex...endIndex]
        }
    }
}
