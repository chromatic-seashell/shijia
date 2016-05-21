//
//  GDWButtonView.h
//  按钮列表View
//
//  Created by apple on 16/5/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GDWButtonView : UIView


/** 数据数组 */
@property (nonatomic, strong) NSArray *dataArray;

/** 列数 */
@property (nonatomic, assign) NSInteger colNumber;
/** 行数 */
@property (nonatomic, assign) NSInteger rowNumber;


@end
