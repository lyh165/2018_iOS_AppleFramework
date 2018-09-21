//
//  LYHCollectionViewCell.h
//  UICollectionView
//
//  Created by lee on 2018/9/21.
//  Copyright © 2018年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PayListModel;
@interface LYHCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *lb_gameMoney;
@property (weak, nonatomic) IBOutlet UILabel *lb_rmbMoney;
@property (weak, nonatomic) IBOutlet UIImageView *img_seleteState;
@property (strong,nonatomic) PayListModel *model;
@end
