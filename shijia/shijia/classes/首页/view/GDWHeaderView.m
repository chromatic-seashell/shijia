//
//  GDWHeaderView.m
//  shijia
//
//  Created by apple on 16/5/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GDWHeaderView.h"

@implementation GDWHeaderView

+ (instancetype)headerView{


    return  [[[NSBundle   mainBundle]   loadNibNamed:NSStringFromClass([self  class]) owner:nil options:nil]  firstObject];
}
@end
