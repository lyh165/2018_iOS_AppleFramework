//
//  ViewController.m
//  Framework(AVFoundation_&_ MobileCoreServices)_音频视频
//
//  Created by lee on 2018/9/28.
//  Copyright © 2018年 lee. All rights reserved.
//

#import "ViewController.h"
// 视频录制、拍照
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>


// 获取视频的第一帧
#import <AVFoundation/AVAsset.h>
#import <AVFoundation/AVAssetImageGenerator.h>
#import <AVFoundation/AVTime.h>
#import "NSDictionary+LYH_JSONLog.h"

@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    NSURL * CompressURL;
}
@property (assign,nonatomic) int isVideo;//是否录制视频，如果为1表示录制视频，0代表拍照
@property (strong,nonatomic) UIImagePickerController *imagePicker;
@property (weak, nonatomic) IBOutlet UIImageView *photo;//照片展示视图
@property (strong ,nonatomic) AVPlayer *player;//播放器，用于录制完视频后播放视频
@property (weak, nonatomic) IBOutlet UIImageView *Img_VideoFirst; // 录制之后的视频第一帧
@property (assign,nonatomic) BOOL isSelectVideo;
/**
 解决系统相机英文的问题
 info.plist
 Localized resources can be mixed 设置yes
 
 
 在 info.plist里面添加Localized resources can be mixed YES 表示是否允许应用程序获取框架库内语言。
 */


#pragma 获取视频列表
@property (nonatomic,strong) NSMutableArray        *groupArrays;
@property (nonatomic,strong) UIImageView           *litimgView;

@end

@implementation ViewController

#pragma mark - 控制器视图事件
- (void)viewDidLoad {
    [super viewDidLoad];
    //通过这里设置当前程序是拍照还是录制视频
    _isVideo=YES;
    _isSelectVideo = NO;
    

   
}

#pragma mark - UI事件
//点击拍照按钮
- (IBAction)takeClick:(UIButton *)sender {
    NSLog(@"1、录制视频并且把视频的第一帧保持");
    [self presentViewController:self.imagePicker animated:YES completion:nil];
}
// 获取系统的视频
- (IBAction)getSystemVideo:(UIButton *)sender {
    NSLog(@"2、获取系统的所有视频");
    [self selectAction];
}

#pragma mark - UIImagePickerController代理方法
//完成
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {//如果是拍照
        UIImage *image;
        //如果允许编辑则获得编辑后的照片，否则获取原始照片
        if (self.imagePicker.allowsEditing) {
            image=[info objectForKey:UIImagePickerControllerEditedImage];//获取编辑后的照片
        }else{
            image=[info objectForKey:UIImagePickerControllerOriginalImage];//获取原始照片
        }
        [self.photo setImage:image];//显示照片
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);//保存到相簿
    }else if([mediaType isEqualToString:(NSString *)kUTTypeMovie]){//如果是录制视频
        NSLog(@"video...");
        NSURL *url=[info objectForKey:UIImagePickerControllerMediaURL];//视频路径
        NSString *urlStr=[url path];
        
        if (YES==_isSelectVideo) {
            NSError *error;
            [self video:urlStr didFinishSavingWithError:error contextInfo:nil];
        }
        else
        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(urlStr)) {
            //保存视频到相簿，注意也可以使用ALAssetsLibrary来保存
            UISaveVideoAtPathToSavedPhotosAlbum(urlStr, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);//保存视频到相簿
        }
        
        
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    NSLog(@"取消");
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 私有方法
-(UIImagePickerController *)imagePicker{
    if (!_imagePicker) {
        _imagePicker=[[UIImagePickerController alloc]init];
        _imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;//设置image picker的来源，这里设置为摄像头
        _imagePicker.cameraDevice=UIImagePickerControllerCameraDeviceRear;//设置使用哪个摄像头，这里设置为后置摄像头
        if (self.isVideo) {
            _imagePicker.mediaTypes=@[(NSString *)kUTTypeMovie];
            _imagePicker.videoQuality=UIImagePickerControllerQualityTypeIFrame1280x720;
            _imagePicker.cameraCaptureMode=UIImagePickerControllerCameraCaptureModeVideo;//设置摄像头模式（拍照，录制视频）
            _imagePicker.videoMaximumDuration = 15; // 录制视频的最大时间
            
        }else{
            _imagePicker.cameraCaptureMode=UIImagePickerControllerCameraCaptureModePhoto;
        }
        _imagePicker.allowsEditing=YES;//允许编辑
        _imagePicker.delegate=self;//设置代理，检测操作
    }
    return _imagePicker;
}

