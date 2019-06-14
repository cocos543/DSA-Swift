//
//  SinglyLinkedListTests.swift
//  DSATests
//
//  Created by Cocos on 2019/5/27.
//  Copyright © 2019 Cocos. All rights reserved.
//

import XCTest
@testable import DSA

class SinglyLinkedListTests: XCTestCase {
    
    func testSinglyLinkedNode() {
        // 创建节点
        let node = SinglyLinkedNode(val: 10)
        XCTAssertEqual(10, node.value as! Int)
        
        // 创建单链表
        var link = SinglyLinkedList()
        XCTAssertEqual("nil", "\(link)")
        XCTAssertEqual(0, link.length)
        
        link = SinglyLinkedList(node: node)
        XCTAssertEqual("10-->nil", "\(link)")
        XCTAssertEqual(1, link.length)
    }
    
    func testSinglyLinkNodeInsert() {
        let node1 = DSA.SinglyLinkedNode(val: 1)
        let node2 = SinglyLinkedNode(val: 2)
        let node3 = SinglyLinkedNode(val: 3)
        let node4 = SinglyLinkedNode(val: 4)
        let node5 = SinglyLinkedNode(val: 5)
        
        let node6 = SinglyLinkedNode(val: 6)
        let node7 = SinglyLinkedNode(val: 7)
        
        let node8 = SinglyLinkedNode(val: 8)
    
        
        let link = SinglyLinkedList(node: node1)
        link.InsertNode(node: node2)
        link.InsertNode(node: node4)
        link.InsertNodeHead(node: node3)
        
        XCTAssertEqual(true, link.InsertNodeAfterAt(dest: node4, node: node5))
        XCTAssertEqual(false, link.InsertNodeAfterAt(dest: node6, node: node7))
        XCTAssertEqual(true, link.InsertNodeAfterAt(dest: node3, node: node8))
        
        XCTAssertEqual(6, link.length)
        XCTAssertEqual("3-->8-->1-->2-->4-->5-->nil", "\(link)")
        
        let node9 = SinglyLinkedNode(val: 9)
        XCTAssertEqual(true, link.InsertNodeAfterValueAt(dest: 5, node: node9) {
            $0 as! Int == $1 as! Int
        })
    }
    
    func testSinglyLinkNodeGet() {
        let node1 = SinglyLinkedNode(val: 1)
        let node2 = SinglyLinkedNode(val: 2)
        let node3 = SinglyLinkedNode(val: 3)
        let node4 = SinglyLinkedNode(val: 4)
        let node5 = SinglyLinkedNode(val: 5)
        
        let link = SinglyLinkedList(node: node1)
        link.InsertNode(node: node2)
        link.InsertNode(node: node3)
        link.InsertNode(node: node4)
        link.InsertNode(node: node5)
        
        XCTAssertEqual(1, link.GetNodeAtIndex(index: 0).value as! Int)
        XCTAssertEqual(5, link.GetNodeAtIndex(index: 4).value as! Int)
    }
    
    func testSinglyLinkNodeDelete() {
        let node1 = SinglyLinkedNode(val: 1)
        let node2 = SinglyLinkedNode(val: 2)
        let node3 = SinglyLinkedNode(val: 3)
        let node4 = SinglyLinkedNode(val: 4)
        let node5 = SinglyLinkedNode(val: 5)
        
        let link = SinglyLinkedList(node: node1)
        link.InsertNode(node: node2)
        link.InsertNode(node: node3)
        link.InsertNode(node: node4)
        link.InsertNode(node: node5)
        
        XCTAssertEqual(true, link.DeleteNode(node: node5))
        XCTAssertEqual(4, link.length)
        XCTAssertEqual("1-->2-->3-->4-->nil", "\(link)")
        
        XCTAssertEqual(true, link.DeleteNode(node: node1))
        XCTAssertEqual(3, link.length)
        XCTAssertEqual("2-->3-->4-->nil", "\(link)")
        
        link.DeleteNodeAtIndex(index: 2)
        XCTAssertEqual("2-->3-->nil", "\(link)")
        
        link.DeleteNodeAtIndex(index: 0)
        XCTAssertEqual("3-->nil", "\(link)")
        
        
    }
    
