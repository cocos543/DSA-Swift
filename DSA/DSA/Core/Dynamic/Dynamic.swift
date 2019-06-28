//
//  Dynamic.swift
//  DSA
//
//  Created by Cocos on 2019/6/27.
//  Copyright © 2019 Cocos. All rights reserved.
//

import Foundation

internal class Dynamic {
    
    
    /// 01背包问题
    ///
    /// 利用动态规划找到最优解, 这里只返回最终能放入的最大重量.
    /// 如果想得到放入背包的每个物品的重量, 需要增加一个prevPath 前置路径记录表
    ///
    /// - Parameters:
    ///   - items: 物品重量
    ///   - cap: 背包容量
    /// - Returns: 物品放入背包的顺序
    internal static func Knapsack(items: [Int], cap: Int) -> [Int] {
        // 以下注释参考数据是 items: [2, 2, 4, 6, 3]
        // 背包总容量是cap, 物品总数n = items.count, 将问题分为n个阶段, 由于当前物品最小单位是1, 所以每一个中背包的总量最多有cap总可能
        // 把所有阶段的可能状态存入一个二维数组, 第一维下标表示当前阶段, 也就是考察第n个物品; 第二维下标表示考察第n个物品后背包的重量
        // 数组的值表示是否存在这样的状态, 比如states[1][2] = true 表示考察完第1个物品之后, 背包出现了重量为2的状态.
        // 因为同样的状态都被叠加到一起了, 所以分支少效率比回溯算法高(第0个物品不放, 第1个放入, 对应状态是states[1][2]; 第0个放,第1个不放,
        // 对应的状态也是states[1][2])
        var states = [[Bool]]()
        
        for _ in 0..<items.count {
            states.append([Bool](repeating: false, count: cap+1))
        }
        
        // 路径记录表, key格式"i-j" 表示当前考察的第i个物品, 放入背包后总重量j; 值表示上一个状态转移自哪一个物品, 保存其重量
        var prevPath = [String: Int]()
    
        
        // 考察第0个物品时, 特殊情况需要特殊处理, 只有两种情况, 一种是放入背包, 另一种不放入背包
        // 不放入背包
        states[0][0] = true
        
        // 放入背包
        if items[0] <= cap {
            states[0][items[0]] = true
            prevPath["0-\(items[0])"] = items[0]
        }
        
        // 每次都从上阶段的状态里计算得到当前状态所有可能结果
        for i in 1..<items.count {
            // 计算出当前阶段的物品不放入背包的所有可能状态, j表示上一阶段的背包总重量
            for j in 0...cap {
                //如果上一阶段的状态存在, 则状态可以直接转移到当前状态
                if states[i-1][j] == true {
                    states[i][j] = true
                }
            }
            
            // 计算出当前阶段的物品放入背包的所有可能状态
            // 这里有一点小技巧,那些状态大于cap-items[i]的, 再放入第i个物品时就超重了, 所以不存在放入背包的可能, 也就不需要计算状态了
            // j表示上一阶段的背包总重量
            for j in 0...cap-items[i] {
                // 同理
                if states[i-1][j] == true {
                    states[i][j+items[i]] = true
                    
                    // 保存状态路径
                    prevPath["\(i)-\(j+items[i])"] = j
                }
            }
    
        }

        
        var maxJ = 0
        // 在最后一个阶段的最右边开始找, 第一个存在的状态, 就是最优解. 也就是最接近背包总量
        for j in stride(from: cap, through: 0, by: -1) {
            if states[items.count-1][j] {
                maxJ = j
                break
            }
        }
        
        let paths = Dynamic._dumpKnapsackPaths(prevPath: prevPath, i: items.count-1, j: maxJ)
        
        return paths
    }
    
    
    /// 打印出放入的物品重量数组
    ///
    /// - Parameters:
    ///   - prevPath: 前置路径记录表
    ///   - i: 阶段
    ///   - j: 重量
    /// - Returns: 物品重量数组
    internal static func _dumpKnapsackPaths(prevPath: [String: Int], i: Int, j: Int) -> [Int] {
        if i == 0 {
            return [j]
        }
        
        let prevJ = prevPath["\(i)-\(j)"]
        
        // 如果上一个记录不存在, 说明上一个阶段没有放入任何物品, 可以直接跳过继续向上
        if prevJ == nil {
            return Dynamic._dumpKnapsackPaths(prevPath: prevPath, i: i-1, j: j)
        }
        
        // nextJ为0表示上一个阶段背包中没有任何物品, 所以当前阶段的重量就是第一个物品的重量, 递归结束
        if prevJ == 0 {
            return [j]
        }
        
        return Dynamic._dumpKnapsackPaths(prevPath: prevPath, i: i-1, j: prevJ!) + [j-prevJ!]

    }
    
    
    /// 优化背包问题
    ///
    /// 观察上面Knapsack算法, 其中的二维数组每次都只有n-1阶段被使用到, 结束时答案也只是在第n阶段中找, 所以可以利用滚动数组优化空间占有率
    ///
    /// - Parameters:
    ///   - items: 物品重量
    ///   - cap: 背包容量
    /// - Returns: 物品放入背包的顺序
    internal static func KnapsackLite(items: [Int], cap: Int) -> [Int] {
        var states = [Bool](repeating: false, count: cap+1)
        
        // 路径记录表, key格式"i-j" 表示当前考察的第i个物品, 放入背包后总重量j; 值表示上一个状态转移自哪一个物品, 保存其重量
        var prevPath = [String: Int]()
        
        
        // 考察第0个物品
        // 不放入背包
        states[0] = true
        
        // 放入背包
        if items[0] <= cap {
            states[items[0]] = true
            prevPath["0-\(items[0])"] = items[0]
        }
        
        for i in 1..<items.count {
            
            // 第i个物品不放入背包, 当前阶段和上一阶段状态相同, 不需要滚动数组
            
            // 第i个物品放入背包, 需要把上一阶段状态转移到当前阶段
            // j表示上一阶段的背包总重量
            for j in 0...cap-items[i] {
                if states[j] == true {
                    states[j + items[i]] = true
                }
                
                // 保存状态路径
                prevPath["\(i)-\(j+items[i])"] = j
            }
            
        }
        
        var maxJ = 0
        // 在最后一个阶段的最右边开始找, 第一个存在的状态, 就是最优解. 也就是最接近背包总量
        for j in stride(from: cap, through: 0, by: -1) {
            if states[j] {
                maxJ = j
                break
            }
        }
        
        let paths = Dynamic._dumpKnapsackPaths(prevPath: prevPath, i: items.count-1, j: maxJ)
        
        
        
        return paths
    }
}



