//
//  types.swift
//  DSA
//
//  Created by Cocos on 2019/5/27.
//  Copyright © 2019 Cocos. All rights reserved.
//

import Foundation


/// CompareF 排序比较函数. 返回true表示不需要交换位置, false表示需要交换位置.
/// CompareF 等值比较函数. 返回true表示等值, false表示不等值.
public typealias CompareF = (_ a: Any, _ b: Any) -> Bool

/// CompareF2 大小比较函数. 返回1表示a大于b, -1表示a小于等于b, 0表示a等于b
public typealias CompareF2 = (_ a: Any, _ b: Any) -> Int
