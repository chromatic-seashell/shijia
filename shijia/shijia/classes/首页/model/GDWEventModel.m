//
//  GDWEventModel.m
//  shijia
//
//  Created by apple on 16/5/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GDWEventModel.h"

@interface GDWEventModel ()
/** 封面图片尺寸 */
@property (nonatomic, assign) CGSize coverImageSize;

@end


@implementation GDWEventModel

//模拟服务器直接返回图片的尺寸大小.
- (CGSize)coverImageSize{
    return CGSizeMake(640, 280);
}

- (CGFloat)cellHeight{

    if (_cellHeight) return _cellHeight;
    
    CGFloat screenWidth = [UIScreen  mainScreen].bounds.size.width;
    //图片的高度
    CGSize coverImageSize =[self  coverImageSize];
    CGFloat coverImageViewX = 0;
    CGFloat coverImageViewY = 0;
    CGFloat coverImageViewW = screenWidth;
    CGFloat coverImageViewH = screenWidth/coverImageSize.width*coverImageSize.height;
    _coverImageViewFrame = CGRectMake(coverImageViewX, coverImageViewY, coverImageViewW, coverImageViewH);
    _cellHeight += coverImageViewH;
    
    //speakerLable的高度
    CGFloat speakerLableH = [self.speaker boundingRectWithSize:CGSizeMake(screenWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]} context:nil].size.height;
    _cellHeight += speakerLableH;
    //titleLable的高度
    CGFloat titleLableH = [self.title boundingRectWithSize:CGSizeMake(screenWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
    _cellHeight += titleLableH;
    _cellHeight += 20;
    return _cellHeight;
}


@end
