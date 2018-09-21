//
//  LYHViewController.m
//  UICollectionView
//
//  Created by lee on 2018/9/21.
//  Copyright © 2018年 lee. All rights reserved.
//

#import "LYHUICollectionViewController.h"
#import "HeadCollectionReusableView.h"
#import "FootCollectionReusableView.h" // 底部视图

#import "HeadView.h"                    // collection 头部视图
#import "FootView.h"                    // collection 底部视图
#import "LYHCollectionViewCell.h"       // cell
#import "PayListModel.h"                //  模型


@interface LYHUICollectionViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UICollectionViewDelegate >
@property (weak, nonatomic) IBOutlet UIView *view_recharge;
@property (strong,nonatomic) UICollectionView *collection_view;
@property (strong,nonatomic) NSMutableArray *arr_data;
@end

@implementation LYHUICollectionViewController

NSString *lyh_identifier = @"cell";
/**
 *  注册增补视图用的
 */
NSString *lyh_headerIdentifier = @"header";
NSString *lyh_footerIdentifier = @"FootCollectionReusableView";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 创建布局对象
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    // 设置最小行间距
    flowLayout.minimumLineSpacing = 50;
    // 最小列间距
    flowLayout.minimumInteritemSpacing = 40;
    /**
     *   设置item的大小 格局item的大小自动布局列间距
     *
     *  @param 50 宽
     *  @param 50 高
     *
     *  @return
     */
    flowLayout.itemSize = CGSizeMake(150, 120);
    /**
     *  设置自动滚动的方向 垂直或者横向
     */
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    /**
     *  设置集合视图内边距的大小
     *
     *  @param 20 上
     *  @param 20 左
     *  @param 20 下
     *  @param 20 右
     *
     *  @return  UIEdgeInsetsMake  与下面的方法相同  -(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
     */
    flowLayout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
    /**
     *  设置header区域大小
     *
     *  @param 414 414
     *  @param 70  无用
     *
     *  @return
     */
//    flowLayout.headerReferenceSize = CGSizeMake(414, 70);
    /**
     *  设置footer区域的大小
     *
     *  @param 414 无用
     *  @param 70  自己设置
     *
     *  @return  如果写了这里必须设置注册
     */
    flowLayout.footerReferenceSize = CGSizeMake(414, 70);
    
    /**
     创建UICollectionView前必须先创建布局对象UICollectionViewFlowLayout
     
     - returns: UICollectionViewFlowLayout(布局对象)
     */
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 70, self.view.frame.size.width, self.view_recharge.frame.size.height-120) collectionViewLayout:flowLayout];
    //设置属性
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    // 是否显示垂直方向指示标, 继承于UIScrollView, 他的方法可以调用
    collectionView.showsVerticalScrollIndicator = NO;
    
    // 注册
//    [collectionView registerClass:[LYHCollectionViewCell class] forCellWithReuseIdentifier:lyh_identifier];
    [collectionView registerNib:[UINib nibWithNibName:@"LYHCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:lyh_identifier];

    /**
     *  注册增补视图
     */
    [collectionView registerClass:[HeadCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:lyh_headerIdentifier];
//    [collectionView registerNib:[UINib nibWithNibName:@"HeadCollectionReusableView" bundle:nil] forCellWithReuseIdentifier:lyh_headerIdentifier];

    
    [collectionView registerClass:[FootCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:lyh_footerIdentifier];
//    [collectionView registerNib:[UINib nibWithNibName:@"FootCollectionReusableView" bundle:nil] forCellWithReuseIdentifier:lyh_footerIdentifier];

    // 添加到视图上
    [self.view_recharge addSubview:collectionView];
    self.collection_view = collectionView;
    
    
    [self lyh_getPaymentListWithParameter:nil];

}

#warning UICollectionViewDataSource

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    LYHCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:lyh_identifier forIndexPath:indexPath];
    PayListModel *model = self.arr_data[indexPath.row];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (self.arr_data.firstObject) {
            model.select = YES;
        }
    });
    cell.model = model;
    return cell;
}

// 设置每个分区返回多少item
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.arr_data.count;
}

// 设置集合视图有多少个分区
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

/**
 *  返回增补视图
 *
 *  @param collectionView
 *  @param kind
 *  @param indexPath
 *
 *  @return
 */
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    // 如果是头视图
    if (kind == UICollectionElementKindSectionHeader) {
        // 从重用池里面取
        HeadCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:lyh_headerIdentifier forIndexPath:indexPath];
        headerView.backgroundColor =[UIColor orangeColor];
        //        headerView.titleLabel.text = @"测试";
        HeadView *head = [[HeadView alloc]init];
        [headerView addSubview:head];
        return headerView;
    }else{
        FootCollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:lyh_footerIdentifier forIndexPath:indexPath];
