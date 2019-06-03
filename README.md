# DSA
Data Structure &amp; Algorithm, 算法之美, Swift语言实现

安装方法

    下载代码, 打开 DSA.xcworkspace , 运行AlgorithmDemo target即可, 或者运行DSA_SwiftTests中的测试用例.
    其中DSA工程编译之后会生成 DSA.framework, 可独立使用

# 实现必修的数据结构与算法

## [单向链表](https://github.com/cocos543/DSA-Swift/blob/master/DSA/DSA/Core/LinkedList/SinglyLinkedList.swift)

### 链表常见操作
* 反转单向链表 ✓

时间复杂度O(n), 空间复杂度O(1)

* 链表中环的检测 ✓

时间复杂度O(n), 空间复杂度O(1)

* 合并两个有序链表 ✓

时间复杂度O(n), 空间复杂度O(1)

* 删除链表倒数第N个节点 ✓

时间复杂度O(n), 空间复杂度O(1)

* 求链表的中间节点 ✓

时间复杂度O(n), 空间复杂度O(1)

## [双向链表](https://github.com/cocos543/DSA-Swift/blob/master/DSA/DSA/Core/LinkedList/DoubleLinkedLists.swift)

## [栈](https://github.com/cocos543/DSA-Swift/blob/master/DSA/DSA/Core/Stack)

### 栈存储结构
* [顺序栈](https://github.com/cocos543/DSA-Swift/blob/master/DSA/DSA/Core/Stack/Stack.swift) ✓

* [链式栈](https://github.com/cocos543/DSA-Swift/blob/master/DSA/DSA/Core/Stack/LinkedStack.swift) ✓

## [队列](https://github.com/cocos543/DSA-Swift/blob/master/DSA/DSA/Core/Queue)

* [顺序队列](https://github.com/cocos543/DSA-Swift/blob/master/DSA/DSA/Core/Queue/Queue.swift) ✓

## [排序](https://github.com/cocos543/DSA-Swift/blob/master/DSA/DSA/Core/Sort)

### 稳定的排序算法

* [冒泡排序](https://github.com/cocos543/DSA-Swift/blob/master/DSA/DSA/Core/Sort/Sort.swift) ✓
最好时间复杂度O(n), 最坏时间复杂度O(n^2), 平均时间复杂度O(n^2), 空间复杂度O(1)
![image](https://github.com/cocos543/DSA-Swift/blob/master/DSA/DSA/Resource/Img/BubbleSort.jpg)


* [直接插入排序](https://github.com/cocos543/DSA-Swift/blob/master/DSA/DSA/Core/Sort/Sort.swift) ✓

最好时间复杂度O(n), 最坏时间复杂度O(n^2), 平均时间复杂度O(n^2), 空间复杂度O(1)
![image](https://github.com/cocos543/DSA-Swift/blob/master/DSA/DSA/Resource/Img/StraightInsertionSort.jpg)

* [选择排序](https://github.com/cocos543/DSA-Swift/blob/master/DSA/DSA/Core/Sort/Sort.swift) ✓

最好时间复杂度O(n^2), 最坏时间复杂度O(n^2), 平均时间复杂度O(n^2), 空间复杂度O(1)
![image](https://github.com/cocos543/DSA-Swift/blob/master/DSA/DSA/Resource/Img/SelectionSort.jpg)

* [归并排序](https://github.com/cocos543/DSA-Swift/blob/master/DSA/DSA/Core/Sort/SortMerging.swift) ✓

最好时间复杂度O(nlogn), 最坏时间复杂度O(nlogn), 平均时间复杂度O(nlogn), 空间复杂度O(n)
![image](https://github.com/cocos543/DSA-Swift/blob/master/DSA/DSA/Resource/Img/MergingSort.jpg)

* [计数排序(特殊桶排序)](https://github.com/cocos543/DSA-Swift/blob/master/DSA/DSA/Core/Sort/Sort.swift) ✓

时间复杂度O(n), 空间复杂度O(n)

### 不稳定的排序算法

* [快速排序](https://github.com/cocos543/DSA-Swift/blob/master/DSA/DSA/Core/Sort/SortQuick.swift) ✓

最好时间复杂度O(nlogn), 最坏时间复杂度O(n^2), 平均时间复杂度O(nlogn), 空间复杂度O(1)
![image](https://github.com/cocos543/DSA-Swift/blob/master/DSA/DSA/Resource/Img/QuickSort.jpg)

* [快排思想查找第k大元素](https://github.com/cocos543/DSA-Swift/blob/master/DSA/DSA/Core/Sort/SortQuick.swift) ✓

时间复杂度O(n), 空间复杂度O(1)

分区函数算法示意图
![image](https://github.com/cocos543/DSA-Swift/blob/master/DSA/DSA/Resource/Img/QuickSortPartition.jpg)

### 二分查找

* [二分查找](https://github.com/cocos543/DSA-Swift/blob/master/DSA/DSA/Core/Search/Search.swift) ✓

时间复杂度O(logn), 空间复杂度O(1)
![image](https://github.com/cocos543/DSA-Swift/blob/master/DSA/DSA/Resource/Img/BinarySearch.jpg)
