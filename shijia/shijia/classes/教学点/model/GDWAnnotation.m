//
//  GDWAnnotation.m
//  自定义大头针展示数据
//
//  Created by apple on 16/4/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GDWAnnotation.h"
#import <CoreLocation/CoreLocation.h>

@interface GDWAnnotation ()

/** 标注 */
@property (nonatomic, strong) CLGeocoder *geoC;

@end


@implementation GDWAnnotation 

/** geoC属性的懒加载 */
-(CLGeocoder *)geoC
{
    if (!_geoC) {
        _geoC = [[CLGeocoder alloc] init];
    }
    return _geoC;
}



+ (instancetype)annotationWith:(GDWTeachPositionModel *)teachPositionModel{

    GDWAnnotation *annotation = [[GDWAnnotation alloc]  init];
    annotation.teachPositionModel = teachPositionModel;
    
    CLLocationDegrees latitude = [teachPositionModel.lat  doubleValue];
    CLLocationDegrees longitude = [teachPositionModel.lng  doubleValue];
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake( latitude, longitude);
    annotation.coordinate = coordinate;
    annotation.subtitle = teachPositionModel.address;
    annotation.title = teachPositionModel.pos_name;
    
    return annotation;
}

@end
