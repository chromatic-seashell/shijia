//
//  GDWAnnotation.h
//  自定义大头针展示数据
//
//  Created by apple on 16/4/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "GDWTeachPositionModel.h"


@interface GDWAnnotation : NSObject  <MKAnnotation>

// 大头针所在的经纬度
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;


// 大头针标注显示的标题
@property (nonatomic, copy) NSString *title;
// 大头针标注显示的子标题
@property (nonatomic, copy) NSString *subtitle;

//数据模型
/** 数据模型 */
@property (nonatomic, strong) GDWTeachPositionModel *teachPositionModel;


+ (instancetype)annotationWith:(GDWTeachPositionModel *)teachPositionModel;

@end
