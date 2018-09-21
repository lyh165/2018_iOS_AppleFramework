//
//  LYHCollectionViewCell.m
//  UICollectionView
//
//  Created by lee on 2018/9/21.
//  Copyright © 2018年 lee. All rights reserved.
//

#import "LYHCollectionViewCell.h"
#import "PayListModel.h"

@implementation LYHCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
//
//- (void)setSelected:(BOOL)selected
//{
//    [super setSelected:selected];
//    if (selected) {
//        // 选中
//        [self.img_seleteState setImage:[UIImage imageNamed:@"充值_勾"]];
//    }
//    else
//    {
//        // 非选中
//        [self.img_seleteState setImage:[UIImage imageNamed:@"充值_选择勾框"]];
//    }
//}

- (void)setModel:(PayListModel *)model
{
    _model = model;
    
    self.lb_gameMoney.text = model.name;
    self.lb_rmbMoney.text = [NSString stringWithFormat:@"¥%@",model.val];
    if (model.select) {
        [self.img_seleteState setImage:[UIImage imageNamed:@"充值_勾"]];
    }
    else
    {
        [self.img_seleteState setImage:[UIImage imageNamed:@"充值_选择勾框"]];
    }
    
}

@end
