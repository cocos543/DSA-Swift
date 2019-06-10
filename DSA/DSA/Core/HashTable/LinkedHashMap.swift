//
//  ListsHashMap.swift
//  DSA
//
//  Created by Cocos on 2019/6/4.
//  Copyright © 2019 Cocos. All rights reserved.
//

import Foundation

let DEFAULT_INIT_SOLTS: Int = 5

private class Element: DoubleLinkedNode {
    fileprivate var key: String = ""
    
    init(key: String, val: Any) {
        super.init(val: val)
        self.key = key
    }
}

/// 一大堆桶, 简单封装了一些属性
private struct BucketList {
    
    /// 桶里的元素数量
    var count: Int = 0
    
    var solts: Int = 0
    
    var buckets: [Element?]?
    
    
    /// 传入false, 表示不需要初始化桶数组
    ///
    /// - Parameter b: 是否需要桶数据
    init(_ b: Bool) {
        if b {
            self.solts = DEFAULT_INIT_SOLTS
            buckets = [Element]()
            _fillBucket(&buckets!, DEFAULT_INIT_SOLTS)
        }
    }
    
    init(solts: Int) {
        self.solts = solts
        
        buckets = [Element]()
        _fillBucket(&buckets!, solts)
    }
    
    private func _fillBucket(_ b:inout [Element?], _ slots: Int) {
        for _ in 0 ..< slots {
            b.append(nil)
        }
    }
}


/// 基于链表法的散列表
///
/// 因为要兼容OC, 无法使用Swift泛型编程, 这里key只能先支持String类型;
///
/// 功能特点:
/// 1. 使用链表法解决冲突
/// 2. 支持动态扩容策略
/// 3. 性能稳定, 每次删除, 插入, 查询的时间复杂度都是O(1)
/// 4. 合理使用内存空间, 不浪费
open class LinkedHashMap: NSObject {
    
    /// 散列表元素数据量
    @objc public var count: Int {
        return _bucketList.count + _bucketListOld.count
    }
    
    /// 装载因子, 假设key都均匀分布在整个数组上, 这里拉链理想最大长度为10个, 则装载因子为 (10*n)/n=10
    /// n是散列表容量
    static private var _loadFactor: Double {
        return 10
    }
    
    /// 当前装载因子
    private var _currentLoadFactor: Double {
        return Double(_bucketList.count) / Double(_bucketList.solts)
    }
    
    /// 当前桶槽位个数
    private var _slots: Int {
        return _bucketList.solts
    }
    
    
    /// 每个槽都存放一条双向链表
    private var _bucketList: BucketList
    
    /// 存放扩容后的未搬移的数据
    private var _bucketListOld: BucketList
    
    /// 旧桶可搬移的数据位置
    private var _indexOld: Int = 0
    
    @objc public override init() {
        _bucketListOld = BucketList(false)
        _bucketList = BucketList(true)
        super.init()
    }
    
    @objc public init(cap: Int) {
        var solts = 0
        // 这里简单处理用户自定义容量了.
        if cap <= DEFAULT_INIT_CAP {
            solts = DEFAULT_INIT_SOLTS
        }else {
            // 总容量除以每条链理想最大数目,就是槽位数量
            solts = DEFAULT_INIT_SOLTS + cap / Int(LinkedHashMap._loadFactor)
        }
        
        _bucketList = BucketList(solts: solts)
        _bucketListOld = BucketList(false)
        super.init()
    }
    
    /// 计算hash数值
    ///
    /// 返回的结果可以直接作为桶下标使用
    ///
    /// - Parameter key: 目标key
    /// - Returns: Int
    private func _hash(_ key: String, _ cap: Int) -> Int {
        var hasher = Hasher()
        hasher.combine(key)
        let v = abs(hasher.finalize())
        return v % cap
    }
    
    private func _nextIndex(_ i: Int, _ cap: Int) -> Int {
        return (i + 1) % cap
    }
    
    /// 根据需要移动旧数据
    private func _moveOldData() {
        while _bucketListOld.buckets != nil {
            var skip = false
            // 一次移动一个槽的链表
            if _bucketListOld.buckets![_indexOld] != nil {
                var node = _bucketListOld.buckets![_indexOld]
                while node != nil {
                    _update(key: node!.key, val: node!.value)
                    node = node!.next as? Element
                    _bucketListOld.count -= 1
                }
                skip = true
            }
            
            // 整条链都搬移后, 把槽位设置为nil
            if skip {
                _bucketListOld.buckets![_indexOld] = nil
                
                if _bucketListOld.count == 0 {
                    _bucketListOld.buckets = nil
                    _bucketListOld.solts = 0
                    _indexOld = 0
                    break
                }
            }
            
            _indexOld = _nextIndex(_indexOld, _bucketListOld.solts)
            
            if skip {
                break
            }
        }
    }
    
