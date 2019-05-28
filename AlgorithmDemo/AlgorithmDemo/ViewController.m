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
    SinglyLinkedNode *node = [[SinglyLinkedNode alloc] initWithVal:@(10)];
    NSLog(@"%@\n", node.value);
    
    
    
    // OC调用第三方库OC类
    DSAOC *oc = [[DSAOC alloc] init];
    [oc helloWorld];
    
    // 混合调用本地Swift代码
    TestInheritance *ti = [[TestInheritance alloc] initWithVal:@(10086)];
    [ti openFunc];
}



@end
