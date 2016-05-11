//
//  GDWHomeTableHeaderView.h
//  shijia
//
//  Created by apple on 16/5/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GDWHomeTableHeaderView : UIView


@property (weak, nonatomic) IBOutlet UILabel *leftLable;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;

+ (instancetype)homeTableHeaderView;


@end
