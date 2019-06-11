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
        
    }

}
