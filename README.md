# 文档更新说明
* 最后更新 2019年06月27日
* 首次更新 2019年05月22日

# DSA
Data Structure &amp; Algorithm, 算法之美, Swift语言实现

安装方法

    下载代码, 打开 DSA.xcworkspace , 运行AlgorithmDemo target即可, 或者运行DSA_SwiftTests中的测试用例.
    其中DSA工程编译之后会生成 DSA.framework, 可独立使用.
    
说明

    1. 复杂度分析时, 由于编程语言的差异, 当兼容OC时, Swift无法使用inout关键字, 导致数组会产生copy, 和算法无关, 空间复杂度分析时忽略该因素
    2. 由于要兼容OC, 无法使用Swift的泛型编程, 因此库中传入的数据均为Any类型, OC对应类型为id
    3. 代码持续更新中, bug持续修复中...

# 实现必修的数据结构与算法

# 目录

    目录最后补上

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

操作时间复杂度O(1), 空间复杂度O(1)

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

## [查找](https://github.com/cocos543/DSA-Swift/blob/master/DSA/DSA/Core/Search)

### 二分查找

* [二分查找](https://github.com/cocos543/DSA-Swift/blob/master/DSA/DSA/Core/Search/Search.swift) ✓

时间复杂度O(logn), 空间复杂度O(1)
![image](https://github.com/cocos543/DSA-Swift/blob/master/DSA/DSA/Resource/Img/BinarySearch.jpg)

* [求解平方根](https://github.com/cocos543/DSA-Swift/blob/master/DSA/DSA/Core/Search/Search.swift) ✓

时间复杂度O(logn), 空间复杂度O(1)

### [四种二分查找的变形算法](https://github.com/cocos543/DSA-Swift/blob/master/DSA/DSA/Core/Search/Search.swift)

1. 查找第一个值等于给定值的元素 ✓

2. 查找最后一个值等于给定值的元素 ✓

3. 查找第一个大于等于给定值的元素 ✓

4. 查找最后一个小于等于给定值的元素 ✓

## [哈希表](https://github.com/cocos543/DSA-Swift/blob/master/DSA/DSA/Core/HashTable)

### 冲突解决方式

* [链表法](https://github.com/cocos543/DSA-Swift/blob/master/DSA/DSA/Core/HashTable/LinkedHashMap.swift) ✓

* [开放寻址法](https://github.com/cocos543/DSA-Swift/blob/master/DSA/DSA/Core/HashTable/AddressingHashMap.swift) ✓

特点:

1. 支持动态扩容策略
2. 性能稳定, 每次删除, 插入, 查询的时间复杂度都是O(1)
3. 合理使用内存空间, 不浪费

时间复杂度O(1),  空间复杂度O(n)
![image](https://github.com/cocos543/DSA-Swift/blob/master/DSA/DSA/Resource/Img/AddressingHashTable.jpg)

## [树](https://github.com/cocos543/DSA-Swift/blob/master/DSA/DSA/Core/Trees)

* [二叉树](https://github.com/cocos543/DSA-Swift/blob/master/DSA/DSA/Core/Trees/BinaryTree.swift) ✓

1. 动态生成满二叉树 ✓
2. 可视化打印满二叉树 ✓
3. 二叉树前中后序遍历(递归) ✓
4. 层序遍历 ✓
5. 检测二叉树深度 ✓

![image](https://github.com/cocos543/DSA-Swift/blob/master/DSA/DSA/Resource/Img/BinaryTreePrint.jpg)

* [二叉查找树](https://github.com/cocos543/DSA-Swift/blob/master/DSA/DSA/Core/Trees/BinarySearchTree.swift)

1. 查找, 插入, 删除 (假设元素不重复) ✓

时间复杂度O(logn), 空间复杂度O(1)

![image](https://github.com/cocos543/DSA-Swift/blob/master/DSA/DSA/Resource/Img/BinarySearchTree.jpg)

* [红黑树](https://github.com/cocos543/DSA-Swift/blob/master/DSA/DSA/Core/Trees)

* [堆](https://github.com/cocos543/DSA-Swift/blob/master/DSA/DSA/Core/Trees/Heap.swift) ✓

1. 插入数据 ✓

时间复杂度O(logn), 空间复杂度O(1)

2. 删除堆顶 ✓

时间复杂度O(logn), 空间复杂度O(1)

3. 堆排序 ✓

时间复杂度O(n*logn), 空间复杂度O(1)

![image](https://github.com/cocos543/DSA-Swift/blob/master/DSA/DSA/Resource/Img/HeapInsert.jpg)
![image](https://github.com/cocos543/DSA-Swift/blob/master/DSA/DSA/Resource/Img/HeapDeleteTop.jpg)
![image](https://github.com/cocos543/DSA-Swift/blob/master/DSA/DSA/Resource/Img/HeapSort.jpg)

* [Trie树](https://github.com/cocos543/DSA-Swift/blob/master/DSA/DSA/Core/Trees/TrieTree.swift) ✓

插入, 删除, 查找时间复杂度O(n),  空间复杂度根前缀重合度有关.
1. 子节点使用哈希表存储
2. 支持任意字符构建字典树
3. 支持字符串增删查找

![image](https://github.com/cocos543/DSA-Swift/blob/master/DSA/DSA/Resource/Img/TrieTree.jpg)

* [AC自动机算法(Aho–Corasick)](https://github.com/cocos543/DSA-Swift/blob/master/DSA/DSA/Core/Trees/ACTree.swift) ✓

实现多模式串匹配算法, 时间复杂度O(n), 空间复杂度O(1)
1. 基于trie树实现
2. 支持多模式串匹配, 可用于关键词过滤

## [图](https://github.com/cocos543/DSA-Swift/blob/master/DSA/DSA/Core/Graph)

### 存储结构

* [邻接表实现](https://github.com/cocos543/DSA-Swift/blob/master/DSA/DSA/Core/Graph/Graph.swift) ✓

![image](https://github.com/cocos543/DSA-Swift/blob/master/DSA/DSA/Resource/Img/Graph.jpg)

### 图的搜索

* [广度优先搜索BFS](https://github.com/cocos543/DSA-Swift/blob/master/DSA/DSA/Core/Graph/Graph.swift) ✓

* [深度优先搜索DFS](https://github.com/cocos543/DSA-Swift/blob/master/DSA/DSA/Core/Graph/Graph.swift) ✓


## [字符串](https://github.com/cocos543/DSA-Swift/blob/master/DSA/DSA/Core/String)

* [朴素匹配算法](https://github.com/cocos543/DSA-Swift/blob/master/DSA/DSA/Core/String/StringMatching.swift) ✓

* [Boyer-Moore匹配算法](https://github.com/cocos543/DSA-Swift/blob/master/DSA/DSA/Core/String/StringMatching.swift) ✓

时间复杂度: 性能是KMP算法的3-4倍, 最坏时间复杂度是O(n), 3n-5n;

复杂度推导: 实在太复杂, 能力有限, 有兴趣可以看附件推荐的论文; 下面给出代码实现中两个重要数组的示意图, 用于大幅提升算法性能.

![image](https://github.com/cocos543/DSA-Swift/blob/master/DSA/DSA/Resource/Img/BoyerMooreSuffix.jpg)
![image](https://github.com/cocos543/DSA-Swift/blob/master/DSA/DSA/Resource/Img/BoyerMooreIsPrefix.jpg)

* [KMP匹配算法](https://github.com/cocos543/DSA-Swift/blob/master/DSA/DSA/Core/String/StringMatching.swift) ✓

时间复杂度O(n+m), n是主串长度, m是模式串长度. KMP算法的核心预处理数组如下示意图

![image](https://github.com/cocos543/DSA-Swift/blob/master/DSA/DSA/Resource/Img/KMPNexts.jpg)

## [回溯算法](https://github.com/cocos543/DSA-Swift/blob/master/DSA/DSA/Core/Backtraking)

* [八皇后问题](https://github.com/cocos543/DSA-Swift/blob/master/DSA/DSA/Core/Backtracking/Backtracking.swift) ✓

* [背包问题](https://github.com/cocos543/DSA-Swift/blob/master/DSA/DSA/Core/Backtracking/Backtracking.swift) ✓

## [动态规划](https://github.com/cocos543/DSA-Swift/blob/master/DSA/DSA/Core/Dynamic)

* [01背包问题](https://github.com/cocos543/DSA-Swift/blob/master/DSA/DSA/Core/Dynamic/Dynamic.swift) ✓

# 附件

* [Boyer-Moore匹配算法图解](https://github.com/cocos543/DSA-Swift/blob/master/DSA/DSA/Resource/Data/BoyerMoore.pdf)
* [Boyer-Moore匹配算法复杂度证明1](https://dl.acm.org/citation.cfm?id=127830)
* [Boyer-Moore匹配算法复杂度证明2](https://dl.acm.org/citation.cfm?id=1382431.1382552)
