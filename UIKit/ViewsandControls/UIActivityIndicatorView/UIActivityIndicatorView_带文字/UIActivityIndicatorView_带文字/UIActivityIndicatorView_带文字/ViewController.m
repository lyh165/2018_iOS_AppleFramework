//
//  ViewController.m
//  UIActivityIndicatorView_带文字
//
//  Created by lee on 2018/9/27.
//  Copyright © 2018年 lee. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic,strong) NSTimer *timer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //提交时转菊花
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2 - 100, self.view.bounds.size.height/2 - 50, 200, 100)];
    self.activityIndicator.layer.cornerRadius = 15;
    //菊花样式
    self.activityIndicator.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    //开启菊花
    [self.activityIndicator startAnimating];
    //菊花下面文字
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(25, 65, 150, 40)];
    lable.text = @"正在结算中,请稍后...";
    lable.font = [UIFont systemFontOfSize:14];
    lable.textAlignment = NSTextAlignmentCenter;
    //lable.backgroundColor = [UIColor redColor];
    lable.textColor = [UIColor whiteColor];
    [self.activityIndicator addSubview:lable];
    [self.view addSubview:self.activityIndicator];

//    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerStop) userInfo:nil repeats:NO];
    
    self.timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerStop) userInfo:nil repeats:NO];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];

}


- (void)timerStop
{
    //停止菊花
    [self.activityIndicator stopAnimating];
    self.activityIndicator.hidesWhenStopped =YES;
    //返回上个界面
    [self.navigationController popViewControllerAnimated:YES];
}


@end