//视频保存后的回调
- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error) {
        NSLog(@"保存视频过程中发生错误，错误信息:%@",error.localizedDescription);
        _isSelectVideo = NO;
    }else{
        NSLog(@"视频保存成功.");
        
        NSLog(@"videoPath %@",videoPath);
        NSLog(@"error %@",error);
        NSLog(@"contextInfo %@",contextInfo);

        //录制完之后自动播放
        NSURL *url=[NSURL fileURLWithPath:videoPath];
        NSString *compressionVideoPath = [self compression:url];
        NSLog(@"compressionVideoPath %@",compressionVideoPath);

#warning 这里可以在图片里面进行播放视频 项目一般不使用 这里只是用来测试
//        _player=[AVPlayer playerWithURL:url];
//        AVPlayerLayer *playerLayer=[AVPlayerLayer playerLayerWithPlayer:_player];
//        playerLayer.frame=self.photo.frame;
//        [self.photo.layer addSublayer:playerLayer];
//        [_player play];
//#warning 不允许这样处理 需要压缩完毕之后才能把地址给服务器
//        dispatch_async(dispatch_get_main_queue(), ^{
//            self.Img_VideoFirst.image = [self getVideoPreViewImage:url];
//            NSString *videoFirstImage = [self saveImage:[self getVideoPreViewImage:url]];
//            NSLog(@"videoFirstImage %@",videoFirstImage);
//            // 这里进行发送请求
//            NSLog(@"传递数据给服务器");
//            self.isSelectVideo = NO;
//
//        });

    }
}


// 获取视频第一帧
- (UIImage*) getVideoPreViewImage:(NSURL *)path
{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:path options:nil];
    AVAssetImageGenerator *assetGen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    
    assetGen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [assetGen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *videoImage = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    return videoImage;
}

#pragma mark 视频压缩、计算压缩的大小、视频的第一帧
//- (void)mov2mp4:(NSURL *)movUrl
//{
//    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:movUrl options:nil];
//    NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
//    /**
//     AVAssetExportPresetMediumQuality 表示视频的转换质量，
//     */
//    if ([compatiblePresets containsObject:AVAssetExportPresetMediumQuality]) {
//        AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:avAsset presetName:AVAssetExportPresetMediumQuality];
//        
//        //转换完成保存的文件路径
//        NSString * resultPath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/output-%@.mp4",@"cvt"];
//        
//        exportSession.outputURL = [NSURL fileURLWithPath:resultPath];
//        
//        //要转换的格式，这里使用 MP4
//        exportSession.outputFileType = AVFileTypeMPEG4;
//        
//        //转换的数据是否对网络使用优化
//        exportSession.shouldOptimizeForNetworkUse = YES;
//        
//        //异步处理开始转换
//        [exportSession exportAsynchronouslyWithCompletionHandler:^(void)
//         
//         {
//             //转换状态监控
//             switch (exportSession.status) {
//                 case AVAssetExportSessionStatusUnknown:
//                     NSLog(@"AVAssetExportSessionStatusUnknown");
//                     break;
//                     
//                 case AVAssetExportSessionStatusWaiting:
//                     NSLog(@"AVAssetExportSessionStatusWaiting");
//                     break;
//                     
//                 case AVAssetExportSessionStatusExporting:
//                     NSLog(@"AVAssetExportSessionStatusExporting");
//                     break;
//                 case AVAssetExportSessionStatusFailed:
//                     NSLog(@"AVAssetExportSessionStatusFailed");
//                     break;
//                 case AVAssetExportSessionStatusCancelled:
//                     NSLog(@"AVAssetExportSessionStatusCancelled");
//                     break;
//                     
//                 case AVAssetExportSessionStatusCompleted:
//                 {
//                     //转换完成
//                     NSLog(@"AVAssetExportSessionStatusCompleted");
//                     
//                     //测试使用，保存在手机相册里面
//                     ALAssetsLibrary *assetLibrary = [[ALAssetsLibrary alloc] init];
//                     [assetLibrary writeVideoAtPathToSavedPhotosAlbum:exportSession.outputURL completionBlock:^(NSURL *assetURL, NSError *error){
//                         if (error) {
//                             NSLog(@"%@",error);
//                         }
//                     }];
//                     break;
//                 }
//             }
//             
//         }];
//        
//    }
//    
//}

