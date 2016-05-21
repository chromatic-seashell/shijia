//
//  GDWHomeViewController.m
//  shijia
//
//  Created by apple on 16/5/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GDWHomeViewController.h"

#import "GDWHeaderView.h"
#import "GDWHomeTableHeaderView.h"

#import "GDWEventCell.h"
#import "GDWTeachPictureCell.h"

#import <SDWebImage/SDWebImageManager.h>





typedef void(^ImageDownLoadBlock)(NSArray *images);


@interface GDWHomeViewController ()<UITableViewDataSource,UITableViewDelegate>


/*  tableView */
@property (nonatomic,weak) UITableView *tableView;

/** 首页教学秀图片模型数组 */
@property (nonatomic, strong) NSArray *teachPictureModels;
/** 首页推荐活动模型数组 */
@property (nonatomic, strong) NSArray *eventModels;
/** 首页图片轮播器模型数组 */
@property (nonatomic, strong) NSArray *cycPictureModels;

@end

@implementation GDWHomeViewController


#pragma mark - cell的identifier
static  NSString * const  eventCell=@"eventCell";
static  NSString * const  teachPictureCell = @"teachPictureCell";

#pragma mark - 懒加载
/** teachPictureModels懒加载 */
- (NSArray *)teachPictureModels{
    if (!_teachPictureModels) {
        _teachPictureModels = [[DataTool   shareDataTool]  teachPictureModels];
    }
    return _teachPictureModels;
}
/** eventModels懒加载 */
- (NSArray *)eventModels{
    if (!_eventModels) {
        _eventModels = [[DataTool   shareDataTool]  eventModels];
    }
    return _eventModels;
}
/** cycPictureModels懒加载 */
- (NSArray *)cycPictureModels{
    if (!_cycPictureModels) {
        _cycPictureModels = [[DataTool   shareDataTool]  circlePictureModels];
    }
    return _cycPictureModels;
}


#pragma mark - 控制器的生命周期方法
//自定义控制器的view
- (void)loadView{
    //0.创建tableView
    UITableView *tableView = [[UITableView  alloc]  initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    self.view = tableView;
    self.tableView = tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //禁止控制器自动调整内边距.(禁止系统的布局,使用自己的布局)
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.tableView.autoresizingMask = UIViewAutoresizingNone;
    
    //1.设置导航条
    [self   setUpNavigationBar];
    
    //2.注册cell
    [self.tableView  registerNib:[UINib  nibWithNibName:NSStringFromClass([GDWEventCell   class]) bundle:nil] forCellReuseIdentifier:eventCell];
    [self.tableView  registerNib:[UINib  nibWithNibName:NSStringFromClass([GDWTeachPictureCell  class]) bundle:nil] forCellReuseIdentifier:teachPictureCell];
    
    //3.设置tableView的headerView
    GDWHeaderView *headerView = [GDWHeaderView  headerView];
    headerView.frame = CGRectMake(0, 0, GDWScreenW, 310);
    self.tableView.tableHeaderView = headerView;
    
    //给图片轮播器设置图片资源.
    [self  setUpImageDisplayViewWithBlock:^(NSArray *images) {
        headerView.imageDisplayView.images = images;
    }];

    
}

//下载图片轮播器的图片资源.
- (void)setUpImageDisplayViewWithBlock:(ImageDownLoadBlock)block{
    
    //缓存图片数组
    NSMutableArray *images = [NSMutableArray  array];
    //1.创建组
    dispatch_group_t group = dispatch_group_create();
    GDWCycPictureModel *cycPictureModel;
    
    for (cycPictureModel in self.cycPictureModels) {
        NSURL *url =[NSURL   URLWithString:cycPictureModel.image];
        
        //2.将操作放到组中
        dispatch_group_enter(group);
        
        [[SDWebImageManager  sharedManager]  downloadImageWithURL:url options:SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            //NSLog(@"%@---%@",image,imageURL);
            [images  addObject:image];
            //3.将操作从组中移除
            dispatch_group_leave(group);
        }];
    }
    //4.当图片都下载往后,给轮播器设置图片.
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        //图片都下载完后执行以下外面设置的block
        block(images);
    });
}




- (void)viewWillAppear:(BOOL)animated{
    [super  viewWillAppear:animated];
    self.tableView.tableHeaderView.frame = CGRectMake(0, 0, GDWScreenW, 310);

}

- (void)setUpNavigationBar{
    //1.设置标题
    self.navigationItem.title = @"师佳";
    UIImage *backgrondImage = [UIImage  imageNamed:@"app_bg_color"];
    //2.设置导航条背景图片.
    [self.navigationController.navigationBar  setBackgroundImage:backgrondImage forBarMetrics:UIBarMetricsDefault];
}

#pragma mark - Table view data source
//组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
//每组行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        return 1;
    }else if(section == 1){
        return self.eventModels.count;
    }
    return 0;
}
//返回Cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell * cell;
    
    if (indexPath.section == 0) {//教学秀的cell
        
        cell = [tableView  dequeueReusableCellWithIdentifier:teachPictureCell];
        
        GDWTeachPictureCell *teachPictureCell = (GDWTeachPictureCell *)cell;
        teachPictureCell.teachPictureModels = self.teachPictureModels;
    
    } else if(indexPath.section == 1){//推荐活动的cell
        //GDWLogFuc
        GDWEventModel *eventModel = self.eventModels[indexPath.row];
        cell = [tableView  dequeueReusableCellWithIdentifier:eventCell];
        GDWEventCell * eventCell =(GDWEventCell *)cell;
        eventCell.eventModel = eventModel;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
//自定义组头view
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    //设置头部view
    GDWHomeTableHeaderView *headerView = [GDWHomeTableHeaderView  homeTableHeaderView];
    //根据不同组设置头部view的内容
    if (section == 0) {

        headerView.leftLable.text = @"教学秀";
        
    }else if(section == 1){
        
        headerView.leftLable.text = @"推荐活动";
    }
    return headerView;
    
}
//行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    //GDWLogFuc
    if (indexPath.section == 0) {
        
        CGFloat height = [self  heightForTeachPictureCellWithItemSize:[self  calculateItemSize] itemNumber:self.teachPictureModels.count cols:4 border:GDWItemBorder];
        return height;
        
    }else if(indexPath.section == 1){
        //取出模型
        GDWEventModel *eventModel = self.eventModels[indexPath.row];
        
        return eventModel.cellHeight;
    }
    return 0;
}

- (CGFloat)heightForTeachPictureCellWithItemSize:(CGSize)itemSize  itemNumber:(NSInteger)itemNumber  cols:(NSInteger)cols border:(CGFloat)border{

    //计算行数
    NSInteger rows = (itemNumber %cols == 0)?itemNumber/cols :itemNumber/cols + 1;
    CGFloat itemH = itemSize.height;
    CGFloat cellHeight = rows *itemH + (rows - 1)*border;

    return cellHeight;
}

- (CGSize)calculateItemSize{
    
    CGFloat border = GDWItemBorder;
    CGFloat width = GDWScreenW;
    CGFloat itemW = (width - border*3)/4;
    CGFloat itemH = itemW;
    return  CGSizeMake(itemW, itemH);
}



//组头view的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 40;
}
//组尾的高度(1.如果不设置可能系统有默认值,会使组间出现间隙.2.如果设为0系统会返回默认值)
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 0.01;
}

//点击cell时调用
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 1) {
        //1.取出模型
        GDWEventModel *eventModel = self.eventModels[indexPath.row];
         NSLog(@"%@",eventModel.coverImage);
        //2.加载网页.
        
    }
}


@end
