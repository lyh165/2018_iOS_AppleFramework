//
//  ViewController.m
//  UILabel_文字渐变
//
//  Created by lee on 2018/9/25.
//  Copyright © 2018年 lee. All rights reserved.
//

#import "ViewController.h"
#import "LYH_Label.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /*
    LYH_Label *lb  = [[LYH_Label alloc]init];
    lb.frame = CGRectMake(0, 0, 100, 100);
    [self.view addSubview:lb];
    */
 
    [self method3];
}


- (void)method3{
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(100,100, 300,100)];
    label.text=@"20";
    label.font=[UIFont boldSystemFontOfSize:30];
    [self.view addSubview:label];
    //然后创建一个渐变层
    CAGradientLayer *layer=[CAGradientLayer layer];
    layer.frame=label.frame;
    // 设置组合颜色
    [layer setColors:@[(id)[UIColor orangeColor].CGColor, (id)[UIColor
                                                        yellowColor].CGColor]];
    [self.view.layer addSublayer:layer];
    //颜色上下渐变
    [layer setStartPoint:CGPointMake(0,0)];
    [layer setEndPoint:CGPointMake(0,1)];
    //用label去裁剪渐变层，
    //一旦把label层设置为mask层，label层就不能显示了,会直接从父层中移除，然后作为渐变层的mask层，且label层的父层会指向渐变层，这样做的目的：以渐变层为坐标系，方便计算裁剪区域，如果以其他层为坐标系，还需要做点的转换，需要把别的坐标系上的点，转换成自己坐标系上点，判断当前点在不在裁剪范围内，比较麻烦。
    layer.mask=label.layer;
    // 父层改了，坐标系也就改了，需要重新设置label的位置，才能正确的设置裁剪区域。
    label.frame=layer.bounds;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
