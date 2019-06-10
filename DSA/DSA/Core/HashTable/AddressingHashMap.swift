//
//  AddressingHashMap.swift
//  DSA
//
// 性能分析:
//  插入100万条数据:
//  Test Case '-[DSATests.AddressingHashMapTests testHashMapDynamicExtension]' measured [Time, seconds] average: 6.554
//
//  取值100万个数据:
//  Test Case '-[DSATests.AddressingHashMapTests testHashMapGet]' measured [Time, seconds] average: 2.209
//
//  单个随机值key插入和取出时间:
//  随机插入一个值: values: [0.000543, 0.000014, 0.000010, 0.000006, 0.000005, 0.000005, 0.000005, 0.000005, 0.000005, 0.000005]
//
//  随机取出一个值: values: [0.000295, 0.000016, 0.000011, 0.000008, 0.000011, 0.000007, 0.000007, 0.000017, 0.000009, 0.000005]
//
//
//  Created by Cocos on 2019/6/4.
//  Copyright © 2019 Cocos. All rights reserved.
//

import Foundation

/// 默认开辟16个位置, 这个数是从JAVA源码里学的
let DEFAULT_INIT_CAP: Int = 16


@objc public protocol HashOperate {
    
    @objc func put(key: String, val: Any?)
    
    @objc func get(_ key: String) -> Any?
    
    @objc func remove(_ key: String) -> Bool
    
    @objc func keys() -> [String]
    
    @objc subscript(key: String) -> Any?  { get set }
}

/// 用于存放进散列表的值
private struct Element {
    
    /// 用于表示是否已经删除
    ///
    /// 之所以需要这个标识, 是为了让取值函数正常工作. 因为如果有很多个不同key计算出的index都相同, 根据开放寻址法, 这些key都会被分配到index之后的空位,
    /// 此时假设有5个key(k1~k5)被安排在index和之后的4个位置, 其中如果index所在k2被删除, 在查找k3的时候, 检索到会k2位置时, 发现k2不存在, 则以为k2之后没有元素了, 导致k3没有被检查出来;
    /// 所以我们加了一个deleted标志, 这样检查到k2位置, 虽然k2元素被删了, 但是k2位置的deleted为true, 程序可以知道k2之后还有元素, 因此会继续向后检索, 就可以正确找到k3了.
    var deleted: Bool = false
    
    /// 用户存进的元素值
    var value: Any?
    
    /// 原始key
    var key: String?
    
    init() {}
    
    init(key: String, val: Any) {
        self.value = val
        self.key = key
    }
}


/// 一大堆桶, 简单封装了一些属性
private struct BucketList {
    
    /// 桶里的元素数量
    var count: Int = 0
    
    var cap: Int {
        return buckets?.count ?? 0
    }
    
    var buckets: [Element]?
    
    
    /// 传入false, 表示不需要初始化桶数组
    ///
    /// - Parameter b: 是否需要桶数据
    init(_ b: Bool) {
        if b {
            buckets = Array(repeating: Element(), count: DEFAULT_INIT_CAP)
        }
    }
    
    init(cap: Int) {
        buckets = Array(repeating: Element(), count: cap)
    }
}

/// 基于开放寻址法的散列表
///
/// 因为要兼容OC, 无法使用Swift泛型编程, 这里key只能先支持String类型;
///
/// 功能特点:
/// 1. 使用开放寻址法存储数据
/// 2. 支持动态扩容策略
/// 3. 性能稳定, 每次删除, 插入, 查询的时间复杂度都是O(1)
/// 4. 合理使用内存空间, 不浪费
open class AddressingHashMap: NSObject {
    
    
    /// 散列表数据量
    @objc public var count: Int {
        return _bucketList.count + _bucketListOld.count
    }
    
    /// 装载因子, 根据统计学的一系列知识得知的当装载因子大于0.75时, 适合启动扩容- -!;
    /// 装载因子的计算公式为 lf = m/n , n是散列表容量, m是已经存放的元素数量
    private var _loadFactor: Double {
        return 0.75
    }
    
    /// 当前装载因子
    private var _currentLoadFactor: Double {
        return Double(_bucketList.count) / Double(_cap)
    }
    
    /// 当前桶容量
    private var _cap: Int {
        return _bucketList.cap
    }
    
    /// 存放元素的数组, 将实现动态扩容策略
    private var _bucketList: BucketList
    
    /// 存放扩容后的未搬移的数据
    private var _bucketListOld: BucketList
    
    /// 旧桶可搬移的数据位置
    private var _indexOld: Int = 0

    
    @objc public override init() {
        _bucketList = BucketList(true)
        _bucketListOld = BucketList(false)
    }
    