// MARK: - 矩阵模型
extension Dynamic {
    
    /// 求解类似杨辉三角的问题, 把三角形看成正方形就是矩阵状态转移的模型了(从左上角开始, 走到右下角, 每阶段只能往右或者下走动)
    ///                       阶段
    ///          5             0
    ///        3   7           1
    ///      4   5   9         2
    ///    8   1   6   2       3
    ///  9  10   7   1   6     4
    ///
    ///  每一个节点只能到达下面一层相邻左右两个节点, 例如3只能到达4或者5, 求从第一层到达最下层是经历的数字最小是多少?
    ///
    /// 算法思路: 利用动态规划, 到达节点j如果有多个路径, 则选择其中路径值最小的vj', 作为当前阶段的最优解, 如下所示转移状态
    /// 状态数组states[j] = vj' + vj, vj' 表示到达节点j之前走过的值, vj节点j的值
    ///
    internal static func LikePascaltriangle() {
        // 生成数组
        let triangle = [[5], [3, 7], [4, 5, 9], [8, 1, 6, 2], [9, 10, 7, 1, 6]]
        // 使用滚动数组保存状态, 可以看出第n行有n个节点, n从1开始
        var states = [[Int]]()
        for arr in triangle {
            states.append([Int](repeating: 0, count: arr.count))
        }
        
        // 把问题分成triganle.count-1个阶段
        // 第0个阶段只有一个节点
        states[0][0] = triangle[0][0]
        
        for i in 1..<triangle.count {
            for j in 0...i {
                // 只有非边缘节点才存在多个到达路径, 所以只处理非边缘节点
                if j != 0 && j != i {
                    // 存在多个路径的情况, 只保留最小路径
                    states[i][j] = min(states[i-1][j-1], states[i-1][j]) + triangle[i][j]
                }else {
                    if j == 0 {
                        // 处理左边缘
                        states[i][j] = states[i-1][j] + triangle[i][j]
                    }else {
                        // 处理右边缘
                        states[i][j] = states[i-1][j-1] + triangle[i][j]
                    }
                }
            }
        }
        
        // 从状态里找到最小值, 就是最优解
        var min = Int.max
        for e in states[triangle.count-1] {
            if e < min {
                min = e
            }
        }
        
        print(min)
    }
}