    func testReverseList() {
        let node1 = SinglyLinkedNode(val: 1)
        let node2 = SinglyLinkedNode(val: 2)
        let node3 = SinglyLinkedNode(val: 3)
        let node4 = SinglyLinkedNode(val: 4)
        let node5 = SinglyLinkedNode(val: 5)
        
        var link = SinglyLinkedList(node: node1)
        var nodeNew = SinglyLinkedList.ReverseList(node: node1)
        XCTAssertEqual("1-->nil", "\(link)")
        
        link.InsertNode(node: node2)
        link.InsertNode(node: node3)
        link.InsertNode(node: node4)
        link.InsertNode(node: node5)
        
        nodeNew = SinglyLinkedList.ReverseList(node: node1)
        link = SinglyLinkedList(node: nodeNew)
        XCTAssertEqual("5-->4-->3-->2-->1-->nil", "\(link)")
    }
    
    func testGetMedianNode() {
        let node1 = SinglyLinkedNode(val: 1)
        let node2 = SinglyLinkedNode(val: 2)
        let node3 = SinglyLinkedNode(val: 3)
        let node4 = SinglyLinkedNode(val: 4)
        let node5 = SinglyLinkedNode(val: 5)
        
        let link = SinglyLinkedList(node: node1)
        XCTAssertEqual("1", "\(SinglyLinkedList.GetMedianNode(node: node1).value as! Int)")
        
        link.InsertNode(node: node2)
        XCTAssertEqual("1", "\(SinglyLinkedList.GetMedianNode(node: node1).value as! Int)")
        
        link.InsertNode(node: node3)
        XCTAssertEqual("2", "\(SinglyLinkedList.GetMedianNode(node: node1).value as! Int)")
        
        link.InsertNode(node: node4)
        XCTAssertEqual("2", "\(SinglyLinkedList.GetMedianNode(node: node1).value as! Int)")
        
        link.InsertNode(node: node5)
        XCTAssertEqual("3", "\(SinglyLinkedList.GetMedianNode(node: node1).value as! Int)")
    }
    
    func testIsPalindrome() {
        let node1 = SinglyLinkedNode(val: "a")
        let node2 = SinglyLinkedNode(val: "b")
        let node3 = SinglyLinkedNode(val: "c")
        
        let node4 = SinglyLinkedNode(val: "d")
        
        let node5 = SinglyLinkedNode(val: "c")
        let node6 = SinglyLinkedNode(val: "b")
        let node7 = SinglyLinkedNode(val: "a")
        
        let link = SinglyLinkedList(node: node1)
        // 链只有一个节点, 为回文串
        XCTAssertEqual(true, SinglyLinkedList.IsPalindrome(node: link.GetFirstNode()!))
        
        link.InsertNode(node: node2)
        link.InsertNode(node: node3)
        link.InsertNode(node: node4)
        link.InsertNode(node: node5)
        link.InsertNode(node: node6)
        XCTAssertEqual(false, SinglyLinkedList.IsPalindrome(node: link.GetFirstNode()!))
        
        link.InsertNode(node: node7)
        XCTAssertEqual(true, SinglyLinkedList.IsPalindrome(node: link.GetFirstNode()!))
    }
    
