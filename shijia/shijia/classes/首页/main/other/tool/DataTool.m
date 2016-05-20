
//
//  DataTool.m
//  shijia
//
//  Created by apple on 16/5/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "DataTool.h"
#import <MJExtension.h>


@implementation DataTool

SingleImplementation(DataTool)

/** 首页钢琴教师的数据模型数组 */
- (NSArray *)teacherModels{
    NSDictionary * dic = [NSDictionary  dictionaryWithJsonFilename:@"钢琴课老师信息" ofType:nil];
    NSArray * array = dic[@"content"][@"data"];
    NSArray *teacherModels = [GDWTeacherModel  mj_objectArrayWithKeyValuesArray:array];
    return teacherModels;
}
/** 首页教学秀图片模型数组 */
- (NSArray *)teachPictureModels{
    NSDictionary * dic = [NSDictionary  dictionaryWithJsonFilename:@"教学秀和推荐活动" ofType:nil];
    NSArray * array = dic[@"content"][@"position_platform_album"];
    NSArray *teachPictureModels = [GDWTeachPictureModel  mj_objectArrayWithKeyValuesArray:array];
    return teachPictureModels;
}
/** 首页推荐活动模型数组 */
- (NSArray *)eventModels{
    NSDictionary * dic = [NSDictionary  dictionaryWithJsonFilename:@"教学秀和推荐活动" ofType:nil];
    NSArray * array = dic[@"content"][@"event"];
    NSArray *eventModels = [GDWEventModel  mj_objectArrayWithKeyValuesArray:array];
    return eventModels;
}
/** 首页图片轮播器数据 */
- (NSArray *)circlePictureModels{
    NSDictionary * dic = [NSDictionary  dictionaryWithJsonFilename:@"图片轮播器" ofType:nil];
    NSArray * array = dic[@"content"][@"cyc"];
    NSArray *cycPictureModels = [GDWCycPictureModel  mj_objectArrayWithKeyValuesArray:array];
    return cycPictureModels;
}


@end
