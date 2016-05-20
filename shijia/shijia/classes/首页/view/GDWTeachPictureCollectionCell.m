
//
//  GDWTeachPictureCollectionCell.m
//  shijia
//
//  Created by apple on 16/5/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GDWTeachPictureCollectionCell.h"
#import <UIImageView+WebCache.h>

@interface GDWTeachPictureCollectionCell   ()

@property (nonatomic, weak) UIImageView *imageView;

@end


@implementation GDWTeachPictureCollectionCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //GDWLogFuc
        [self  setUp];
    }
    return self;
}
- (void)setUp{

    //1.设置背景颜色
    self.backgroundColor = [UIColor lightGrayColor];

    //2.添加子控件
    UIImageView *imageV = [[UIImageView alloc] init];
    _imageView = imageV;
    
    [self.contentView addSubview:imageV];

}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.frame = self.bounds;
}

#pragma mark - 

- (void)setTeachPictureModel:(GDWTeachPictureModel *)teachPictureModel{

    _teachPictureModel = teachPictureModel;
    
    //给imageView设置图片.
    NSURL *url = [NSURL URLWithString:teachPictureModel.cover];
    [self.imageView sd_setImageWithURL:url];

}



@end
