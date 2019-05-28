//
//  DoubleLinkedLists.swift
//  DSA
//
//  Created by Cocos on 2019/5/25.
//  Copyright © 2019 Cocos. All rights reserved.
//

import Foundation

/// 单链表节点
open class DoubleLinkedNode: NSObject {
    
    @objc open var value: Any!
    @objc open var perv: DoubleLinkedNode?
    @objc open var next: DoubleLinkedNode?
    
    @objc public override init() {
        self.value = nil
    }
    
    @objc public init(val: Any) {
        value = val
    }
}
