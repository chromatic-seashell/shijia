//
//  GDWHomeViewController.m
//  shijia
//
//  Created by apple on 16/5/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GDWHomeViewController.h"
#import "GDWHomeTableHeaderView.h"


@interface GDWHomeViewController ()<UITableViewDataSource,UITableViewDelegate>


/*  tableView */
@property (nonatomic,weak) UITableView *tableView;

/** 首页教学秀图片模型数组 */
@property (nonatomic, strong) NSArray *teachPictureModels;
/** 首页推荐活动模型数组 */
@property (nonatomic, strong) NSArray *eventModels;

@end

@implementation GDWHomeViewController

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

#pragma mark -
//自定义控制器的view
- (void)loadView{
    //0.创建tableView
    UITableView *tableView = [[UITableView  alloc]  initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    self.view = tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.设置导航条
    [self   setUpNavigationBar];
    
   
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
    
    static NSString *ID=@"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID ];
    if (!cell) {
        cell=[[UITableViewCell  alloc]  init];
    }
    cell.backgroundColor = [UIColor  lightGrayColor];
    cell.textLabel.text=[NSString  stringWithFormat:@"全部---%ld",indexPath.row ];
    
    return cell;
}

#pragma mark - UITableViewDelegate
//自定义组头view
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    //设置头部view
    GDWHomeTableHeaderView *headerView = [GDWHomeTableHeaderView  homeTableHeaderView];
    //根据不同组设置头部view的内容
    if (section == 0) {
        headerView.backgroundColor=[UIColor  purpleColor];
        headerView.leftLable.text = @"教学秀";
        
    }else if(section == 1){
        
        headerView.backgroundColor=[UIColor  cyanColor];
        headerView.leftLable.text = @"推荐活动";
    }
    return headerView;
    
}
//行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        return 300;
    }else if(indexPath.section == 1){
        return 150;
    }
    return 0;
}
//组头view的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{


    return 40;
}
@end
