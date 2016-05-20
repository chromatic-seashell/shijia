//
//  DataTool.h
//  shijia
//
//  Created by apple on 16/5/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GDWTeacherModel.h"
#import "GDWTeachPictureModel.h"
#import "GDWEventModel.h"
#import "GDWCycPictureModel.h"

@interface DataTool : NSObject

SingleInterface(DataTool)

/** 首页钢琴教师的数据模型数组 */
- (NSArray *)teacherModels;
/** 首页教学秀图片模型数组 */
- (NSArray *)teachPictureModels;
/** 首页推荐活动模型数组 */
- (NSArray *)eventModels;
/** 首页图片轮播器数据 */
- (NSArray *)circlePictureModels;




@end
