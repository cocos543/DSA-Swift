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
    /// - Returns: 匹配首次出现的位置
    @objc public static func BruteForce(str: String, pattern: String) -> Int {
        if str.count < pattern.count {
            return -1
        }
        
        for i in 0...(str.count - pattern.count) {
            // 每次都从主串取出字串进行比较
            let sub = str[i..<(i + pattern.count)]
            if sub == pattern {
                return i
            }
        }
        
        return -1
    }
    
    
    /// BM(Boyer-Moore)匹配算法,效率是KMP算法的3-4倍
    ///
    ///
    /// BM算法非常复杂, 规则较多, 这里只能简述算法思想, 详情请自行搜索教程
    ///
    /// BM算法的核心思想是在模式串和主串不匹配时,找到一定规则, 使模式串尽量往后多移动几位, 提高匹配效率, 它主要从两个方面入手:
    ///
    /// 1. 坏字符规则(Bad character rule)
    ///
    /// 2. 好后缀规则(Good suffix rule)
    ///
    /// 坏字符规则: (匹配从模式串的右到左)
    ///
    /// case1:
    ///        ↓
    /// T: GCTTCTGCTACCTTTTGCGCGCGCGCGGAA
    /// P: CCTTTTGC
    /// P: 01234567
    /// 匹配从模式串右到左:
    ///
    /// 当发现第一个不匹配的字符T:C时, 从模式串中找到第一个相同的P:C,下标是1, 则直接把P下标1的位置和T:C对齐, 即模式串前进3位(4-1),如下
    ///
    /// case2:
    ///             ↓
    /// T: GCTTCTGCTACCTTTTGCGCGCGCGCGGAA
    /// P:    CCTTTTGC
    ///
    /// 继续从右到做匹配, 存在T:A, T:A在模式串中不存在, 所以直接将模式串下标0和T:A之后的位置对齐, 结果如下
    ///
    /// T: GCTTCTGCTACCTTTTGCGCGCGCGCGGAA
    /// P:           CCTTTTGC   (匹配成功)
    ///
    /// 上面就是坏字符规则, 不过单独靠坏字符规则是不够的, 存在一种情况使坏字符规则失效, 如下
    ///
    /// case3:
    ///    ↓
    /// T: AAAAAAAAAA
    /// P: BAAA
    /// P: 0123
    ///
    /// T:A和模式串B不匹配但是P:A存在于模式串中, 此时按照case1, 模式串需要前进0位(0-0), 算法失效
    ///
    ///////////////////////////////////////////////////////////////////////
    ///
    /// 好后缀规则: (匹配从模式串的右到左)
    ///
    /// 先讲两个概念
    ///
    /// 后缀子串: abc的后缀子串是c, bc; 前缀子串: abc的前缀字串是a, ab
    ///
    /// case1:
    ///         ↓
    /// T: CGTGCCTACTTACTTACTTACTTACGCGAA
    /// P: CTTACTTAC
    /// P: 012345678
    ///
    /// 当发现第一个不匹配的字符T:C时, 进行好后缀匹配, 即查找已匹配字符T:TAC是否在P中存在, 得到相同子串P:TAC下标是2, 对齐P:TAC和T:TAC
    ///
    /// case2:
    ///         ↓
    /// T: CGTGCCTACTTACTTACTTACTTACGCGAA
    /// P:     CTTACTTAC
    /// P:     012345678
    ///
    /// 接着发现第一个不匹配的字符T:C, 继续进行好后缀匹配, 这个时候好后缀是T:TACTTAC, 无法在P中找到匹配子串, 则需要进行后缀子串匹配.
    /// 即匹配T:ACTTAC, T:CTTAC, T:TTAC, T:TAC, T:AC, T:C, 我们的最终目的是尽可能让P往后多滑动几位,
    /// 所以从长度大的后缀子串开始依次对比P的前缀,也就是模式串下标0处开始的前缀!(这里是重点)
    /// (如果模式串中间部分和T:后缀子串匹配是没用的, 因为我们已经知道好后缀不可能出现在模式串中,
    /// 唯一匹配成功的可能就是P:前缀和T:后缀子串匹配)
    ///
    /// 在模式串下标0的位置, 找到匹配的前缀P:CTTAC, 将下标0处的P:CTTAC和T:CTTAC对齐, 结果如下
    ///
    /// T: CGTGCCTACTTACTTACTTACTTACGCGAA
    /// P:         CTTACTTAC   (匹配成功)
    /// (这里需要注意, 如果T:后缀子串在P中有多个匹配时, 要选择最靠右的那个, 即滑动位数较少的, 避免滑动过头)
    ///
    ///
    ///
    /// case3:
    ///        ↓ -
    /// T: ACABCBCBACABC
    /// P: CBACABC
    ///          |
    ///          |CBACABC
    ///
    /// 再看case3, 好后缀是BC, 在模式串中无法找到匹配前缀子串, 这个时候如果直接把模式串跳到T:BC之后, 则出现过度滑动, 因为在上面`-`处原本
    /// 就可以匹配到了, 所以这就是为什么case2要对T:后缀子串进行处理的原因.
    ///
    ///////////////////////////////////////////////////////////////////////
    ///
    /// 将两个规则合并在一起, 分别计算坏字符规则和好后缀规则的滑动位数, 挑选最大的位数最为本次滑动位数.
    ///
    /// 代码的实现有几个技巧需要掌握. 1是坏字符的单个字符查找可使用散列表; 2是预处理模式串;
    ///
    ///
    ///
    /// - Parameters:
    ///   - str: 主串
    ///   - pattern: 模式串
    /// - Returns: 匹配首次出现的位置
    @objc public static func BoyerMoore(str: String, pattern: String) -> Int {
        if str.count < pattern.count {
            return -1
        }
        
        // 散列模式串中的字符
        let pMap = AddressingHashMap(cap: pattern.count)
        // 这里只记录字符在模式串中从左向右最后一次的下标
        for i in 0..<pattern.count {
            pMap.put(key: String(pattern[i]), val: i)
        }
        
        
        var suffix = Array(repeating: -1, count: pattern.count)
        suffix.append(contentsOf: [])
        var isPrefix = Array(repeating: false, count: pattern.count)
        // 先预处理模式串
        StringMatching._generateGS(pattern: pattern, suffix: &suffix, isPrefix: &isPrefix)
        
        // 先从坏字符规则开始处理, 计算出滑动位数, 再使用好后缀规则计算出滑动位数, 取较大值作为下一轮匹配的滑动位数
        var i = 0
        var slideDistance = 0
        while i <= str.count - pattern.count {
            // jStart指向模式串最后一个字符在母串对应的下标
            let jStart = pattern.count - 1 + i
            var j = jStart
            while j >= i {
                if pattern[j-i] == str[j] {
                    j -= 1
                }else {
                    break
                }
            }
            if j < i {
                return i
            }
            
            // 当出现匹配的子串时, j的位置就是坏字符所在位置, 根据坏字符规则, 计算出滑动位数
            var bgDistance = 0
            
            if let index = pMap.get(String(str[j])) as? Int {
                //先把环字符j投影到模式串上, 得到坏字符在模式串上的下标
                //            j  jStart
                //            ↓  ↓
                //   ACABCBCBOACABC
                //         OCABCAB
                let bagPIdnex = (pattern.count-1) - (jStart - j)
                // 这里可能计算出负值, 因为散列表只能记录字符出现的最右位置, 当出现下面的情况时计算得到的距离是负数
                // ACABCBCBACABC
                //       CABCAB
                bgDistance = bagPIdnex - index
            }else {
                bgDistance = pattern.count
            }
            
            ///////////////////////////////////////////////////
            
            // 使用好后缀规则, 计算出滑动位数
            var gsDistance = 0
            let gsLength = jStart - j
            
            if gsLength > 0 {
                
                // 这里同样是计算好后缀在模式串的投影下标
                var gsPIndex = (pattern.count-1) - (jStart - j) + 1
                // 好后缀在模式串中存在, 按照好后缀规则case1滑动
                if suffix[gsLength] != -1 {
                    gsDistance = gsPIndex - suffix[gsLength]
                }else {
                    // 后缀子串长度, 从gsLength-1开始到1结束
                    var subGS = gsLength
                    while subGS >= 1 {
                        subGS -= 1
                        // 后缀子串投影到模式串的下标
                        gsPIndex += 1
                        // 如果后缀子串匹配模式串的前缀子串, 则可以按照好后缀case2滑动
                        if isPrefix[subGS] == true {
                            gsDistance = gsPIndex
                            break
                        }
                    }
                }
                // 如果好后缀和后缀子串都无法在模式串中找到匹配, 则可以直接滑动模式串自身长度的位数
                if gsDistance == 0 {
                    gsDistance = pattern.count
                }
            }
            
            ///////////////////////////////////////////////////
            
            slideDistance = max(bgDistance, gsDistance)
            i += slideDistance
        }
        
        return -1
    }
    
    
    
    /// 预处理模式串
    ///
    /// 好后缀的处理规则里, 本质上就是拿模式串后缀子串比较(T:好后缀+T:好后缀的后缀子串)和模式串的子串(不包含模式串最后一个字符,即前缀子串)比较
    /// 为了提高性能, 这里先做预处理, 查找的时候直接查询数组即可
    /// 这里只需要长度即可, 例如模式串CABCAB, 后缀子串长度5:ABCAB, 长度4:BCAB, 以此类推
    ///
    /// - Parameters:
    ///   - pattern: 模式串
    ///   - suffix: 预处理的后缀数组;其中下标代表模式串的后缀子串长度, 值代表子串出现在模式串的起始下标, -1表示后缀子串没在前缀子串中出现
    ///   - isPrefix: 预处理的前缀数组;下标表示模式串的后缀子串长度, 值为true表示该子串出现在模式串最左边
    private static func _generateGS(pattern: String, suffix: inout [Int], isPrefix: inout [Bool]) {
        // 假设模式串长度m
        // 首先是确定需要预处理的子串个数, 当出现好后缀时, 意味着已经出现不匹配的字符(最少模式串第一个符合不匹配)
        // 所以需要处理的子串个数最多是m-1, 不过数组下标是表示子串长度, 下标0的位置空置, 所以数组总长度是m
        let m = pattern.count
        for i in stride(from: 0, to: m-1, by: 1) {
            var j = i
            // 这里k每次都从0开始, 意味着每一次for循环, 对比的字符长度都是1至j+1
            // 当查找长度为2, T:ababab, P:ab, 执行之后suffix[2] = 2, 符合算法要求(多个匹配时对齐最右个)
            var k = 0
            while j >= 0 && pattern[j] == pattern[m-k-1] {
                k += 1
                // suffix保存的值代表后缀子串出现在模式串的起始下标
                suffix[k] = j
                j -= 1
            }
            
            // j等于-1意味着长度为k的后缀子串和模式串前缀匹配
            if j == -1 {
                isPrefix[k] = true
            }
        }
    }
    
    
}
