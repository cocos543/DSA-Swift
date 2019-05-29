//
//  DoubleLinkedListsTests.swift
//  DSATests
//
//  Created by Cocos on 2019/5/29.
//  Copyright © 2019 Cocos. All rights reserved.
//

import XCTest
@testable import DSA

class DoubleLinkedListsTests: XCTestCase {
    func testCreateDoubleLink() {
        let node = DoubleLinkedNode(val: 1)
        let link = DoubleLinkedLists(node: node)
        XCTAssertEqual("1-->nil\nhead<--1", "\(link)")
    }
    
    func testDoubleLinkedListsGetNode() {
        let node1 = DoubleLinkedNode(val: 1)
        let node2 = DoubleLinkedNode(val: 2)
        let node3 = DoubleLinkedNode(val: 3)
        
        let link = DoubleLinkedLists()
        link.InsertNode(node: node1)
        link.InsertNode(node: node2)
        link.InsertNode(node: node3)
        XCTAssertEqual(node1, link.GetNodeAtIndex(index: 0))
        XCTAssertEqual(node3, link.GetNodeAtIndex(index: 2))
    }
    
    func testDoubleLinkedListsInsertNode() {
        let node1 = DoubleLinkedNode(val: 1)
        let node2 = DoubleLinkedNode(val: 2)
        let node3 = DoubleLinkedNode(val: 3)
        
        let node4 = DoubleLinkedNode(val: 4)
        let node5 = DoubleLinkedNode(val: 5)
        let node6 = DoubleLinkedNode(val: 6)
        
        let link = DoubleLinkedLists()
        link.InsertNode(node: node1)
        link.InsertNode(node: node2)
        link.InsertNode(node: node3)
        XCTAssertEqual("1-->2-->3-->nil\nhead<--1<--2<--3", "\(link)")
        XCTAssertEqual(3, link.length)
        
        
        link.InsertNodeHead(node: node4)
        XCTAssertEqual("4-->1-->2-->3-->nil\nhead<--4<--1<--2<--3", "\(link)")
        XCTAssertEqual(4, link.length)
        
        // 链表没有数据节点时
        let nodeAlone = DoubleLinkedNode(val: 1)
        let linkAlone = DoubleLinkedLists()
        linkAlone.InsertNodeHead(node: nodeAlone)
        XCTAssertEqual("1-->nil\nhead<--1", "\(linkAlone)")
        
        
        _ = link.InsertNodeAfterAt(dest: node3, node: node5)
        XCTAssertEqual("4-->1-->2-->3-->5-->nil\nhead<--4<--1<--2<--3<--5", "\(link)")
        XCTAssertEqual(5, link.length)
        
        XCTAssertEqual(false, link.InsertNodeAfterAt(dest: nodeAlone, node: node6))
        
        _ = link.InsertNodeAfterAt(dest: node4, node: node6)
        XCTAssertEqual("4-->6-->1-->2-->3-->5-->nil\nhead<--4<--6<--1<--2<--3<--5", "\(link)")
        XCTAssertEqual(6, link.length)
        
        _ = link.InsertNodeAfterValueAt(dest: 2, node: DoubleLinkedNode(val: 10086)) {
            $0 as! Int == $1 as! Int
        }
        XCTAssertEqual("4-->6-->1-->2-->10086-->3-->5-->nil\nhead<--4<--6<--1<--2<--10086<--3<--5", "\(link)")
        XCTAssertEqual(7, link.length)
        
    }
    
    func testDoubleLinkedListsDeleteNode() {
        let node1 = DoubleLinkedNode(val: 1)
        let node2 = DoubleLinkedNode(val: 2)
        let node3 = DoubleLinkedNode(val: 3)
        let node4 = DoubleLinkedNode(val: 4)
        let node5 = DoubleLinkedNode(val: 5)
        
        let link = DoubleLinkedLists()
        link.InsertNode(node: node1)
        link.InsertNode(node: node2)
        link.InsertNode(node: node3)
        link.InsertNode(node: node4)
        link.InsertNode(node: node5)
        
        XCTAssertEqual(true, link.DeleteNode(node: node5))
        XCTAssertEqual("1-->2-->3-->4-->nil\nhead<--1<--2<--3<--4", "\(link)")
        XCTAssertEqual(4, link.length)
        
        XCTAssertEqual(false, link.DeleteNode(node: DoubleLinkedNode(val: 10)))
        
        XCTAssertEqual(true, link.DeleteNode(node: node3))
        XCTAssertEqual("1-->2-->4-->nil\nhead<--1<--2<--4", "\(link)")
        XCTAssertEqual(3, link.length)
        
        XCTAssertEqual(true, link.DeleteNode(node: node1))
        XCTAssertEqual("2-->4-->nil\nhead<--2<--4", "\(link)")
        XCTAssertEqual(2, link.length)
        
        link.DeleteNodeAtIndex(index: 1)
        XCTAssertEqual("2-->nil\nhead<--2", "\(link)")
        
        link.DeleteNodeAtIndex(index: 0)
        XCTAssertEqual("nil\nhead", "\(link)")
        
        
    }
}
