//
//  UIButton+LYH_Block.h
//  UIButton
//
//  Created by lee on 2018/9/15.
//  Copyright © 2018年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (LYH_Block)
/**
 给按钮绑定事件回调block
 
 @param block 回调的block
 @param controlEvents 回调block的事件
 */
- (void)cq_addEventHandler:(void(^)(void))block forControlEvents:(UIControlEvents)controlEvents;
@end
