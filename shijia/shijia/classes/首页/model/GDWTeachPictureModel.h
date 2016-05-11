//
//  GDWTeachPictureModel.h
//  shijia
//
//  Created by apple on 16/5/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GDWTeachPictureModel : NSObject


/** 图片类型 */
@property (nonatomic, assign) NSInteger album_type;
/** 封面url */
@property (nonatomic, copy) NSString *cover;
/** 教学点名字 */
@property (nonatomic, copy) NSString *pos_name;
/** 地点id */
@property (nonatomic, assign) NSInteger position_id;

@end
