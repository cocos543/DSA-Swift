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
    
    var solts: Int {
        return (buckets?.count ?? 0) * 10
    }
    
    var buckets: [DoubleLinkedLists?]?
    
    
    /// 传入false, 表示不需要初始化桶数组
    ///
    /// - Parameter b: 是否需要桶数据
    init(_ b: Bool) {
        if b {
            buckets = [DoubleLinkedLists]()
            _fillBucket(&buckets!, DEFAULT_INIT_SOLTS)
        }
    }
    
    init(solts: Int) {
        buckets = [DoubleLinkedLists]()
        _fillBucket(&buckets!, solts)
    }
    
    private func _fillBucket(_ b:inout [DoubleLinkedLists?], _ slots: Int) {
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
    
    /// 装载因子, 假设key都均匀分布在整个数组上, 这里拉链理想最大长度为10个, 则装载因子为 10*n /n=10
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
        if cap <= DEFAULT_INIT_CAP {
            solts = DEFAULT_INIT_CAP
        }else {
            // 总容量除以每条链理想最大数目,就是槽位数量
            solts = DEFAULT_INIT_CAP + cap / Int(LinkedHashMap._loadFactor)
        }
        
        // 这里简单处理用户自定义容量了.
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
        
    }
    
    private func _remove(index: Int) {
        
    }
    
    private func _removeInOld(index: Int) {
        
    }
    
    private func _findInOld(key: String) -> Int {
        return -1
    }
    
    /// 查找key的位置
    ///
    ///  返回值可用于取值, 删除, 插入等功能
    ///
    /// - Parameter key: 键值
    /// - Returns: 是否在旧桶, 位置(-1表示不存在)
    private func _find(key: String) -> (Bool, Int) {
        return (false, -1)
        
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
            
            // 每次扩容之后顺便搬走一个数据, 避免旧数据没搬完就再次触发扩容导致数据丢失
            _moveOldData()
        }
        
        let index = _hash(key, _slots)
        
        // 把元素插入到链头即可
        _bucketList.buckets![index]?.InsertNodeHead(node: Element(key: key, val: val))
        _bucketList.count += 1
        
        
    }
}

extension LinkedHashMap: HashOperate {
    
    
    @objc public func put(key: String, val: Any?) {
        if let v = val {
            _moveOldData()
            
            // 先查找一下旧桶, 如果key存在于旧桶, 先把旧桶的删了..
            let index = _findInOld(key: key)
            if index != -1 {
                _removeInOld(index: index)
            }
            
            _update(key: key, val: v)
        }else {
            _ = self.remove(key)
        }
    }
    
    @objc public func get(_ key: String) -> Any? {
        let (isOld, index) = _find(key: key)
        if index == -1 {
            return nil
        }
        
        return nil
    }
    
    @objc public func remove(_ key: String) -> Bool {
        let (isOld, index) = _find(key: key)
        
        if index == -1 {
            return false
        }
        
        if isOld == false {
            _remove(index: index)
        }else {
            _removeInOld(index: index)
        }
        return true
    }
    
    @objc public func keys() -> [String] {
        return []
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
