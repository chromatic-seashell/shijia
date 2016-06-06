//
//  GDWTeachPositionController.m
//  shijia
//
//  Created by apple on 16/5/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GDWTeachPositionController.h"
#import "GDWTeachPositionModel.h"
#import "GDWTeachPositionCell.h"

@interface GDWTeachPositionController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
/** 教学点数据 */
@property (nonatomic, strong) NSArray *teachPositionModels;

@end

@implementation GDWTeachPositionController

#pragma mark - cell的identifier
static  NSString * const  teachePositionCell=@"teachePositionCel";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor  lightGrayColor];
    
    //1.设置导航条
    [self  setUpNavBar];
    
    //2.设置tableView
    [self  setUpTableView];
    
//    NSLog(@"%@",NSStringFromCGRect(self.navigationController.navigationBar.frame));
}
#pragma mark - 懒加载
- (NSArray *)teachPositionModels{
    if (!_teachPositionModels) {
        //从工具类中加载数据.
        _teachPositionModels = [[DataTool  shareDataTool]  teachPositionModels];
    }
    return _teachPositionModels;
}

#pragma mark - 初始化
- (void)setUpNavBar{
    //1.标题
    self.navigationItem.title = @"线下教学点";
    //2.右侧按钮
    UIButton *button=[UIButton  buttonWithType:UIButtonTypeCustom];
    [button  setImage:[UIImage  imageNamed:@"position_right_btn_icon"] forState:UIControlStateNormal];
    [button  setImage:[UIImage  imageNamed: @"position_map_fliter_btn_icon"]   forState:UIControlStateSelected];
    //[button  sizeToFit];//使按钮自适应大小.
    button.bounds = CGRectMake(0, 0, 30, 30);//图片大小不合适,改变按钮的大小.
    //button1添加监听事件.
    [button  addTarget:self action:@selector(mapBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item=[[UIBarButtonItem  alloc]  initWithCustomView:button];
    
    self.navigationItem.rightBarButtonItems=@[item];


}

- (void)mapBtnClick:(UIButton *)sender{

    sender.selected = !sender.selected;

}

- (void)setUpTableView{

    //1.注册cell
    [self.tableView  registerNib:[UINib  nibWithNibName:NSStringFromClass([GDWTeachPositionCell  class]) bundle:nil] forCellReuseIdentifier:teachePositionCell];
    //2.设置属性
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    //禁止控制器自动调整scrollView的内边距.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.rowHeight = 85;
    //self.tableView.backgroundColor = [UIColor  lightGrayColor];//也可以在storyboard中修改背景颜色.

}


#pragma mark -  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.teachPositionModels.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GDWTeachPositionCell *cell = [tableView dequeueReusableCellWithIdentifier:teachePositionCell ];
    //取出模型
    GDWTeachPositionModel *teachPositionModel = self.teachPositionModels[indexPath.row];
    cell.teachPositionModel = teachPositionModel;
    
    return cell;
}



@end
