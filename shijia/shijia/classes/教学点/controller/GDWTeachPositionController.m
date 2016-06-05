//
//  GDWTeachPositionController.m
//  shijia
//
//  Created by apple on 16/5/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GDWTeachPositionController.h"

@interface GDWTeachPositionController ()

@end

@implementation GDWTeachPositionController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor  lightGrayColor];
    
    //1.设置导航条
    [self  setUpNavBar];
    
    NSLog(@"%@",NSStringFromCGRect(self.navigationController.navigationBar.frame));
}
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