// MARK: - 硬币找零模型
extension Dynamic {
    
    
    /// 硬币找零模型
    ///
    /// 假设一共有n种硬币(单位是元), 最小1元硬币, 需要组合成m元, 求最少需要多少个硬币.
    ///
    /// 算法思路: 如果全部都用1元硬币, 那一共就需要m个硬币, 所以把问题看成最多有n个阶段, 每一个阶段选择硬币, 画出递归树,
    /// 可以发现存在相同的子问题, 比如前2阶段分别选择1, 3元和3, 1元硬币, 得到的当前状态都是相同的, 也就是一共4元了.
    /// 而下一阶段要选择什么数量的硬币, 不影响前面阶段已经选择的硬币, 所以这个问题适合使用动态规划解决.
    ///
    ///
    /// - Parameters:
    ///   - coins: 币种
    ///   - money: 目标金额
    /// - Returns: 最小硬币数
    internal static func MinCoins(coins: [Int], money: Int) -> Int {
        // 一共三种硬币, 1, 3, 5, 需要支付9元, 求最少需要多少个硬币
        
        // 使用状态表法解决, 这里不能用滚动数组, 因为每一阶段n种硬币都要选择一次, 如果直接更新到当前阶段, 会导致其他硬币选择时上一阶段的状态丢失
        // 下标表示当前阶段的金额, 值表示存在这样的状态
        var states = [[Bool]](repeating: [Bool](repeating: false, count: money + 1), count: money)
        
        
        // 当前阶段的某一个状态, 只会从上一阶段的某一个状态转移而来, 一共不超过m个阶段, 从第0阶段开始
        // 第0阶段一共有三种选择, 分别是1,3,5元
        for c in coins {
            if c < money {
                states[0][c] = true
            }else if c == money {
                return 1
            }
        }
        
        
        // i表示第i阶段
        for i in 1..<money {
            // j 表示上一个阶段的总金额
            for j in 1...money {
                if states[i-1][j] {
                    // 每一个阶段都可以选择n种硬币种的一种, 这里需要把硬币列表都拿出来做可能性决策
                    for c in coins {
                        // 如果上一个阶段的状态存在, 则转移到当前阶段
                        if j + c <= money {
                            states[i][j+c] = true
                        }
                        
                        // 如果总金额到达要求, 立即返回
                        if states[i][money] {
                            return i + 1
                        }
                    }
                }
                
            }
        }
        
        // 如果没有符合的金额, 那就只能全部用1元了, 一共就money种
        return money
    }
}



// MARK: - 求解字符串相似度模型
extension Dynamic {
    
