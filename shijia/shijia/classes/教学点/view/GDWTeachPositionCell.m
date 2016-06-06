//
//  GDWTeachPositionCell.m
//  shijia
//
//  Created by apple on 16/6/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GDWTeachPositionCell.h"
#import "GDWTeachPositionModel.h"
#import <UIImageView+WebCache.h>

@interface GDWTeachPositionCell ()

@property (weak, nonatomic) IBOutlet UIImageView *cover_imageView;
@property (weak, nonatomic) IBOutlet UILabel *pos_name_lable;

@property (weak, nonatomic) IBOutlet UILabel *address_lable;
@property (weak, nonatomic) IBOutlet UILabel *activities_lable;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewWidthCons;
@end


@implementation GDWTeachPositionCell

-(void)awakeFromNib{

    //1.设置图片的宽度约束
    self.imageViewWidthCons.constant = 70;
    //2.设置控件的属性
    self.pos_name_lable.font = [UIFont  systemFontOfSize:16];
    self.address_lable.font = [UIFont  systemFontOfSize:12];
    self.activities_lable.font = [UIFont  systemFontOfSize:13];
}


- (void)setTeachPositionModel:(GDWTeachPositionModel *)teachPositionModel{

    _teachPositionModel = teachPositionModel;
    //设置数据.
    [self.cover_imageView  sd_setImageWithURL:[NSURL URLWithString:teachPositionModel.cover] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        //NSLog(@"%@",image);//<UIImage: 0x7fc8f8f1b540>, {250, 250}
    }];
    self.pos_name_lable.text = teachPositionModel.pos_name;
    self.address_lable.text = teachPositionModel.address;
    self.activities_lable.text = teachPositionModel.activities.firstObject;
}

- (void)setFrame:(CGRect)frame{

    frame.size.height -= 5;
    [super setFrame:frame];
}

@end
