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

#import "GDWTabBar.h"
#import "GDWButton.h"




@interface GDWTabBarController ()<GDWTabBarDelegate>

@property  (nonatomic,strong)  NSMutableArray * items;

/* 自定义tabBar */
@property (nonatomic,weak) GDWTabBar *customTabBar;

@end

@implementation GDWTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.view.backgroundColor = [UIColor cyanColor];
    //1.添加自控制器.
    [self  setUpAllChildViewController];
    
    //2.设置tabBar
    [self  setUpTabBar];
    
    
    
    //3.设置默认的选中控制器.
    self.selectedIndex = 1;
    
    
}
/** 重写系统的selectedIndex属性的setter方法 */
- (void)setSelectedIndex:(NSUInteger)selectedIndex{

    [super  setSelectedIndex:selectedIndex];
    
    //修改自定义的tabBar内按钮的索引.
    if (self.customTabBar.selectedIndex != selectedIndex) {//防止循环调用.
        self.customTabBar.selectedIndex = selectedIndex;
    }
}

#pragma mark   items懒加载.
- (NSMutableArray *)items
{
    if (!_items) {
        _items =[NSMutableArray  array];
    }
    return _items;
}

#pragma mark - 设置导航条
- (void)setUpTabBar
{
    
    //创建自定义导航条.
    GDWTabBar  *tabBar=[[GDWTabBar  alloc]  init];
    self.customTabBar = tabBar;
    tabBar.frame=self.tabBar.bounds;
    //tabBar.frame=self.tabBar.frame;
    
    tabBar.itemArray=_items;
    //设置代理
    tabBar.delegate=self;
    
    //自定义的tabBar加到系统的tabBar上.
    [self.tabBar   addSubview:tabBar];
    
}
#define mark  GDWTabBard的代理方法
- (void)tabBardidClick:(GDWButton *)sender
{
    self.selectedIndex=sender.tag;
    //GDWLog(@"%@",sender.titleLabel.text);


}
// tabBar控制器的view即将显示的时候调用
- (void)viewWillAppear:(BOOL)animated
{
    //调用一下父类的方法.
    [super   viewWillAppear:animated];
    // 干掉系统的UITabBarButton
    for (UIView  *view in self.tabBar.subviews) {
        if (![view  isKindOfClass:[GDWTabBar  class]]) {
            [view  removeFromSuperview];
        }
    }
}



#pragma mark - 添加自控制器
- (void)setUpAllChildViewController{

    
    //1.首页
    GDWHomeViewController *homeVc = [[GDWHomeViewController  alloc]  init];
    [self  addOneViewController:homeVc image:[UIImage  imageNamed:@"ic_home_normal"] seletedImage:[UIImage  imageNamed:@"ic_home_pressed"] title:@"首页"];
    //2.教学点
    GDWTeachPositionController *teachPositionVc =[UIStoryboard  storyboardWithName:NSStringFromClass([GDWTeachPositionController  class]) bundle:nil].instantiateInitialViewController;//从storyboard加载控制器.
    //GDWTeachPositionController *teachPositionVc = [[GDWTeachPositionController  alloc]  init];
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
    GDWNavigationController *navVc=[[GDWNavigationController  alloc]  initWithRootViewController:vc];
    //屏蔽图片的默认渲染.
    [navVc.tabBarItem  setImage:[image  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [navVc.tabBarItem  setSelectedImage:[seletedImage  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    //设置导航条标题.
    vc.title=title;
    
    //2.添加子控制器
    [self  addChildViewController:navVc];
    //3.缓存tabBarItem
    [self.items  addObject:navVc.tabBarItem];

}


@end
