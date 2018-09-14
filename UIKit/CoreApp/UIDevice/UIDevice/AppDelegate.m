//
//  AppDelegate.m
//  UIDevice
//
//  Created by lee on 2018/9/14.
//  Copyright © 2018年 lee. All rights reserved.
//

#import "AppDelegate.h"
#import <UIKit/UIDevice.h>

/**去除NSLog时间戳及其他输出信息
 如果不想看见NSLog的时间戳以及其他输出信息，我们可以在前面自行添加宏定义
 */
#define NSLog(FORMAT, ...) printf("%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String])
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    [self device];
   
    
//    [self instance];
    return YES;
}

/**
 官方文档
 https://developer.apple.com/documentation/uikit/uidevice?language=objc
 */
- (void)device
{
/**
Device 设备
Orientation 取向

---------------------
 
1、获取共享设备实例
     currentDevice 返回表示当前设备的对象。
     
2、确定可用功能
     multitaskingSupported 一个布尔值，指示当前设备是否支持多任务处理。
     
3、识别设备和操作系统
     name 标识设备的名称。
     systemName 在接收器表示的设备上运行的操作系统的名称。
     systemVersion 当前版本的操作系统。
     model 设备的型号。
     localizedModel 设备的模型作为本地化字符串。
     userInterfaceIdiom 在当前设备上使用的接口样式。
     identifierForVendor 一个字母数字字符串，用于唯一标识应用程序供应商的设备。
     
4、跟踪设备方向
     orientation 返回设备的物理方向。
     UIDeviceOrientation 设备的物理方向。
     generatesDeviceOrientationNotifications 一个布尔值，指示接收器是否生成方向通知（YES）或不生成（NO）。
     - beginGeneratingDeviceOrientationNotifications 开始生成设备方向更改的通知。
     - endGeneratingDeviceOrientationNotifications 结束设备方向更改通知的生成。
     
5、确定当前的方向
     UIDeviceOrientationIsPortrait 返回一个布尔值，指示设备是否处于纵向方向。
     UIDeviceOrientationIsLandscape 返回一个布尔值，指示设备是否处于横向方向。
     UIDeviceOrientationIsFlat 返回一个布尔值，指示指定的方向是面朝上还是面朝下。
     UIDeviceOrientationIsValidInterfaceOrientation 返回一个布尔值，指示指定的方向是纵向还是横向方向之一。
*/
    
#pragma 1、获取共享设备实例
    UIDevice *device = [UIDevice currentDevice]; NSLog(@"device %@\n",device);

#pragma 2、确定可用功能
    BOOL multitaskingSupported = device.multitaskingSupported; NSLog(@"multitaskingSupported is %d\n",multitaskingSupported);

#pragma 3、识别设备和操作系统
    NSString *name = device.name; NSLog(@"device name is %@",name);
    NSString *systemName = device.name; NSLog(@"device systemName is %@",systemName);
    NSString *systemVersion = device.systemVersion; NSLog(@"device systemVersion is %@",systemVersion);
    NSString *model = device.model; NSLog(@"device model is %@",model);
    NSString *localizedModel = device.localizedModel; NSLog(@"device localizedModel is %@",localizedModel);
    UIUserInterfaceIdiom userInterfaceIdiom = [device userInterfaceIdiom]; NSLog(@"device userInterfaceIdiom is %ld",(long)userInterfaceIdiom);
    NSUUID *identifierForVendor = device.identifierForVendor; NSLog(@"device identifierForVendor is %@\n",identifierForVendor);

#pragma 4、跟踪设备方向
    UIDeviceOrientation orientation = [device orientation];NSLog(@"device orientation is %ld",(long)orientation);
    /**
     https://www.jianshu.com/p/973eff69d2de
     4.1 注册通知
     *  开始生成 设备旋转 通知
     */
    [[UIDevice currentDevice]beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleDeviceOrientationDidChange:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil
     ];
//    4.2 销毁通知
//    /**
//     *  销毁 设备旋转 通知
//     *
//     *  @return return value description
//     */
//    [[NSNotificationCenter defaultCenter] removeObserver:self
//                                                    name:UIDeviceOrientationDidChangeNotification
//                                                  object:nil
//     ];
//    /**
//     *  结束 设备旋转通知
//     *
//     *  @return return value description
//     */
//    [[UIDevice currentDevice]endGeneratingDeviceOrientationNotifications];
    
    
#pragma 4、跟踪设备方向
    
    
}


/**
 旋转屏幕
 */
- (void)handleDeviceOrientationDidChange:(UIInterfaceOrientation)interfaceOrientation
{
    //1.获取 当前设备 实例
    UIDevice *device = [UIDevice currentDevice] ;
    
    /**
     *  2.取得当前Device的方向，Device的方向类型为Integer
     *
     *  必须调用beginGeneratingDeviceOrientationNotifications方法后，此orientation属性才有效，否则一直是0。orientation用于判断设备的朝向，与应用UI方向无关
     *
     *  @param device.orientation
     *
     */
    switch (device.orientation) {
        case UIDeviceOrientationFaceUp:
        NSLog(@"屏幕朝上平躺");
        break;
        
        case UIDeviceOrientationFaceDown:
        NSLog(@"屏幕朝下平躺");
        break;
        
        //系統無法判斷目前Device的方向，有可能是斜置
        case UIDeviceOrientationUnknown:
        NSLog(@"未知方向");
        break;
        
        case UIDeviceOrientationLandscapeLeft:
        NSLog(@"屏幕向左横置");
        break;
        
        case UIDeviceOrientationLandscapeRight:
        NSLog(@"屏幕向右橫置");
        break;
        
        case UIDeviceOrientationPortrait:
        NSLog(@"屏幕直立");
        break;
        
        case UIDeviceOrientationPortraitUpsideDown:
        NSLog(@"屏幕直立，上下顛倒");
        break;
        
        default:
        NSLog(@"无法辨识");
        break;
    }
    
}

#pragma mark 支持窗口翻转
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(nullable UIWindow *)window
{
    if (_allowRotation == YES) {
        
        return UIInterfaceOrientationMaskLandscapeRight;
        
    }else{
        
        return (UIInterfaceOrientationMaskPortrait);
    }
}

/**
 强制横屏
 -(NSUInteger)supportedInterfaceOrientations{
 return UIInterfaceOrientationMaskLandscape;
 }
 */


@end
