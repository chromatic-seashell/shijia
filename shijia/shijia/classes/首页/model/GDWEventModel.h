//
//  GDWEventModel.h
//  shijia
//
//  Created by apple on 16/5/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GDWEventModel : NSObject

/** 封面图片url */
@property (nonatomic, copy) NSString *cover;
/** 活动名称 */
@property (nonatomic, copy) NSString *title;
/** 活动发起者 */
@property (nonatomic, copy) NSString *speaker;

/** 活动时间 */
@property (nonatomic, copy) NSString *event_time;

/** 网页url */
@property (nonatomic, copy) NSString *url;

@end
