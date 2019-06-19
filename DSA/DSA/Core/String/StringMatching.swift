//
//  StringMatching.swift
//  DSA
//
//  Created by Cocos on 2019/6/19.
//  Copyright © 2019 Cocos. All rights reserved.
//

import Foundation



// MARK: - 扩展系统的String类, 支持整型下下标访问
extension String {
    fileprivate subscript(i: Int) -> Character {
        get {
            return self[self.index(self.startIndex, offsetBy: i)]
        }
    }
    
    fileprivate subscript(r: Range<Int>) -> Substring {
        get {
            let startIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
            let endIndex = self.index(self.startIndex, offsetBy: r.upperBound)
            return self[startIndex..<endIndex]
        }
    }
    
    fileprivate subscript(r: ClosedRange<Int>) -> Substring {
        get {
            let startIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
            let endIndex = self.index(self.startIndex, offsetBy: r.upperBound)
            return self[startIndex...endIndex]
        }
    }
}


/// 字符串匹配算法类
///
open class StringMatching: NSObject {
    
    /// 朴素匹配算法
    ///
    ///  逐个匹配主串, 每次前进一个字符, 一共匹配n-m+1次(主串长n, 模式串长m)
    ///
    /// - Parameters:
    ///   - str: 主串
    ///   - pattern: 模式串
    /// - Returns: 匹配的起始位置
    @objc public static func BruteForce(str: String, pattern: String) -> Int {
        for i in 0...(str.count - pattern.count) {
            // 每次都从主串取出字串进行比较
            let sub = str[i..<(i + pattern.count)]
            if sub == pattern {
                return i
            }
        }
        
        return -1
    }
}
