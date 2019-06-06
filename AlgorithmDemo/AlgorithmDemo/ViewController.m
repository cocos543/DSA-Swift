//
//  ViewController.m
//  AlgorithmDemo
//
//  Created by Cocos on 2019/5/22.
//  Copyright © 2019 Cocos. All rights reserved.
//

#import "ViewController.h"
#import <DSA/DSA-Swift.h>
#import <DSA/DSA.h>
#import "AlgorithmDemo-Swift.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%@", @(@"adfada".hash % 10000));
    NSLog(@"%@", @(@"afaa".hash % 10000));
    NSLog(@"%@", @(@"bfdaf".hash % 10000));
    NSLog(@"%@", @(@"ccccc".hash % 10000));
    NSLog(@"%@", @(NSUIntegerMax % 10000));
    
    AddressingHashMap *map = [[AddressingHashMap alloc] init];
    
    map[@"good"] = @"!@#";
    map[@"good"] = nil;
    map[@"good"] = @"../";
    id v = map[@"11"];
    v = nil;
    
    [map putWithKey:@"11" val:@(111)];
    NSLog(@"%d", [map remove:@"11"]);
    NSLog(@"%@", [map get:@"11"]);
    NSLog(@"%@", [map keys]);
    
    
    // OC调用第三方库Swift类, 其中Any类型映射到OC中为id, 所以只能保存对象类型了.
    SinglyLinkedNode *node1 = [[SinglyLinkedNode alloc] initWithVal:@(1)];
    SinglyLinkedNode *node2 = [[SinglyLinkedNode alloc] initWithVal:@(2)];
    SinglyLinkedNode *node3 = [[SinglyLinkedNode alloc] initWithVal:@(3)];
    SinglyLinkedList *link = [[SinglyLinkedList alloc] init];
    [link InsertNodeWithNode:node1];
    [link InsertNodeWithNode:node2];
    [link InsertNodeWithNode:node3];
    
    NSLog(@"%@", link);
    link = [[SinglyLinkedList alloc] initWithNode:[SinglyLinkedList ReverseListWithNode:[link GetFirstNode]]];
    NSLog(@"%@", link);
    
    DoubleLinkedNode *nodeAlone = [[DoubleLinkedNode alloc] initWithVal:@(1)];
    DoubleLinkedLists *dlink = [[DoubleLinkedLists alloc] init];
    [dlink InsertNodeHeadWithNode:nodeAlone];
    NSLog(@"\n%@", dlink);
    
    
    // OC调用第三方库OC类
    DSAOC *oc = [[DSAOC alloc] init];
    [oc helloWorld];
    
    // 混合调用本地Swift代码
    TestInheritance *ti = [[TestInheritance alloc] initWithVal:@(10086)];
    [ti openFunc];
    
    NSMutableArray *arr = [NSMutableArray arrayWithObjects:@"a",@"b",@"c",@"d", nil];
    NSInteger total = [self fullPermutation:arr start:0 end:3];
    NSLog(@"%ld", (long)total);
    
    
}


- (void)swap:(NSString **)a b:(NSString **)b {
    NSString *t = *b;
    *b = *a;
    *a = t;
}

- (void)swap:(NSMutableArray *)arr a:(NSInteger)a b:(NSInteger)b {
    NSString *t = arr[b];
    arr[b] = arr[a];
    arr[a] = t;
}

/**
 字符串全排列
 
 算法思路: 每次把一个元素固定到头部,接着递归剩余字符串, 回归时恢复元素位置, 确保数组数据不被修改

 @param array 字符串数组...每一个元素都是NSString
 @param start 当前字符串起始位置
 @param end 字符串结束位置
 @return 固定为1
 */
- (NSInteger)fullPermutation:(NSMutableArray<NSString *> *)array start:(NSInteger)start end:(NSInteger)end {
    if (start == end) {
        NSString *str = @"";
        for (NSString *val in array) {
            str = [NSString stringWithFormat:@"%@%@", str, val];
        }
        printf("%s\n", str.UTF8String);
        return 1;
    }
    
    NSInteger count = 0;
    for (NSInteger i = start; i <= end; i++) {
        // 交换位置
        [self swap:array a:start b:i];
        
        count += [self fullPermutation:array start:start+1 end:end];
        
        // 恢复位置
        [self swap:array a:start b:i];
    }
    
    return count;
}


@end
