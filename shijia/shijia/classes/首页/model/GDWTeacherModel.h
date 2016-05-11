//
//  GDWTeacherModel.h
//  shijia
//
//  Created by apple on 16/5/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GDWTeacherModel : NSObject


/** 头像 */
@property (nonatomic, copy) NSString *avatar;
/** 地区 */
@property (nonatomic, copy) NSString *def_region;
/** 名字 */
@property (nonatomic, copy) NSString *nickname;
/** 课程种类数 */
@property (nonatomic, assign) NSInteger lesson_way;
/** 真实名字 */
@property (nonatomic, copy) NSString *realname;
/** 排名 */
@property (nonatomic, assign) NSInteger rating;
/** 性别 */
@property (nonatomic, assign) NSInteger sex;//1-男,2-女
/** 课程起始价格 */
@property (nonatomic, copy) NSString *starting_price;
/** 概述 */
@property (nonatomic, copy) NSString *summary;
/** 教龄 */
@property (nonatomic, assign) NSInteger teach_age;
/** 用户号 */
@property (nonatomic, assign) NSInteger user_id;



@end