    /// 根据Levenshtein规则求字符串的相似度, 返回字符串的差距
    ///
    /// 距离的计算规则是, 允许对字符串的字符进行插入删除修改, 需要做多少个步骤才能使两个字符串一模一样, 这个步骤就是所谓的距离
    /// 距离越大, 说明两个字符串相似度越差
    ///
    /// 算法思路: 假设有两个字符串 a:mitcmu, b:mtacnu, 如何得到他们的最小距离呢?
    ///
    ///    a:mitcmu
    ///    b:mtacnu
    ///
    /// 直觉看出, 把字符串a:i删除, 然后把b:a删除, 把b:n改成b:m, 这样两个字符串就一样了, 一共需要3次操作,距离3. 当然还有很多种修改方法,
    /// 比如在b:mt中间插入一个字符i, 在a:tc中间插入字符a, 删掉a:m, 删掉b:n, 这样两个字符串也一样了, 一共需要4次操作.
    /// 那么怎么求出这个最少的操作次数呢? 从第0个字符串开始, 每一次的操作性都是有限的
    /// 如果两个字符不同, 那么就有插入删除修改三种方法:
    /// 1. 对a[0]进行删除, 则下一步对比a[1], b[0]位置的字符, 同时距离+1
    /// 2. 在a[0]前面插入一个和b[0]相同的字符, 则下一步还是对比a[0], b[1], 同时距离+1
    /// 3. 对a[0]进行修改, 下一步对比a[1], b[1]位置的字符, 同时距离+1
    ///
    /// 上面是对a字符进行操作, 下面看看对b字符进行操作会有什么情况发生:
    /// 1. 对b[0]进行删除, 则下一步对比a[0], b[1], 距离+1
    /// 2. 在b[0]前面插入一个和a[0]相同的字符, 则下一步对比a[1], b[0], 距离+1
    /// 3. 对b[0]进行修改, 则下一步对比a[1], b[1], 距离+1
    ///
    /// 上面这6种情况都非常好理解, 其中部分操作下一步对比的下标是一样的, 一共只有3种不同, (0,1) (1,0) (1,1)
    /// 也就是说, (i,j)的状态只可能来自(i, j-1), (i-1, j), (i-1, j-1)这三个状态, 需要的是最小距离, 需要在这三个状态里选一个最小的转移
    ///
    /// 下面分析字符相同的情况, a[i]=a[j]则下一步对比的就是a[i+1], b[j+1], 仅此一种,距离不变
    ///
    /// 结合上面两种情况, 得到状态转移公式如下:
    ///
    /// 当a[i] 不等于 b[j]时:
    /// edist(i, j) = min( edist(i, j-1)+1, edist(i-1, j)+1, edist(i-1, j-1)+1 )
    ///
    ///
    /// 当a[i] 等于 b[j]时:
    /// edist(i, j) = min( edist(i, j-1)+1,, edist(i-1, j)+1, edist(i-1, j-1) )
    ///
    /// edist(i, j) 表示这个状态处理后需要编辑的次数. 如果a[i] != a[j], 那么还需要再处理1次, 所以就算上一个状态是从(i-1, j-1)过来的也要+1
    ///
    ///
    /// - Parameters:
    ///   - aStr: 字符串a
    ///   - bStr: 字符串b
    /// - Returns: 距离
    internal static func LevenshteinDistance(aStr: String, bStr: String) -> Int {
        
        // 使用状态表保存每一次状态, 下标是匹配的字符位置, 值代表距离
        var states = [[Int]](repeating: [Int](repeating: 0, count: bStr.count), count: aStr.count)
        
        // 对i=0的行, j=0的列两处边缘进行特殊处理.(因为边缘没有上一阶段, 或者上一阶段的状态有缺失)
        // 处理第0行
        for j in 0..<bStr.count {
            // 这里也不好理解... 举个例子, 字符串a:m, 字符串b:mtacnu, 得到的结果就是[0,1,2,3,4,5], 有一个相同, 最小距离5
            // 字符串a:q, 字符串b:mtacnu, 得到的结果就是[1,2,3,4,5,6], 完全没有相同的字符, 最小距离6
            // 字符串a:c, 字符串b:mtacnu, 得到的结果就是[1,2,3,3,4,5], 有一个相同, 最小距离5
            
        }
        
        // 处理第0列
        for i in 0..<aStr.count {
            
        }
        
        // 处理全部状态
        for i in 1..<aStr.count {
            for j in 1..<bStr.count {
                
            }
        }
        
        return 0
    }
}
