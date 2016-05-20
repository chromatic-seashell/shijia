//
//  GDWTeachPictureCell.h
//  shijia
//
//  Created by apple on 16/5/12.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GDWTeachPictureModel.h"

@interface GDWTeachPictureCell : UITableViewCell

///**  教学图片模型 */
//@property (nonatomic, strong) GDWTeachPictureModel *teachPictureModel;
/** 教学图片数组 */
@property (nonatomic, strong) NSArray *teachPictureModels;

@end
