//
//  LYH_Label.m
//  UILabel_文字渐变
//
//  Created by lee on 2018/9/25.
//  Copyright © 2018年 lee. All rights reserved.
//

#import "LYH_Label.h"

@implementation LYH_Label

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 获取文字mask
    [@"我只在乎你" drawInRect:self.bounds withAttributes:@{NSFontAttributeName : self.font}];
    CGImageRef textMask = CGBitmapContextCreateImage(context);
    
    // 清空画布
    CGContextClearRect(context, rect);
    
    // 设置蒙层
    CGContextTranslateCTM(context, 0.0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextClipToMask(context, rect, textMask);
    
    // 绘制渐变
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = {0, 0.5, 1};
    CGFloat colors[] = {1.0,0.0,0.0,1.0,
        0.0,1.0,0.0,1.0,
        0.0,0.0,1.0,1.0};
    CGGradientRef gradient=CGGradientCreateWithColorComponents(colorSpace, colors, locations, 3);
    CGPoint start = CGPointMake(0, self.bounds.size.height / 2.0);
    CGPoint end = CGPointMake(self.bounds.size.width, self.bounds.size.height / 2.0);
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation);
    
    // 释放
    CGColorSpaceRelease(colorSpace);
    CGGradientRelease(gradient);
    CGImageRelease(textMask);
}




@end
