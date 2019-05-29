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
}



@end
