//
//  UIButton+LYH_Block.m
//  UIButton
//
//  Created by lee on 2018/9/15.
//  Copyright © 2018年 lee. All rights reserved.
//

#import "UIButton+LYH_Block.h"
#import <objc/runtime.h>

typedef void(^CQ_ButtonEventsBlock)(void);

@interface UIButton ()

/** 事件回调的block */
@property (nonatomic, copy) CQ_ButtonEventsBlock cq_buttonEventsBlock;

@end


@implementation UIButton (LYH_Block)


//------- 添加属性 -------//

static void *cq_buttonEventsBlockKey = &cq_buttonEventsBlockKey;

- (CQ_ButtonEventsBlock)cq_buttonEventsBlock {
    return objc_getAssociatedObject(self, &cq_buttonEventsBlockKey);
}

- (void)setCq_buttonEventsBlock:(CQ_ButtonEventsBlock)cq_buttonEventsBlock {
    objc_setAssociatedObject(self, &cq_buttonEventsBlockKey, cq_buttonEventsBlock, OBJC_ASSOCIATION_COPY);
}

/**
 给按钮绑定事件回调block
 
 @param block 回调的block
 @param controlEvents 回调block的事件
 */
- (void)cq_addEventHandler:(void (^)(void))block forControlEvents:(UIControlEvents)controlEvents {
    self.cq_buttonEventsBlock = block;
    [self addTarget:self action:@selector(cq_blcokButtonClicked) forControlEvents:controlEvents];
}

// 按钮点击
- (void)cq_blcokButtonClicked {
    !self.cq_buttonEventsBlock ?: self.cq_buttonEventsBlock();
}
@end
