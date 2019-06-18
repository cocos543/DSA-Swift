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

    /// 顶点编号
    @objc open private(set) var no: Int
    
    /// 权重
    @objc open fileprivate(set) var weight: Int = 0
    
    /// wfrom到self之间的边的权重
    @objc open fileprivate(set) weak var wfrom: Vertex!
    
    
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
                    
                    ret += "\(temp!.wfrom.value!)-->\(temp!.value!) weight:\(temp!.weight)"
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
    @objc open func AddEdge(from: Vertex, to: Vertex, weight: Int = 0) {
        let tv = Vertex(no: to.no, val: _vertexs[to.no].value!)
        if weight > 0 {
            tv.weight = weight
            tv.wfrom = from
        }
        
        // 和from相连的顶点to, 作为from的后置节点插入链表中
        _ = SinglyLinkedList(node: from).InsertNodeAfterAt(dest: from, node: tv)
        
        
        // 无向图, 额外添加一条反向的边
        if self.gType == GraphType.Undirected {
            let fv = Vertex(no: from.no, val: _vertexs[from.no].value!)
            if weight > 0 {
                fv.weight = weight
                fv.wfrom = to
            }
            
            // 和to相连的顶点from, 作为to的后置节点插入链表中
            _ = SinglyLinkedList(node: to).InsertNodeAfterAt(dest: to, node: fv)
        }
        
    }
}
