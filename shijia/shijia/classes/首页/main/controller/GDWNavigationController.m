//
//  GDWNavigationController.m
//  shijia
//
//  Created by apple on 16/5/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GDWNavigationController.h"

@interface GDWNavigationController ()

@end

@implementation GDWNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


/** 重写naVC的push方法 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{

    if (self.childViewControllers.count!=0) {
        //NSLog(@"%ld",self.childViewControllers.count);
        //NSLog(@"%@",[viewController  class]);
        //1.隐藏底部导航条
        viewController.hidesBottomBarWhenPushed=YES;
        //2.1创建按钮.
        UIButton *button=[UIButton  buttonWithType:UIButtonTypeCustom];
        //2.2设置按钮图片
        [button  setImage:[UIImage  imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [button  setImage:[UIImage  imageNamed: @"navigationButtonReturnClick"]   forState:UIControlStateHighlighted];
        //2.3设置文字
        [button  setTitle:@"返回" forState:UIControlStateNormal];
        [button  setTitle:@"返回" forState:UIControlStateHighlighted];
        [button  setTitleColor:[UIColor  blackColor] forState:UIControlStateNormal];
        [button   setTitleColor:[UIColor  redColor] forState:UIControlStateHighlighted];
        //使按钮自适应大小.
        [button  sizeToFit];
        //2.4改变按钮的内边距,调整按钮的位置.
        button.contentEdgeInsets=UIEdgeInsetsMake(0, -20, 0, 0);
        [button   addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem=[[UIBarButtonItem  alloc]  initWithCustomView:button];
    }
    
    [super  pushViewController:viewController animated:YES];

}

- (void)back:(UIButton *)btn{
    
    [self  popViewControllerAnimated:YES];
    
}


@end
