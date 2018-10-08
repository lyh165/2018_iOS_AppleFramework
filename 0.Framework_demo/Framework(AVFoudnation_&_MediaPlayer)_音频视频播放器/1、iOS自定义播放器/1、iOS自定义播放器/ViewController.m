//
//  ViewController.m
//  1、iOS自定义播放器
//
//  Created by lee on 2018/10/8.
//  Copyright © 2018年 lee. All rights reserved.
//

#import "ViewController.h"
#import "CLPlayerView.h"
@interface ViewController ()
@property (strong,nonatomic) CLPlayerView *playerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CLPlayerView *playerView = [[CLPlayerView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    self.playerView = playerView;
    [self.view addSubview:_playerView];
    
    UILabel *lb = [[UILabel alloc]init];
    lb.frame = CGRectMake(0, 0, 100, 100);
    lb.textColor = [UIColor redColor];
    lb.text =@"333213123";
    [self.playerView addSubview:lb];
    
    //视频地址
    _playerView.url = [NSURL URLWithString:@"http://183.60.197.35/4/o/y/p/j/oypjhbyjemnmyzlqcgdmwzxvpcojyd/hd.yinyuetai.com/0D7601345B999963CD41FB5D5CF356C0.flv"];
    //播放
    [_playerView playVideo];
    //返回按钮点击事件回调
    [_playerView backButton:^(UIButton *button) {
        NSLog(@"返回按钮被点击");
    }];
    //播放完成回调
    [_playerView endPlay:^{
        //销毁播放器
        [_playerView destroyPlayer];
        _playerView = nil;
        NSLog(@"播放完成");
    }];
}

@end
