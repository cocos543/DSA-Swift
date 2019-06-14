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
    public var no: Int
    
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
/// 邻接表实现
open class Graph: NSObject {
    
    
    /// Graph节点个数
    @objc open var count: Int {
        return _vertexs.count
    }
    
    
    /// 存放节点
    private var _vertexs: [Vertex]
    
    @objc public override init() {
        _vertexs = Array()
    }

}


// MARK: - Graph 基本API
extension Graph {
    
    /// 向Graph中创建出顶点
    ///
    /// 创建的顶点将自动加入图中
    /// - Returns: 新创建顶点
    @objc open func CreateVertex(val: Any) -> Vertex {
        let v = Vertex(no: _vertexs.count, val: val)
        _vertexs.append(v)
        return v
    }
    
    
    /// 添加边
    ///
    /// 对于有向图, 只会添加fromt ---> to单方向的边
    ///
    /// - Parameters:
    ///   - from: 起始节点
    ///   - to: 终止节点
    ///   - weight: 权重, 默认值0
    @objc open func AddEdge(from: Vertex, to: Vertex, weight: Int = 0) {
        
    }
}
