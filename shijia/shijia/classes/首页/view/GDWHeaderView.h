//
//  GDWHeaderView.h
//  shijia
//
//  Created by apple on 16/5/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GDWImageDisplayView.h"

@interface GDWHeaderView : UIView

@property (weak, nonatomic) IBOutlet GDWImageDisplayView *imageDisplayView;
@property (weak, nonatomic) IBOutlet UIView *buttonView;

+ (instancetype)headerView;



@end