    @objc public init(cap: Int) {
        guard cap > 0 else {
            fatalError("need: cap > 0")
        }
        
        _bucketList = BucketList(cap: cap)
        _bucketListOld = BucketList(false)
    }
    
    
    private func _nextIndex(_ i: Int, _ cap: Int) -> Int {
        return (i + 1) % cap
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
    
    /// 根据需要移动旧数据
    private func _moveOldData() {
        // 检查是否需要搬移旧桶数据
        // 直接判断是否为nil可以避免产生桶的copy
        while _bucketListOld.buckets != nil {
            var skip = false
            if let key  = _bucketListOld.buckets![_indexOld].key {
                _update(key: key, val: _bucketListOld.buckets![_indexOld].value!)
                _bucketListOld.buckets![_indexOld].key = nil
                _bucketListOld.buckets![_indexOld].value = nil
                _bucketListOld.buckets![_indexOld].deleted = true
                _bucketListOld.count -= 1
                
                // 旧桶没有数据了,直接删除掉.
                // 这里需要注意一个问题, 因为上面代码会调用_update(),所以_bucketListOld可能会被更新成更大的桶,从而导致_indexOld不会等于新的cap,
                // 而是继续向桶的新增部分移动, 导致丢失桶前部分数据.因此需要直接判断桶里的数据是否为0
                if _bucketListOld.count == 0 {
                    _bucketListOld.buckets = nil
                    _indexOld = 0
                    break
                }
                
                skip = true
            }
            
            // 如果这里直接使用_indexOld += 1, 则可能导致扩容时, 旧桶没有数据了而且被覆盖了. 但是_indexOld还指向后一个位置而不是0,会出现bug
            _indexOld = _nextIndex(_indexOld, _bucketListOld.cap)
            
            if skip {
                break
            }
        }
    }
    
    private func _remove(index: Int) {
        _bucketList.buckets![index].deleted = true
        _bucketList.buckets![index].value = nil
        _bucketList.buckets![index].key = nil
        _bucketList.count -= 1
    }
    
    private func _removeInOld(index: Int) {
        _bucketListOld.buckets![index].deleted = true
        _bucketListOld.buckets![index].value = nil
        _bucketListOld.buckets![index].key = nil
        _bucketListOld.count -= 1
        
        if _bucketListOld.count == 0 {
            _bucketListOld.buckets = nil
            _indexOld = 0
        }
    }
    
    /// 查找key在旧桶的位置
    ///
    ///  返回值可用于删除功能
    ///
    /// - Parameter key: 键值
    /// - Returns: 位置(-1表示不存在)
    private func _findInOld(key: String) -> Int {
        // 再从旧桶找
        guard _bucketListOld.buckets != nil else {
            return -1
        }
        
        var index = _hash(key, _bucketListOld.cap)
        
        
        var flag = 0
        while true {
            flag += 1
            if _bucketListOld.buckets![index].value != nil {
                if _bucketListOld.buckets![index].key == key {
                    return index
                }
            }else if _bucketListOld.buckets![index].deleted == false {
                return -1
            }
            
            
            if flag == _bucketListOld.cap {
                return -1
            }
            
            index = _nextIndex(index, _bucketListOld.cap)
        }
    }
    
    /// 查找key的位置
    ///
    ///  返回值可用于取值, 删除, 插入等功能
    ///
    /// - Parameter key: 键值
    /// - Returns: 是否在旧桶, 位置(-1表示不存在)
    private func _find(key: String) -> (Bool, Int) {
        
        // 当桶里的元素出现如下情况: 删除+现存=容量, find函数无法正常工作, 所以我们需要设计一个break标志
        var flag = 0
        // 先从新桶中查找
        var index = _hash(key, _cap)
        while true {
            if _bucketList.buckets![index].value != nil {
                if _bucketList.buckets![index].key == key {
                    return (false, index)
                }
            }else if _bucketList.buckets![index].deleted == false {
                break
            }
            
            flag += 1
            if flag == _bucketList.cap {
                break
            }
            
            index = _nextIndex(index, _cap)
        }
        
        // 再从旧桶找
        let oldIndex = _findInOld(key: key)
        if oldIndex == -1 {
            return (false, -1)
        }else {
            return (true, oldIndex)
        }
    }
    
    /// 更新桶数据, 支持动态扩容
    ///
    /// - Parameters:
    ///   - key: 键值
    ///   - val: 元素
    private func _update(key: String, val: Any) {
        
        if _currentLoadFactor >= _loadFactor {
            // 启动扩容操作
            // 注意, 扩容的时候如果旧桶里面的元素多于1个的话, 说明旧桶的数据还没有全部搬新桶, 这个时候把旧桶覆盖了会导致数据丢失, 就变成BUG了
            if _bucketListOld.count > 0 {
                print("May be a bug")
            }
            
            _bucketListOld = _bucketList
            _bucketList =  BucketList(cap: _cap*2)
            
            // 每次扩容之后顺便搬走一个数据, 避免旧数据没搬完就再次触发扩容导致数据丢失
            _moveOldData()
        }
        
        var index = _hash(key, _cap)
        
        while true {
            // 插入元素时, 元素不存在, 该槽位可用
            if _bucketList.buckets![index].value == nil {
                _bucketList.buckets![index].value = val
                _bucketList.buckets![index].key = key
                _bucketList.buckets![index].deleted = false
                _bucketList.count += 1
                break
            }else {
                index = _nextIndex(index, _cap)
            }
        }
    }
}


// MARK: - 散列表操作
extension AddressingHashMap: HashOperate {
    
    /// 插入一个新元素, 如果元素key已经存在则替换旧值
    ///
    /// - Parameters:
    ///   - key: key
    ///   - val: 元素
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
    
    
    /// 移除一个key对应的元素
    ///
    /// - Parameter key: key
    /// - Returns: 如果移除的元素存在, 则返回true, 否则返回false
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
    
    
    /// 获取key对应的元素
    ///
    /// - Parameter key: key
    /// - Returns: 元素不存在是返回nil, 存在则返回key对应存入的值
    @objc public func get(_ key: String) -> Any? {
        let (isOld, index) = _find(key: key)
        if index == -1 {
            return nil
        }
        
        if isOld == false {
            return _bucketList.buckets![index].value
        }else {
            return _bucketListOld.buckets![index].value
        }
    }
    
    
    /// 返回所有存在的key
    ///
    /// - Returns: key数组
    @objc public func keys() -> [String] {
        var keys = [String]()
        for e in _bucketList.buckets! {
            if let k = e.key {
                keys.append(k)
            }
        }
        if _bucketListOld.buckets != nil {
            for e in _bucketListOld.buckets! {
                if let k = e.key {
                    keys.append(k)
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
