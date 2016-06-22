//
//  GDWView.h
//  自定义大头针展示数据
//
//  Created by apple on 16/4/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GDWAnnotation;

@interface GDWAnnotationViewCalloutView : UIView

/** 大头针数据模型 */
@property (nonatomic, strong) GDWAnnotation *annotation;



@end
