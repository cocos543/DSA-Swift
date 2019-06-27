//
//  Backtracking.swift
//  DSA
//
//  Created by Cocos on 2019/6/26.
//  Copyright © 2019 Cocos. All rights reserved.
//

import Foundation


/// 回溯算法
internal class Backtracking {
    
    /// 八皇后问题
    ///
    /// 利用回溯思想解决八皇后问题
    internal static func EightQueen() {
        var chessboard = [Int](repeating: 0, count: 8)
        
        Backtracking._queenSearch(row: 0, chessboard: &chessboard)
        
        Backtracking._printQueen(result: chessboard)
    }
    
    
    /// 依次将八个棋子放到1-8行, 从左到右开始放, 如果不符合条件, 则回溯到上一个岔口继续
    ///
    /// - Parameters:
    ///   - row: 当前要放的行
    ///   - chessboard: 棋盘
    private static func _queenSearch(row: Int, chessboard: inout [Int]) {
        // 如果要下的行在棋盘外, 说明所有棋子已经下完了, 结束递归
        if row == chessboard.count {
            Backtracking._printQueen(result: chessboard)
            return
        }
        
        var colum = 0
        while colum < chessboard.count {
            // 如果当前位置可以放下棋, 则继续下一个棋子
            if Backtracking._isOK(row: row, colum: colum, chessboard: &chessboard) {
                chessboard[row] = colum
                Backtracking._queenSearch(row: row+1, chessboard: &chessboard)
            }
            // 向右移动一列继续搜索
            colum += 1
        }
    }
    
    
    /// 确定棋子是否可以放下
    ///
    /// - Parameters:
    ///   - row: 行
    ///   - colum: 列
    ///   - chessboard: 棋盘
    /// - Returns: Bool
    private static func _isOK(row: Int, colum: Int, chessboard: inout [Int]) -> Bool {
        
        var leftDiagonal = colum - 1, rightDiagonal = colum + 1
        // 依次检查当前棋子上方的每一行是否有棋子, 以及上方左右对角线是否有棋子
        for i in stride(from: row-1, through: 0, by: -1) {
            
            // 上方有棋子
            if chessboard[i] == colum {
                return false
            }
            
            // 对角线有棋子
            if leftDiagonal >= 0 {
                if chessboard[i] == leftDiagonal {
                    return false
                }
            }
            if rightDiagonal < 8 {
                if chessboard[i] == rightDiagonal {
                    return false
                }
            }
            
            leftDiagonal -= 1
            rightDiagonal += 1
        }
        
        return true
    }
    
    
    /// 打印棋盘矩阵
    ///
    /// - Parameter result: 棋盘
    private static func _printQueen(result: [Int]) {
        var str = ""
        for i in 0..<result.count {
            for j in 0..<result.count {
                if result[i] == j {
                    str += "Q "
                }else {
                    str += "* "
                }
            }
            str += "\n"
        }
        
        print(str)
    }
}



// MARK: - 背包问题
extension Backtracking {
    
    
    /// 当前最接近答案的组合
    private static var _KnapsackMax: [Int] = [0]
    
    
    
    /// 背包问题
    ///
    /// 给出一些物品, 求如何放入物品使背包总重量最大. 这里利用回溯思想解决背包问题, 回溯思想并不是背包问题的最高效解决方法, 动态规划才是.
    ///
    /// - Parameters:
    ///   - items: 物品重量数组
    ///   - index: 当前要考察的物品
    ///   - putIn: 当前已经放入背包的物品下标数组
    ///   - cap: 背包总容量
    /// - Returns: 存入背包的重量数组
    internal static func Knapsack(items: [Int], index: Int, putIn: [Int], cap: Int) -> [Int] {
        Backtracking._knapsack(items: items, index: index, putIn: putIn, cap: cap)
        return Backtracking._KnapsackMax
    }
    
    /// 背包问题
    ///
    /// - Parameters:
    ///   - items: 物品重量数组
    ///   - index: 当前要考察的物品
    ///   - putIn: 当前已经放入背包的物品下标数组
    ///   - cap: 背包总容量
    internal static func _knapsack(items: [Int], index: Int, putIn: [Int], cap: Int) {
        // 当前物品总重量和背包容量相等, 或者是当前考察的物品已经是最后一个, 结束递归
        let total = putIn.reduce(0, +)
        
        // 如果只是找到一种满足条件的方案就结束的话, 这里可以增加一个标识, 当物品重量和背包容量相等时可以结束全部递归直接退出函数
        if  total == cap || index == items.count - 1 {
            if Backtracking._KnapsackMax.reduce(0, +) < total {
                Backtracking._KnapsackMax = putIn
            }
            return
        }
        
        //当前物品不放入背包, 也就是不改变putInt数组
        Backtracking._knapsack(items: items, index: index + 1, putIn: putIn, cap: cap)
        
        //当前物品放入背包, 如果总容量超过了就不要放了
        if total + items[index + 1] <= cap {
            var putIn = putIn
            putIn.append(items[index + 1])
            Backtracking._knapsack(items: items, index: index + 1, putIn: putIn, cap: cap)
        }
    }
}
