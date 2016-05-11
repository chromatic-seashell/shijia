//
//  GDWButton.m
//  UI-0825-综合练习-彩票
//
//  Created by apple on 15/8/25.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "GDWButton.h"

#define imageScale  0.6

@implementation GDWButton


- (void)setHighlighted:(BOOL)highlighted{

}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //设置文字
        self.titleLabel.textAlignment=NSTextAlignmentCenter;
        self.titleLabel.font=[UIFont  systemFontOfSize:12];
        [self  setTitleColor:[UIColor  lightGrayColor] forState:UIControlStateNormal];
        [self  setTitleColor:[UIColor  greenColor] forState:UIControlStateSelected];
        
        
        //设置下面属性,为了验证内部空间的位置,
        //self.imageView.backgroundColor = [UIColor  redColor];
        //self.titleLabel.backgroundColor =[UIColor  orangeColor];
    }
    return self;
}

-(void)layoutSubviews{
    
    //调用[super  layoutSubviews]方法,系统已经将子控件的尺寸计算好了.
    [super  layoutSubviews];
    //1.图片位置.
    CGFloat  width=self.width;
    CGFloat  height=self.height;
    CGFloat  min = MIN(width, height);
    //图片宽高相等.
    self.imageView.bounds=CGRectMake(0, 0, min*imageScale, min*imageScale);
    self.imageView.y=height*.1;
    self.imageView.centerX=width*0.5;
    //2.lable位置.
    self.titleLabel.frame=CGRectMake(0, self.imageView.bottom, width, self.height-self.imageView.bottom);
    
}

@end
