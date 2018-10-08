//
//  ViewController.m
//  1_iOS从相机或相册获取图片并裁剪
//
//  Created by lee on 2018/10/7.
//  Copyright © 2018年 lee. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self showUploadSheet];
}
- (void)showUploadSheet {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"上传" message:@"选择图片的方式" preferredStyle:UIAlertControllerStyleActionSheet];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *pickVC = [[UIImagePickerController alloc] init];
        pickVC.delegate = self;
        pickVC.allowsEditing = YES;
        pickVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:pickVC animated:YES completion:nil];
    }]];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    NSLog(@"image:%@",info);
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
}


@end
