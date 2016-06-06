//
//  GDWTabBar.m
//  UI-0825-综合练习-彩票
//
//  Created by apple on 15/8/25.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "GDWTabBar.h"
#import "GDWButton.h"

@interface GDWTabBar ()

@property (nonatomic,weak)  GDWButton *seletebtn;

@end

@implementation GDWTabBar

- (void)setItemArray:(NSArray *)itemArray
{
    _itemArray=itemArray;
    
    //添加按钮
    for (int  i=0; i<itemArray.count; i++) {
        GDWButton  *btn=[GDWButton   buttonWithType:UIButtonTypeCustom];
        UITabBarItem *item=itemArray[i];
        UIImage *image=item.image;
        UIImage *seleteImage=item.selectedImage;
        //设置状态图片
//        [btn  setBackgroundImage:image forState:UIControlStateNormal];
//        [btn  setBackgroundImage:seleteImage forState:UIControlStateSelected];
        [btn  setImage:image forState:UIControlStateNormal];
        [btn  setImage:seleteImage forState:UIControlStateSelected];
        //设置文字,必须为其指定状态,否则会不显示.例如:btn.titleLabel.text = title系统不知道文字在那种状态下显示.
        NSString *title = item.title;
        [btn   setTitle:title forState:UIControlStateNormal];
        [btn   setTitle:title forState:UIControlStateSelected];
        
        
        //设置标签
        btn.tag=i;
        
        //给按钮添加点击事件.
        [btn  addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    
        //添加子控件.
        [self  addSubview:btn];
        
        if (i==0) {
            btn.selected=YES;
            _seletebtn=btn;
        }
        
    }
    [self  setNeedsLayout];
}
#pragma mark - 内部按钮的监听方法
- (void)btnClick:(GDWButton *)btn
{
    //1.改变按钮的选着状态.(按钮的选着状态由代码改变)
    _seletebtn.selected=NO;
    btn.selected=YES;
    _seletebtn=btn;
    
    //2.按钮的索引
    NSInteger index = [self.subviews indexOfObject:btn];
    _selectedIndex = index;
    
    //3.通过代理在tabBarVC中切换界面
    if (_delegate  && [_delegate  respondsToSelector:@selector(tabBardidClick:)]) {
        [_delegate  tabBardidClick:btn];
    }

}

#pragma mark - 重写setter方法
- (void)setSelectedIndex:(NSInteger)selectedIndex{
    _selectedIndex = selectedIndex;
    GDWButton  *btn=  self.subviews[selectedIndex];
    [self  btnClick:btn];
}

- (void)layoutSubviews
{
    
    
    [super layoutSubviews];
    int n=(int)self.subviews.count;
    CGFloat  W=self.bounds.size.width/n;
    CGFloat  H=self.bounds.size.height;
    
    for (int i=0; i<n; i++) {
        GDWButton  *btn=  self.subviews[i];
        btn.frame=CGRectMake(i*W, 0, W, H);
        
    }
}


@end
