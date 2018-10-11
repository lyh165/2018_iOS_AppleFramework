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
    
    [self function2];
    
}


/**
 按钮点击切换图片(默认和选择状态)
 */
- (void)function2
{
    self.view.backgroundColor = [UIColor blackColor];
    UIButton *barrageButton = [[UIButton alloc]init];
    [self.view addSubview:barrageButton];
    barrageButton.frame = CGRectMake(90, 200, 80, 80);
    [barrageButton setImage:[UIImage imageNamed:@"CLBarrageOpenBtn"] forState:UIControlStateNormal];
    [barrageButton setImage:[UIImage imageNamed:@"CLBarrageCloseBtn"] forState:UIControlStateSelected];
    [barrageButton addTarget:self action:@selector(barrageButtonAction:) forControlEvents:UIControlEventTouchUpInside];

}
- (void)barrageButtonAction:(UIButton *)button{
    button.selected = !button.selected;
    // 代理回调
//    if (_delegate && [_delegate respondsToSelector:@selector(cl_barrageButtonAction:)]) {
//        [_delegate cl_barrageButtonAction:button];
//    }else{
//        NSLog(@"没有实现代理或者没有设置代理人");
//    }
}
/**
 1、按钮block处理
 */
- (void)function1
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:button];
    button.frame = CGRectMake(90, 200, 200, 40);
    [button setTitle:@"处理事件" forState:UIControlStateNormal];
    [button cq_addEventHandler:^{
        NSLog(@"ccc");
    } forControlEvents:UIControlEventTouchUpInside];
}


@end
