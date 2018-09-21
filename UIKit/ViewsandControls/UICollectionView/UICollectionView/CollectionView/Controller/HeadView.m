//
//  HeadView.m
//  UICollectionView
//
//  Created by lee on 2018/9/21.
//  Copyright © 2018年 lee. All rights reserved.
//

#import "HeadView.h"

@implementation HeadView

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
        self = [[NSBundle mainBundle] loadNibNamed:@"HeadView" owner:self options:nil].firstObject;
    }
    return self;
}

@end
