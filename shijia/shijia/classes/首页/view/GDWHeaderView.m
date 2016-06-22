//
//  GDWHeaderView.m
//  shijia
//
//  Created by apple on 16/5/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GDWHeaderView.h"

@interface GDWHeaderView ()

@end


@implementation GDWHeaderView

+ (instancetype)headerView{


    return  [[[NSBundle   mainBundle]   loadNibNamed:NSStringFromClass([self  class]) owner:nil options:nil]  firstObject];
}

- (void)awakeFromNib{

}

//- (void)setFrame:(CGRect)frame{
//
//  GDWLogFuc
//    [super  setFrame:frame];
//}
//- (CGFloat)heightForButtonView{
//
//
//
//
//}


@end
