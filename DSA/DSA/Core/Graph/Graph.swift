//
//  Graph.swift
//  DSA
//
//  Created by Cocos on 2019/6/14.
//  Copyright © 2019 Cocos. All rights reserved.
//

import Foundation


@objc public enum GraphType: Int {
    
    /// 有向图
    case Directed = 1
    
    /// 无向图
    case Undirected = 4
    
    /// 带权图
    case Weighted = 8
}

/// Graph顶点
@objc open class Vertex: SinglyLinkedNode {

    /// 顶点编号, 用于表示两个顶点是否相同
    @objc open private(set) var no: Int
    
    /// 权重, 表示headNode-->self之间边的权重
    @objc open fileprivate(set) var weight: Int = 0
    
    
    /// 创建顶点
    ///
    /// - Parameters:
    ///   - no: 顶点编号, 对应顶点在数组中的下标
    ///   - val: 存储数据
    @objc public init(no: Int, val: Any) {
        self.no = no
        super.init(val: val)
    }
    
    // 每一个顶点都必须指定编号
    @objc required public init(val: Any) {
        fatalError("init(val:) has not been implemented")
    }
    
}


/// 图
///
/// 1-->2--> 表示顶点1有一条连接到顶点2的边
///
/// 2-->4-->5-->3--> 表示顶点2到顶点4,5,3都有边连着
///
///
/// 邻接表实现
open class Graph: NSObject {
    
    
    /// 图类型
    @objc open private(set) var gType = GraphType.Directed
    
    /// Graph节点个数
    @objc open var count: Int {
        return _vertexs.count
    }
    
    @objc public var vertexList: [Vertex] {
        return _vertexs
    }
    
    
    /// 存放节点
    private var _vertexs: [Vertex]
    
    @objc public override init() {
        _vertexs = Array()
    }
    
    @objc public init(gType: GraphType) {
        _vertexs = Array()
        self.gType = gType
    }
    
    open override var description: String {
        var ret = ""
        for v in _vertexs {
            var temp: SinglyLinkedNodeProtocol? = v
            while temp != nil {
                ret += "\(temp!.value!)-->"
                temp = temp!.next
            }
            ret += "\n"
        }
        
        // 打印出边的权重
        if self.gType == GraphType.Weighted {
            ret += "\n"
            for v in _vertexs {
                var temp: Vertex? = v.next as? Vertex
                while temp != nil {
                    // 直接从后置节点开始查找权重
                    
                    ret += "\(v.value!)-->\(temp!.value!) weight:\(temp!.weight)"
                    ret += "\n"
                    
                    temp = temp!.next as? Vertex
                }
                
            }
        }
        
        return ret
    }

}


// MARK: - Graph 基本API
extension Graph {
    
    /// 向Graph中创建出顶点
    ///
    /// 创建的顶点将自动加入图中
    /// - Returns: 创建的顶点
    @objc open func CreateVertex(val: Any) -> Vertex {
        let v = Vertex(no: _vertexs.count, val: val)
        _vertexs.append(v)
        return v
    }
    
    
    /// 添加边
    ///
    /// 对于有向图, 只会添加fromt ---> to单方向的边;
    ///
    /// 对于带权图, 会在节点的weight,wfrom设置权重信息
    ///
    /// - Parameters:
    ///   - from: 起始节点
    ///   - to: 终止节点
    ///   - weight: 权重, 默认值0
    @objc open func CreateEdge(from: Vertex, to: Vertex, weight: Int = 0) {
        let tv = Vertex(no: to.no, val: _vertexs[to.no].value!)
        if weight > 0 {
            tv.weight = weight
        }
        
        // 和from相连的顶点to, 作为from的后置节点插入链表中
        _ = SinglyLinkedList(node: from).InsertNodeAfterAt(dest: from, node: tv)
        
        
        // 无向图, 额外添加一条反向的边
        if self.gType == GraphType.Undirected {
            let fv = Vertex(no: from.no, val: _vertexs[from.no].value!)
            if weight > 0 {
                fv.weight = weight
            }
            
            // 和to相连的顶点from, 作为to的后置节点插入链表中
            _ = SinglyLinkedList(node: to).InsertNodeAfterAt(dest: to, node: fv)
        }
        
    }
    
}


// MARK: - 搜索
extension Graph {
    
