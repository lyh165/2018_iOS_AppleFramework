//
//  ViewController.m
//  UIDevice
//
//  Created by lee on 2018/9/14.
//  Copyright © 2018年 lee. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.allowRotation = YES;//(以上2行代码,可以理解为打开横屏开关)
    [self setNewOrientation:YES];//调用转屏代码
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark 1、强制横屏
//-(NSUInteger)supportedInterfaceOrientations{
//    return UIInterfaceOrientationMaskLandscape;
//}

#pragma mark 2、通过appdelegate设置横屏
/**
 返回设置竖屏
 */
- (void)back
{
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.allowRotation = NO;//关闭横屏仅允许竖屏
    [self setNewOrientation:NO];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setNewOrientation:(BOOL)fullscreen
{
    if (fullscreen) {
        NSNumber *resetOrientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
        [[UIDevice currentDevice] setValue:resetOrientationTarget forKey:@"orientation"];
        NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeLeft];
        [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
        
    }else{
        
        NSNumber *resetOrientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
        [[UIDevice currentDevice] setValue:resetOrientationTarget forKey:@"orientation"];
        NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
        [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
        
    }
    
}



@end
