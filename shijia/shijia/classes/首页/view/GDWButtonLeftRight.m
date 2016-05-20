//
//  GDWButtonLeftRight.m
//  shijia
//
//  Created by apple on 16/5/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GDWButtonLeftRight.h"

@implementation GDWButtonLeftRight


- (void)layoutSubviews{


    [super  layoutSubviews];
    self.titleLabel.x = 0;
    self.imageView.x = self.titleLabel.width;


}



@end
