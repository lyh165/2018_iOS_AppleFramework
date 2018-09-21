//
//  PayListModel.m
//  UICollectionView
//
//  Created by lee on 2018/9/21.
//  Copyright © 2018年 lee. All rights reserved.
//

#import "PayListModel.h"

@implementation PayListModel
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.bz = dict[@"bz"];
        self.bz = dict[@"gxsj"];
        self.id = dict[@"init_id"];
        self.name = dict[@"init_name"];
        self.val = dict[@"init_val"];
        self.lrsj = dict[@"lrsj"];
        self.zt = dict[@"zt"];
        self.select = NO;
    }
    return self;
}
+ (instancetype)payListModelWithDict:(NSDictionary *)dict
{
    return  [[self alloc] initWithDict:dict];
}
@end
