//
//  FootView.m
//  UICollectionView
//
//  Created by lee on 2018/9/21.
//  Copyright © 2018年 lee. All rights reserved.
//

#import "FootView.h"

@implementation FootView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:@"FootView" owner:self options:nil].firstObject;
    }
    return self;
}
- (IBAction)clickZFB:(UIButton *)sender {
    NSLog(@"支付宝支付");
}
- (IBAction)ClickWeChat:(UIButton *)sender {
    NSLog(@"微信支付");
}
@end
