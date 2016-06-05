//
//  GDWTeachPositionModel.h
//  shijia
//
//  Created by apple on 16/6/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GDWTeachPositionModel : NSObject

/** 活动 */
@property (nonatomic, strong) NSArray *activities;

/** 地址 */
@property (nonatomic, copy) NSString *address;
/** 头像 */
@property (nonatomic, copy) NSString *cover;
/**标识 */
@property (nonatomic, assign) NSInteger id;
/** lat */
@property (nonatomic, copy) NSString *lat;
/** ing */
@property (nonatomic, copy) NSString *lng;
/** 教学点名称 */
@property (nonatomic, copy) NSString *pos_name;
/** 教学点类型 */
@property (nonatomic, assign) NSInteger pos_type;

@end