    func testIsLoopLinkedList() {
        let node1 = SinglyLinkedNode(val: 1)
        let node2 = SinglyLinkedNode(val: 2)
        let node3 = SinglyLinkedNode(val: 3)
        let node4 = SinglyLinkedNode(val: 4)
        let node5 = SinglyLinkedNode(val: 5)
        
        XCTAssertEqual(false, SinglyLinkedList.IsLoopLinkedList(node: node1))
        
        let link = SinglyLinkedList(node: node1)
        link.InsertNode(node: node2)
        link.InsertNode(node: node3)
        link.InsertNode(node: node4)
        link.InsertNode(node: node5)
        
        // 最后一个节点之后又指向了第一个节点, 形成环
        link.InsertNode(node: node1)
        XCTAssertEqual(true, SinglyLinkedList.IsLoopLinkedList(node: node1))
        
    }
    
    func testRemoveNthNodeFromEndOfList() {
        let node1 = SinglyLinkedNode(val: 1)
        
        // 只有一个节点时, 删除倒数第1个
        XCTAssertEqual(true, SinglyLinkedList.RemoveNthNodeFromEndOfList(node: node1, n: 1) == nil)
        
        let node2 = SinglyLinkedNode(val: 2)
        let node3 = SinglyLinkedNode(val: 3)
        let node4 = SinglyLinkedNode(val: 4)
        let node5 = SinglyLinkedNode(val: 5)
        
        var link = SinglyLinkedList(node: node1)
        link.InsertNode(node: node2)
        link.InsertNode(node: node3)
        link.InsertNode(node: node4)
        link.InsertNode(node: node5)
        
        _ = SinglyLinkedList.RemoveNthNodeFromEndOfList(node: link.GetFirstNode()!, n: 1)
        XCTAssertEqual("1-->2-->3-->4-->nil", "\(link)")
        
        link = SinglyLinkedList(node:SinglyLinkedList.RemoveNthNodeFromEndOfList(node: link.GetFirstNode()!, n: 4)!)
        XCTAssertEqual("2-->3-->4-->nil", "\(link)")
    }
    
    func testMergeTowOrderedList() {
        let node1 = SinglyLinkedNode(val: 1)
        let node2 = SinglyLinkedNode(val: 2)
        let node3 = SinglyLinkedNode(val: 3)
        let node4 = SinglyLinkedNode(val: 4)
        let node44 = SinglyLinkedNode(val: 4)
        let node5 = SinglyLinkedNode(val: 5)
        let node6 = SinglyLinkedNode(val: 6)
        let node66 = SinglyLinkedNode(val: 6)
        let node7 = SinglyLinkedNode(val: 7)
        let node8 = SinglyLinkedNode(val: 8)
        let node9 = SinglyLinkedNode(val: 9)
        let node10 = SinglyLinkedNode(val: 10)
        
        // 两条链都只有一个节点时
        var nodeNew = SinglyLinkedList.MergeTowOrderedList(nodeA: node1, nodeB: node2){
            ($0 as! Int) < ($1 as! Int)
        }
        
        var link = SinglyLinkedList(node: nodeNew)
        XCTAssertEqual("1-->2-->nil", "\(link)")
        
        // 还原node1, node2
        node1.next = nil
        node2.next = nil
        
        let linkA = SinglyLinkedList(node: node1)
        linkA.InsertNode(node: node3)
        linkA.InsertNode(node: node4)
        linkA.InsertNode(node: node6)
        linkA.InsertNode(node: node7)
        
        let linkB = SinglyLinkedList(node: node2)
        linkB.InsertNode(node: node44)
        linkB.InsertNode(node: node5)
        linkB.InsertNode(node: node66)
        linkB.InsertNode(node: node8)
        linkB.InsertNode(node: node9)
        linkB.InsertNode(node: node10)
        
        nodeNew = SinglyLinkedList.MergeTowOrderedList(nodeA: linkA.GetFirstNode()!, nodeB: linkB.GetFirstNode()!) {
            ($0 as! Int) < ($1 as! Int)
        }
        
        link = SinglyLinkedList(node: nodeNew)
        XCTAssertEqual("1-->2-->3-->4-->4-->5-->6-->6-->7-->8-->9-->10-->nil", "\(link)")
        
        
    }
    
}