//计算压缩大小
- (CGFloat)fileSize:(NSURL *)path
{
    return [[NSData dataWithContentsOfURL:path] length]/1024.00 /1024.00;
}
//压缩完之后 返回压缩视频的路径
- (NSString *)compression:(NSURL *)videoUrl
{
    NSLog(@"压缩前大小 %f MB",[self fileSize:videoUrl]);
    //    创建AVAsset对象
    AVAsset* asset = [AVAsset assetWithURL:videoUrl];
    /*   创建AVAssetExportSession对象
     压缩的质量
     AVAssetExportPresetLowQuality   最low的画质最好不要选择实在是看不清楚
     AVAssetExportPresetMediumQuality  使用到压缩的话都说用这个
     AVAssetExportPresetHighestQuality  最清晰的画质
     
     */
    AVAssetExportSession * session = [[AVAssetExportSession alloc] initWithAsset:asset presetName:AVAssetExportPresetMediumQuality];
    //优化网络
    session.shouldOptimizeForNetworkUse = YES;
    //转换后的格式
    
    //拼接输出文件路径 为了防止同名 可以根据日期拼接名字 或者对名字进行MD5加密
    
//    NSString* path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"hello.mp4"];
#warning 视频存放在缓存文件夹里面 不要存放到DocumentDirectory
    // 如果每次想存储不一样的视频 可以使用时间戳进行保存视频和图片
    NSString* path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"hello.mp4"];
    NSLog(@"视频路径 %@",path);
    //判断文件是否存在，如果已经存在删除
    [[NSFileManager defaultManager]removeItemAtPath:path error:nil];
    //设置输出路径
    session.outputURL = [NSURL fileURLWithPath:path];
    
    //设置输出类型  这里可以更改输出的类型 具体可以看文档描述
    session.outputFileType = AVFileTypeMPEG4;
    
    [session exportAsynchronouslyWithCompletionHandler:^{
        NSLog(@"%@",[NSThread currentThread]);
        //压缩完成
        if (session.status==AVAssetExportSessionStatusCompleted) {
            //在主线程中刷新UI界面，弹出控制器通知用户压缩完成
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"导出完成");
                self->CompressURL = session.outputURL;
                self.isSelectVideo = NO;
                NSLog(@"压缩完毕,压缩后大小 %f MB",[self fileSize:self->CompressURL]);
#pragma mark 压缩完成之后的操作 (有服务器才操作)
                self.Img_VideoFirst.image = [self getVideoPreViewImage:videoUrl];
                // 将第一帧图片存储到缓存中
                NSString *videoFirstImage = [self saveImage:[self getVideoPreViewImage:videoUrl]];
                NSLog(@"videoFirstImage %@",videoFirstImage);
                NSLog(@"compressionVideoPath %@",path);
                NSMutableDictionary *dict = [NSMutableDictionary dictionary];
                [dict setValue:videoFirstImage forKey:@"videoImg"];
                [dict setValue:path forKey:@"videoUri"];
                NSString *jsonStr = [dict lyh_jsonLog_descriptionWithLocale:nil];
                NSLog(@"需要传递的路径 %@",jsonStr);
            });
            
        }
        
    }];
    
    return path;
}
#pragma mark - 图片
- (NSString *)saveImage:(UIImage *)image {
#warning 如果想保持随机不一样的图片可以添加时间戳
//    NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSArray *paths =NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES);
    NSString *filePath = [[paths objectAtIndex:0]stringByAppendingPathComponent:
                          [NSString stringWithFormat:@"hello.png"]];  // 保存文件的名称
    BOOL result =[UIImagePNGRepresentation(image)writeToFile:filePath   atomically:YES]; // 保存成功会返回YES
    if (result == YES) {
        NSLog(@"保存成功");
    }
    return filePath;
    
}



// 图片以data形式保存
/*
+ (NSString *)uuid{
    // create a new UUID which you own
    CFUUIDRef uuidref = CFUUIDCreate(kCFAllocatorDefault);
    // create a new CFStringRef (toll-free bridged to NSString)
    // that you own
    CFStringRef uuid = CFUUIDCreateString(kCFAllocatorDefault, uuidref);
    NSString *result = (__bridge NSString *)uuid;
    //release the uuidref
    CFRelease(uuidref);
    // release the UUID
    CFRelease(uuid);
    return result;
}

- (NSString *)saveImg:(UIImage *)image withVideoMid:(NSString *)imgName{
    
    if (!image) {  //防止image不存在，存一个占位图
        image = [UIImage imageNamed:@"posters_default_horizontal"];
    }
    if (!imgName) { //防止imgName不存在,获取一个随机字符串
        imgName = [NSString uuid];
    }
    //png格式
    NSData *imagedata=UIImagePNGRepresentation(image);
    //JEPG格式
    //NSData *imagedata=UIImageJEPGRepresentation(m_imgFore,1.0);
    
    NSString *savedImagePath = [[PVRSandBoxHelper AlbumVideoImagePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", videoMid]];
    [imagedata writeToFile:savedImagePath atomically:YES];
    return savedImagePath;
}

*/


#pragma mark - 获取视频列表
// 参考   https://blog.csdn.net/u013602835/article/details/76640797
- (void)selectAction{
    NSLog(@"从相册选择");
    UIImagePickerController *picker=[[UIImagePickerController alloc] init];
    picker.delegate=self;
    picker.allowsEditing=NO;
    picker.videoMaximumDuration = 15.0;//视频最长长度
    picker.videoQuality = UIImagePickerControllerQualityTypeMedium;//视频质量
    //媒体类型：@"public.movie" 为视频  @"public.image" 为图片
    //这里只选择展示视频
    picker.mediaTypes = [NSArray arrayWithObjects:@"public.movie", nil];
    picker.sourceType= UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    [self presentViewController:picker animated:YES completion:^{
        self.isSelectVideo = YES;
    }];
}



@end
