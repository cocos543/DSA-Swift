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



// MARK: - 求解问题
extension Dynamic {
    
    /// 求解类似杨辉三角的问题
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
