//
//  GDWTabBar.h
//  UI-0825-综合练习-彩票
//
//  Created by apple on 15/8/25.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GDWButton;

@protocol GDWTabBarDelegate <NSObject>
- (void)tabBardidClick:(GDWButton *)sender;
@end



@interface GDWTabBar : UIView

@property (nonatomic,strong) NSArray *itemArray;
/**
 *  通过代理在tabBarVC中切换界面
 */
@property (nonatomic,weak)  id <GDWTabBarDelegate>  delegate;

@end