    private func _remove(element: Element) {
        let index = _hash(element.key, _slots)
        
        // 如果要删除的元素是槽的第一个, 则直接把后一个节点放入槽中
        if _bucketList.buckets?[index] === element {
            _bucketList.buckets?[index] = element.next as? Element
            
            // 如果原本槽里不止一个节点, 则下一个节点的前驱节点设置为nil
            if _bucketList.buckets?[index] != nil {
                _bucketList.buckets?[index]!.perv = nil
            }
        } else {
            Element.DeleteNode(target: element)
        }
        
        _bucketList.count -= 1
    }
    
    private func _removeInOld(element: Element) {
        let index = _hash(element.key, _bucketListOld.solts)
        
        // 如果要删除的元素是槽的第一个, 则直接把后一个节点放入槽中
        if _bucketListOld.buckets?[index] === element {
            _bucketListOld.buckets?[index] = element.next as? Element
            
            // 如果原本槽里不止一个节点, 则下一个节点的前驱节点设置为nil
            if _bucketListOld.buckets?[index] != nil {
                _bucketListOld.buckets?[index]!.perv = nil
            }
        } else {
            Element.DeleteNode(target: element)
        }
        
        _bucketListOld.count -= 1
    }
    
    private func _findInOld(key: String) -> Element? {
        // 再从旧桶找
        guard _bucketListOld.buckets != nil else {
            return nil
        }
        
        let index = _hash(key, _bucketListOld.solts)
        var node = _bucketListOld.buckets?[index]
        while node != nil {
            if node!.key == key {
                return node
            }
            
            node = node!.next as? Element
        }
        return nil
    }
    
    /// 查找key的位置
    ///
    ///  返回值可用于取值, 删除, 插入等功能
    ///
    /// - Parameter key: 键值
    /// - Returns: 是否在旧桶, 位置(-1表示不存在)
    private func _find(key: String) -> (Bool, Element?) {
        // 先查找新桶
        let index = _hash(key, _slots)
        
        var node = _bucketList.buckets?[index]
        while node != nil {
            if node!.key == key {
                return (false, node)
            }
            node = node!.next as? Element
        }
        
        // 再查找旧桶
        let ele = _findInOld(key: key)
        if ele != nil {
            return (true, ele)
        }
        
        return (false, nil)
        
    }
    
    /// 更新桶数据, 支持动态扩容
    ///
    /// - Parameters:
    ///   - key: 键值
    ///   - val: 元素
    private func _update(key: String, val: Any) {
        
        // 动态扩容
        if _currentLoadFactor >= LinkedHashMap._loadFactor {
            
            _bucketListOld = _bucketList
            _bucketList =  BucketList(solts: _slots*2)

        }
        
        let index = _hash(key, _slots)

        let ele = Element(key: key, val: val)
        // 如果槽位已有节点,则直接插入
        if _bucketList.buckets![index] != nil {
            Element.InsertNodeAfter(target: _bucketList.buckets![index]!, node: ele)
        }else {
            // 槽位没有节点, 新创建
            _bucketList.buckets![index] = ele
        }
        _bucketList.count += 1
        
        
    }
}

extension LinkedHashMap: HashOperate {
    
    
    @objc public func put(key: String, val: Any?) {
        if let v = val {
            _moveOldData()
            
            // 先查找一下旧桶, 如果key存在于旧桶, 先把旧桶的删了..
            let ele = _findInOld(key: key)
            if ele != nil {
                _removeInOld(element: ele!)
            }
            
            _update(key: key, val: v)
        }else {
            _ = self.remove(key)
        }
    }
    
    @objc public func get(_ key: String) -> Any? {
        let (_, ele) = _find(key: key)
        
        return ele?.value
    }
    
    @objc public func remove(_ key: String) -> Bool {
        let (isOld, ele) = _find(key: key)
        
        guard let e = ele else {
            return false
        }
        
        if isOld == false {
            _remove(element: e)
        }else {
            _removeInOld(element: e)
        }
        
        return true
    }
    
    @objc public func keys() -> [String] {
        var keys = [String]()
        for var ele in _bucketList.buckets! {
            while ele != nil {
                keys.append(ele!.key)
                ele = ele!.next as? Element
            }
        }
        
        if _bucketListOld.buckets != nil {
            for var ele in _bucketListOld.buckets! {
                while ele != nil {
                    keys.append(ele!.key)
                    ele = ele!.next as? Element
                }
            }
        }
        
        return keys
    }
    
    @objc public subscript(key: String) -> Any? {
        get {
            return get(key)
        }
        
        set {
            put(key: key, val: newValue)
        }
    }
    
    
}
