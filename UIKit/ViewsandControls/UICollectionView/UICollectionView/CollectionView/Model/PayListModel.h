//
//  PayListModel.h
//  UICollectionView
//
//  Created by lee on 2018/9/21.
//  Copyright © 2018年 lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PayListModel : NSObject

@property (nonatomic,strong) NSString *bz;
@property (nonatomic,strong) NSString *gxsj;
@property (nonatomic,strong) NSString *id;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *val;
@property (nonatomic,strong) NSString *lrsj;
@property (nonatomic,strong) NSString *zt;


@property (nonatomic,assign) BOOL select;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)payListModelWithDict:(NSDictionary *)dict;

@end
