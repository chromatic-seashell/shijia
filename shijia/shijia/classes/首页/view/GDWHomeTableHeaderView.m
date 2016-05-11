//
//  GDWHomeTableHeaderView.m
//  shijia
//
//  Created by apple on 16/5/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GDWHomeTableHeaderView.h"

@implementation GDWHomeTableHeaderView


+ (instancetype)homeTableHeaderView{

   return  [[[NSBundle mainBundle]  loadNibNamed:NSStringFromClass([self  class]) owner:nil options:nil]  firstObject];

}


@end