    /// 将路径从深度搜索算法中的prevPath数组中解析出来
    ///
    ///  算法思路:
    ///
    ///  递归解析路径
    ///
    /// - Parameters:
    ///   - arr: prevPath数组
    ///   - no: 要查找终点
    /// - Returns: 解析后的结果
    private func _dumpBFSPaths(arr: [Int], no: Int) -> [Vertex] {
        if arr[no] == -1 {
            return [_vertexs[no]]
        }
        
        var paths = _dumpBFSPaths(arr: arr, no: arr[no])
        paths.append(_vertexs[no])
        return paths
    }
    
    
    /// 查询顶点是否在图中
    ///
    /// - Parameter v: 顶点
    /// - Returns: 在图中返回true
    @objc public func VertexExist(v: Vertex) -> Bool {
        for ele in _vertexs {
            if ele === v {
                return true
            }
        }
        return false
    }
    
    /// 广度优先搜索算法
    ///
    /// 算法思路:
    ///
    /// 1. 遇到顶点y, 先将顶点编号放入prev数组中, prevPath[y]=x, 表示顶点y是从顶点x遍历过来的. (起点f, prevPath[f]=-1表示没有从任何顶点过来)
    /// 2. 将遇到的顶点放到队列里, 并标记为visited, 直到当前层次没有新顶点
    /// 3. 从队列逐个取出顶点y, 获取和y相连的顶点, 如果新顶点状态不是visited的, 重复步骤1;自动忽略状态为visited的顶点
    ///
    /// - Parameters:
    ///   - from: 起点
    ///   - to: 终点
    /// - Returns: 从from到to所经顶点
    @objc public func BFS(from: Vertex, to: Vertex) -> [Vertex] {
        guard VertexExist(v: from) && VertexExist(v: to) else {
            return []
        }
        
        // 处理只有一个顶点的情况
        if from.no == to.no {
            return [from]
        }
        
        // 用于存放已经被访问, 但是相连的节点未被访问的顶点
        let q = Queue(cap: self.count)
        _ = q.EnQueue(ele: from)
        
        // 用于标记顶点是否被访问过
        var visited = [Bool](repeating: false, count: self.count)
        // 前驱访问路径, 用于记录节点是从哪儿访问过来的. prevPath[1] = 5 表示顶点1从顶点5访问过来的
        var prevPath = [Int](repeating: -1, count: self.count)
        
        
        visited[from.no] = true
        var finded = false
        while let headNode = q.DeQueue() as? Vertex, finded == false {
            var v: Vertex? = headNode
            while true {
                // 找到v相连的所有顶点
                if v!.next != nil {
                    let nextNo = (v!.next! as! Vertex).no
                    
                    // 对于没有被访问过的顶点,根据顶点编号从顶点数组中取出真实的顶点放入队列中
                    if !visited[nextNo] {
                        visited[nextNo] = true
                        prevPath[nextNo] = headNode.no
                        _ = q.EnQueue(ele: _vertexs[nextNo])
                        
                        // 找到目标了
                        if nextNo == to.no {
                            finded = true
                            break
                        }
                    }
                }else {
                    break
                }
                v = (v!.next as? Vertex)
            }
        }
        
        if !finded {
            return []
        }else {
            return _dumpBFSPaths(arr: prevPath, no: to.no)
        }
    }
    
    
    /// 深度优先搜索算法
    ///
    /// 算法思路:
    ///
    /// 使用递归访问未被访问的节点, 递归结束条件是:
    /// 1. 找到目标, 返回目标编号
    /// 2. 顶点的边都访问完了还是找不到目标, 返回nil
    ///
    /// - Parameters:
    ///   - from: 起点
    ///   - to: 终点
    /// - Returns: 从from到to所经顶点
    @objc public func DFS(from: Vertex, to: Vertex) -> [Vertex] {
        var visited = [Bool](repeating: false, count: self.count)
        
        let arrNo = _dfs(from: from, to: to, visited: &visited)
        if arrNo == nil {
            return []
        }
        
        var ret = [Vertex]()
        for no in arrNo! {
            ret.append(_vertexs[no])
        }
        return ret
    }
    
    
    private func _dfs(from: Vertex, to: Vertex, visited: inout [Bool]) -> [Int]? {
        if from.no == to.no {
            return [from.no]
        }else if from.next == nil {
            return nil
        }
        
        var v: Vertex? = from
        while true {
            if let next = v!.next as? Vertex {
                if visited[next.no] == false {
                    visited[next.no] = true
                    // 递归查找下一个顶点, 这里要传入真实顶点, 而不是链表里的顶点
                    let arr = _dfs(from: _vertexs[next.no], to: to, visited: &visited)
                    if arr != nil {
                        return [from.no] + arr!
                    }
                }
            }else {
                return nil
            }
            
            v = (v!.next as? Vertex)
        }
    }
}
