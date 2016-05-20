//
//  GDWEventCell.m
//  shijia
//
//  Created by apple on 16/5/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GDWEventCell.h"

#import <UIImageView+WebCache.h>

@interface GDWEventCell ()

@property (weak, nonatomic) IBOutlet UIImageView *cover_imageView;
@property (weak, nonatomic) IBOutlet UILabel *title_lable;

@property (weak, nonatomic) IBOutlet UILabel *speaker_lable;
@property (weak, nonatomic) IBOutlet UILabel *event_time_lable;

@end

@implementation GDWEventCell

//通过xib创建的控件,会调用这个方法.
- (void)awakeFromNib {
 
    //禁止系统的自动布局
    self.autoresizingMask = UIViewAutoresizingNone;
    
    //设置空间的属性.
    [self.title_lable  setFont:[UIFont   systemFontOfSize:16]];
    [self.speaker_lable  setFont:[UIFont   systemFontOfSize:14]];
    [self.event_time_lable  setFont:[UIFont   systemFontOfSize:14]];
}



//重写模型的setter方法,设置空控件内容.
- (void)setEventModel:(GDWEventModel *)eventModel{

    _eventModel = eventModel;
    //设置数据.
    NSURL *url = [NSURL   URLWithString:eventModel.cover];
    //[self.cover_imageView  sd_setImageWithURL:url];
    [self.cover_imageView  sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //图片下载完成后,会调用.
        eventModel.coverImage = image;
        
    }];
    self.title_lable.text = eventModel.title;
    self.speaker_lable.text = eventModel.speaker;
    self.event_time_lable.text = eventModel.event_time;
    
    //设置控件尺寸
    self.cover_imageView.frame = eventModel.coverImageViewFrame;
    
    [self layoutSubviews];

}


@end
