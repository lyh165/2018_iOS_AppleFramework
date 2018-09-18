//
//  ViewController.m
//  UIButton
//
//  Created by lee on 2018/9/15.
//  Copyright © 2018年 lee. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+LYH_Block.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:button];
    button.frame = CGRectMake(90, 200, 200, 40);
    [button setTitle:@"处理事件" forState:UIControlStateNormal];
    [button cq_addEventHandler:^{
        NSLog(@"ccc");
    } forControlEvents:UIControlEventTouchUpInside];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
