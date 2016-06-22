//
//  GDWView.m
//  自定义大头针展示数据
//
//  Created by apple on 16/4/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GDWAnnotationViewCalloutView.h"
#import "GDWAnnotation.h"

@interface GDWAnnotationViewCalloutView ()

@property (weak, nonatomic) IBOutlet UILabel *subLable;

@property (weak, nonatomic) IBOutlet UIButton *priceButton;

@end


@implementation GDWAnnotationViewCalloutView


- (void)setAnnotation:(GDWAnnotation *)annotation{

    _annotation = annotation;
    self.subLable.text = [NSString  stringWithFormat:@"地址:%@",annotation.subtitle];
    [self.priceButton  setTitle:[NSString  stringWithFormat:@"%@",annotation.teachPositionModel.activities.firstObject] forState:UIControlStateNormal];


}


- (IBAction)tapCallOutView:(UITapGestureRecognizer *)sender {
    
    NSLog(@"即将进行界面跳转");
    //发送通知
    [[NSNotificationCenter  defaultCenter]  postNotificationName:@"mapviewCallOutViewClickNotification" object:nil userInfo:nil];
}

@end
