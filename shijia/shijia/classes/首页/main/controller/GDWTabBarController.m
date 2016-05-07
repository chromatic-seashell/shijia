//
//  GDWTabBarController.m
//  shijia
//
//  Created by apple on 16/5/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GDWTabBarController.h"

#import "GDWNavigationController.h"
#import "GDWHomeViewController.h"
#import "GDWDiscoverController.h"
#import "GDWTeachPositionController.h"
#import "GDWMineController.h"




@interface GDWTabBarController ()

@end

@implementation GDWTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor cyanColor];
    //1.添加自控制器.
    [self  setUpAllChildViewController];
    
}

#pragma mark 添加自控制器
- (void)setUpAllChildViewController{

    
    //1.首页
    GDWHomeViewController *homeVc = [[GDWHomeViewController  alloc]  init];
    [self  addOneViewController:homeVc image:[UIImage  imageNamed:@"ic_home_normal"] seletedImage:[UIImage  imageNamed:@"ic_home_pressed"] title:@"首页"];
    //2.教学点
    GDWTeachPositionController *teachPositionVc = [[GDWTeachPositionController  alloc]  init];
    [self  addOneViewController:teachPositionVc image:[UIImage  imageNamed:@"ic_position_normal"] seletedImage:[UIImage  imageNamed:@"ic_position_pressed"] title:@"教学点"];
    //3.发现
    GDWDiscoverController *discoverVc = [[GDWDiscoverController  alloc]  init];
    [self  addOneViewController:discoverVc image:[UIImage  imageNamed:@"ic_discovery_normal"] seletedImage:[UIImage  imageNamed:@"ic_discovery_pressed"] title:@"发现"];
    //1.首页
    GDWMineController *mineVc = [[GDWMineController  alloc]  init];
    [self  addOneViewController:mineVc image:[UIImage  imageNamed:@"ic_my_normal"] seletedImage:[UIImage  imageNamed:@"ic_my_pressed"] title:@"我的"];
    


}

- (void)addOneViewController:(UIViewController  *)vc    image:(UIImage *)image   seletedImage:(UIImage *)seletedImage  title:(NSString *)title{
    
    //1.创建导航控制器
    UINavigationController *navVc=[[GDWNavigationController  alloc]  initWithRootViewController:vc];
    //屏蔽图片的默认渲染.
    [navVc.tabBarItem  setImage:[image  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [navVc.tabBarItem  setSelectedImage:[seletedImage  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    //设置导航条标题.
    vc.title=title;
    
    //2.添加子控制器
    [self  addChildViewController:navVc];

}


@end
