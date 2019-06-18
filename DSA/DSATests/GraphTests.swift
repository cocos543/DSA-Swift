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
        
        g.AddEdge(from: v1, to: v2)
        
        g.AddEdge(from: v2, to: v3)
        g.AddEdge(from: v2, to: v5)
        g.AddEdge(from: v2, to: v4)
        
        g.AddEdge(from: v4, to: v1)
        g.AddEdge(from: v4, to: v2)
        
        g.AddEdge(from: v5, to: v4)
        g.AddEdge(from: v5, to: v3)
        
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
        
        g2.AddEdge(from: v1, to: v2, weight: 11)
        
        g2.AddEdge(from: v2, to: v3, weight: 12)
        g2.AddEdge(from: v2, to: v5, weight: 13)
        g2.AddEdge(from: v2, to: v4, weight: 14)
        
        g2.AddEdge(from: v4, to: v1, weight: 15)
        g2.AddEdge(from: v4, to: v2, weight: 16)
        
        g2.AddEdge(from: v5, to: v4, weight: 17)
        g2.AddEdge(from: v5, to: v3, weight: 18)
        
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
}