//            footerView.backgroundColor = [UIColor brownColor];
//        FootView *foot = [[FootView alloc]init];
//        [footerView addSubview:foot];
            return footerView;
//        return nil;
    }
    
}

#warning UICollectionViewDelegate
// 点击item触发的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    /**
     推出的页面的布局一般在这里写 最小行间距.列间距等
     - returns:
     */
    NSLog(@"didSelectItemAtIndexPath");
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 先取消所有选中状态
        for (PayListModel *model in self.arr_data) {
            model.select = NO;
        }
        // 在设置选中
        PayListModel *model = self.arr_data[indexPath.row];
        model.select = YES;
    });
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collection_view reloadData];
    });
    NSLog(@"%ld-%ld",indexPath.section,indexPath.row);
    
}


//-(void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"didUnhighlightItemAtIndexPath");
//    LYHCollectionViewCell *cell = (LYHCollectionViewCell *)[self.collection_view cellForItemAtIndexPath:indexPath];
//    cell.backgroundColor = [UIColor redColor];
//
//}
//
//-(void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
//        NSLog(@"didHighlightItemAtIndexPath");
//    LYHCollectionViewCell *cell = (LYHCollectionViewCell *)[self.collection_view cellForItemAtIndexPath:indexPath];
//    cell.backgroundColor = [UIColor yellowColor];
//}


#pragma mark
//-(BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
//    return YES;
//}



/**
 *  指定那些路径可以被点击
 *
 *  @param collectionView
 *  @param indexPath
 *
 *  @return
 // */
//-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//
//    if (indexPath.section == 0) {
//        return NO;
//    }
//    return YES;
//}


#warning UICollectionViewDelegateFlowLayout

/**
 *  返回内边距的上左下右的距离
 *
 *  @param collectionView       UICollectionView
 *  @param collectionViewLayout UICollectionViewLayout
 *  @param section
 *
 *  @return
 */
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    
    return UIEdgeInsetsMake(30, 30, 30, 30);
    
}


#pragma mark 支付列表数据
#pragma mark 1.获取支付价格列表数据
#define payListUrl @"http://193.112.150.101/GrabDoll_Web/myBabyCurrency_getRechargeTypeData1.do"
- (void)lyh_getPaymentListWithParameter:(NSString *)parameter
{
    //对请求路径的说明
    //http://120.25.226.186:32812/login?username=520it&pwd=520&type=JSON
    //协议头+主机地址+接口名称+？+参数1&参数2&参数3
    //协议头(http://)+主机地址(120.25.226.186:32812)+接口名称(login)+？+参数1(username=520it)&参数2(pwd=520)&参数3(type=JSON)
    //GET请求，直接把请求参数跟在URL的后面以？隔开，多个参数之间以&符号拼接
    
    //1.确定请求路径
    NSURL *url = [NSURL URLWithString:payListUrl];
    
    //2.创建请求对象
    //请求对象内部默认已经包含了请求头和请求方法（GET）
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //3.获得会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    
    //4.根据会话对象创建一个Task(发送请求）
    /*
     第一个参数：请求对象
     第二个参数：completionHandler回调（请求完成【成功|失败】的回调）
     data：响应体信息（期望的数据）
     response：响应头信息，主要是对服务器端的描述
     error：错误信息，如果请求失败，则error有值
     */
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error == nil) {
            //6.解析服务器返回的数据
            //说明：（此处返回的数据是JSON格式的，因此使用NSJSONSerialization进行反序列化处理）
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                
                id array  = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                NSLog(@"array --- %@",array);
#pragma mark 数组转模型
                if ([array isKindOfClass:[NSDictionary class]]) {
                    NSLog(@"返回的数据是一个字典");
                    return ;
                }
                
                NSMutableArray *arrayModels = [NSMutableArray array];
                for (NSDictionary *dict in array) {
                        PayListModel *model = [PayListModel payListModelWithDict:dict];
                        [arrayModels addObject:model];
                    
                }
                self.arr_data = arrayModels;
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"dict --- %@",array);
                    [self.collection_view reloadData];
                });
                
            });
        }
    }];
    
    //5.执行任务
    [dataTask resume];
}

@end
