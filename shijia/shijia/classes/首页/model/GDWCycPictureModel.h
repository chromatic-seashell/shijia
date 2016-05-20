//
//  GDWCycPictureModel.h
//  shijia
//
//  Created by apple on 16/5/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GDWCycPictureModel : NSObject

/** id */
@property (nonatomic, assign) NSInteger id;

/** 图片 */
@property (nonatomic, copy) NSString *image;

/** pos */
@property (nonatomic, assign) NSInteger pos;

/** 标题 */
@property (nonatomic, copy) NSString *title;

/** url */
@property (nonatomic, copy) NSString *uri;

@end
