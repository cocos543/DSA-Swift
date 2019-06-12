//
//  BinaryTreeTests.swift
//  DSATests
//
//  Created by Cocos on 2019/6/11.
//  Copyright © 2019 Cocos. All rights reserved.
//

import XCTest
@testable import DSA

class BinaryTreeTests: XCTestCase {
    
    let cmp2 = { (a: Any, b: Any) -> CompareF2Result in
        if (a as! Int) == (b as! Int) {
            return CompareF2Result.equal
        }else if (a as! Int) > (b as! Int) {
            return CompareF2Result.greater
        }else {
            return CompareF2Result.less
        }
    }

    func testTreeCreate() {
        let root = BinaryTree.DefaultTree(num: 26)
        print("\(root)")
    }
    
    func testTreeTraversing() {
        let root = BinaryTree.DefaultTree(num: 7)
        var arr = BinaryTree.Preorder(root: root) as! [String]
        XCTAssertEqual("ABDECFG", arr.joined())
        
        arr = BinaryTree.Inorder(root: root) as! [String]
        XCTAssertEqual("DBEAFCG", arr.joined())
        
        arr = BinaryTree.Postorder(root: root) as! [String]
        XCTAssertEqual("DEBFGCA", arr.joined())
        
        
        
        let nodeA = BinaryTreeNode(val: "A")
        let nodeB = BinaryTreeNode(val: "B")
        let nodeC = BinaryTreeNode(val: "C")
        let nodeD = BinaryTreeNode(val: "D")
        let nodeE = BinaryTreeNode(val: "E")
        let nodeF = BinaryTreeNode(val: "F")
        let nodeG = BinaryTreeNode(val: "G")
        let nodeH = BinaryTreeNode(val: "H")
        
        nodeA.lNode = nodeB
        nodeA.rNode = nodeC
        nodeB.rNode = nodeD
        nodeC.lNode = nodeE
        nodeE.lNode = nodeF
        nodeE.rNode = nodeG
        nodeG.lNode = nodeH
        
        arr = BinaryTree.Preorder(root: nodeA) as! [String]
        
        XCTAssertEqual("ABDCEFGH", arr.joined())
        
        arr = BinaryTree.Inorder(root: nodeA) as! [String]
        XCTAssertEqual("BDAFEHGC", arr.joined())
        
        arr = BinaryTree.Postorder(root: nodeA) as! [String]
        XCTAssertEqual("DBFHGECA", arr.joined())
        
        arr = BinaryTree.SequenceTraversal(root: nodeA) as! [String]
        XCTAssertEqual("ABCDEFGH", arr.joined())
        
    }
    
    func testBinarySearchTree() {
        let node1 = BinaryTreeNode(val: 1)
        
        var targer = BinarySearchTree.Find(root: node1, val: 1) {
            if ($0 as! Int) == ($1 as! Int) {
                return CompareF2Result.equal
            }else if ($0 as! Int) > ($1 as! Int) {
                return CompareF2Result.greater
            }else {
                return CompareF2Result.less
            }
        }
        
        XCTAssertEqual(true, targer!.value as! Int == 1)
        
        var root = BinaryTreeNode(val: 5)
        BinarySearchTree.Insert(root: root, val: 2, cmp: cmp2)
        BinarySearchTree.Insert(root: root, val: 1, cmp: cmp2)
        BinarySearchTree.Insert(root: root, val: 4, cmp: cmp2)
        BinarySearchTree.Insert(root: root, val: 3, cmp: cmp2)
        BinarySearchTree.Insert(root: root, val: 8, cmp: cmp2)
        BinarySearchTree.Insert(root: root, val: 6, cmp: cmp2)
        BinarySearchTree.Insert(root: root, val: 7, cmp: cmp2)
        BinarySearchTree.Insert(root: root, val: 10, cmp: cmp2)
        BinarySearchTree.Insert(root: root, val: 9, cmp: cmp2)

        var arr = BinaryTree.SequenceTraversal(root: root).map {"\($0)"}
        XCTAssertEqual("5 2 8 1 4 6 10 3 7 9", arr.joined(separator: " "))
        
        targer = BinarySearchTree.Find(root: root, val: 7, cmp: self.cmp2)
        XCTAssertEqual(true, targer!.value as! Int == 7)
        
        // 删除叶子节点
        root = BinarySearchTree.Delete(root: root, val: 4, cmp: self.cmp2)!
        arr = BinaryTree.SequenceTraversal(root: root).map {"\($0)"}
        XCTAssertEqual("5 2 8 1 3 6 10 7 9", arr.joined(separator: " "))
        
        // 删除中间节点(节点有左右子树)
        root = BinarySearchTree.Delete(root: root, val: 8, cmp: self.cmp2)!
        arr = BinaryTree.SequenceTraversal(root: root).map {"\($0)"}
        XCTAssertEqual("5 2 9 1 3 6 10 7", arr.joined(separator: " "))
        
        
        // 删除根节点
        root = BinarySearchTree.Delete(root: root, val: 5, cmp: self.cmp2)!
        arr = BinaryTree.SequenceTraversal(root: root).map {"\($0)"}
        XCTAssertEqual("6 2 9 1 3 7 10", arr.joined(separator: " "))
        
        // 删除一个不存在的节点
        root = BinarySearchTree.Delete(root: root, val: 10086, cmp: self.cmp2)!
        arr = BinaryTree.SequenceTraversal(root: root).map {"\($0)"}
        XCTAssertEqual("6 2 9 1 3 7 10", arr.joined(separator: " "))
        
        // 删除只有一个节点的树
        XCTAssertEqual(true, BinarySearchTree.Delete(root: BinaryTreeNode(val: 1), val: 1, cmp: self.cmp2) == nil)

    }

}
