
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
    NSArray *teacherModels = [GDWTeacherModel  objectArrayWithKeyValuesArray:array];
    return teacherModels;
}
/** 首页教学秀图片模型数组 */
- (NSArray *)teachPictureModels{
    NSDictionary * dic = [NSDictionary  dictionaryWithJsonFilename:@"教学秀和推荐活动" ofType:nil];
    NSArray * array = dic[@"content"][@"position_platform_album"];
    NSArray *teachPictureModels = [GDWTeachPictureModel  objectArrayWithKeyValuesArray:array];
    return teachPictureModels;
}
/** 首页推荐活动模型数组 */
- (NSArray *)eventModels{
    NSDictionary * dic = [NSDictionary  dictionaryWithJsonFilename:@"教学秀和推荐活动" ofType:nil];
    NSArray * array = dic[@"content"][@"event"];
    NSArray *eventModels = [GDWEventModel  objectArrayWithKeyValuesArray:array];
    return eventModels;
}
@end
