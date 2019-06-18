//
//  GraphTests.swift
//  DSATests
//
//  Created by Cocos on 2019/6/17.
//  Copyright © 2019 Cocos. All rights reserved.
//

import XCTest
@testable import DSA

class GraphTests: XCTestCase {
    func testCreate() {
        let g = Graph()
        var v1 = g.CreateVertex(val: 1)
        var v2 = g.CreateVertex(val: 2)
        var v3 = g.CreateVertex(val: 3)
        var v4 = g.CreateVertex(val: 4)
        var v5 = g.CreateVertex(val: 5)
        
        g.CreateEdge(from: v1, to: v2)
        
        g.CreateEdge(from: v2, to: v3)
        g.CreateEdge(from: v2, to: v5)
        g.CreateEdge(from: v2, to: v4)
        
        g.CreateEdge(from: v4, to: v1)
        g.CreateEdge(from: v4, to: v2)
        
        g.CreateEdge(from: v5, to: v4)
        g.CreateEdge(from: v5, to: v3)
        
        XCTAssertEqual("""
1-->2-->
2-->4-->5-->3-->
3-->
4-->2-->1-->
5-->3-->4-->

""", "\(g)")
        
        let g2 = Graph(gType: .Weighted)
        v1 = g2.CreateVertex(val: 1)
        v2 = g2.CreateVertex(val: 2)
        v3 = g2.CreateVertex(val: 3)
        v4 = g2.CreateVertex(val: 4)
        v5 = g2.CreateVertex(val: 5)
        
        g2.CreateEdge(from: v1, to: v2, weight: 11)
        
        g2.CreateEdge(from: v2, to: v3, weight: 12)
        g2.CreateEdge(from: v2, to: v5, weight: 13)
        g2.CreateEdge(from: v2, to: v4, weight: 14)
        
        g2.CreateEdge(from: v4, to: v1, weight: 15)
        g2.CreateEdge(from: v4, to: v2, weight: 16)
        
        g2.CreateEdge(from: v5, to: v4, weight: 17)
        g2.CreateEdge(from: v5, to: v3, weight: 18)
        
        XCTAssertEqual("""
1-->2-->
2-->4-->5-->3-->
3-->
4-->2-->1-->
5-->3-->4-->

1-->2 weight:11
2-->4 weight:14
2-->5 weight:13
2-->3 weight:12
4-->2 weight:16
4-->1 weight:15
5-->3 weight:18
5-->4 weight:17

""", "\(g2)")
        
        
    }
    
    func testBFS() {
        let g = Graph(gType: .Undirected)
        
        let v0 = g.CreateVertex(val: 0)
        let v1 = g.CreateVertex(val: 1)
        let v2 = g.CreateVertex(val: 2)
        let v3 = g.CreateVertex(val: 3)
        let v4 = g.CreateVertex(val: 4)
        let v5 = g.CreateVertex(val: 5)
        let v6 = g.CreateVertex(val: 6)
        let v7 = g.CreateVertex(val: 7)
        
        // 下面的代码会构成的图如下:
        /*
         0 - 1 - 2
         |   |   |
         3 - 4   5
             |   |
             6 - 7
         
         */
        
        g.CreateEdge(from: v0, to: v1)
        g.CreateEdge(from: v0, to: v3)
        
        g.CreateEdge(from: v1, to: v2)
        g.CreateEdge(from: v1, to: v4)
        
        g.CreateEdge(from: v2, to: v5)
        
        g.CreateEdge(from: v3, to: v4)
        
        //g.CreateEdge(from: v4, to: v5)
        g.CreateEdge(from: v4, to: v6)
        
        g.CreateEdge(from: v5, to: v7)
        
        g.CreateEdge(from: v6, to: v7)
        
        
        XCTAssertEqual(true, g.VertexExist(v: v5))
        XCTAssertEqual(false, g.VertexExist(v: Vertex(no: 1, val: 0)))
        
        let list = g.BFS(from: v0, to: v7)
        var ret = ""
        for ele in list {
            ret += "\(ele.value!)->"
        }
        XCTAssertEqual("0->3->4->6->7->", "\(ret)")
        
        // 只有一个顶点时
        let g2 = Graph(gType: .Undirected)
        let v11 = g2.CreateVertex(val: 11)
        
        let list2 = g2.BFS(from: v11, to: v11)
        var ret2 = ""
        for ele in list2 {
            ret2 += "\(ele.value!)->"
        }
        XCTAssertEqual("11->", "\(ret2)")
        
    }
    
    func testDFS() {
        let g = Graph(gType: .Undirected)
        
        let v0 = g.CreateVertex(val: 0)
        let v1 = g.CreateVertex(val: 1)
        let v2 = g.CreateVertex(val: 2)
        let v3 = g.CreateVertex(val: 3)
        let v4 = g.CreateVertex(val: 4)
        let v5 = g.CreateVertex(val: 5)
        let v6 = g.CreateVertex(val: 6)
        let v7 = g.CreateVertex(val: 7)
        
        // 下面的代码会构成的图如下:
        /*
         0 - 1 - 2
         |   |   |
         3 - 4   5
             |   
             6 - 7
         */
        
        g.CreateEdge(from: v0, to: v1)
        g.CreateEdge(from: v0, to: v3)
        
        g.CreateEdge(from: v1, to: v2)
        g.CreateEdge(from: v1, to: v4)
        
        g.CreateEdge(from: v2, to: v5)
        
        g.CreateEdge(from: v3, to: v4)
        
        //g.CreateEdge(from: v4, to: v5)
        g.CreateEdge(from: v4, to: v6)
        
        //g.CreateEdge(from: v5, to: v7)
        
        g.CreateEdge(from: v6, to: v7)
        
        
        XCTAssertEqual(true, g.VertexExist(v: v5))
        XCTAssertEqual(false, g.VertexExist(v: Vertex(no: 1, val: 0)))
        
        //print(g)
        let list = g.DFS(from: v0, to: v5)
        var ret = ""
        for ele in list {
            ret += "\(ele.value!)->"
        }
        XCTAssertEqual("0->3->4->1->2->5->", "\(ret)")
        
        // 只有一个顶点时
        let g2 = Graph(gType: .Undirected)
        let v11 = g2.CreateVertex(val: 11)
        
        let list2 = g2.DFS(from: v11, to: v11)
        var ret2 = ""
        for ele in list2 {
            ret2 += "\(ele.value!)->"
        }
        XCTAssertEqual("11->", "\(ret2)")
    }
}
