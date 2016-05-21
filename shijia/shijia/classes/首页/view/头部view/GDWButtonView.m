

//
//  GDWButtonView.m
//  按钮列表View
//
//  Created by apple on 16/5/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GDWButtonView.h"
#import "GDWButtonUpDown.h"


@interface GDWButtonView ()

@property (nonatomic,weak)  UIScrollView *scrollView;

/** 缓存添加的所有btn */
@property (nonatomic, strong) NSMutableArray *buttons;

@end




@implementation GDWButtonView
/** b懒加载 */
- (NSMutableArray *)buttons{
    if (!_buttons) {
        self.buttons = [NSMutableArray   array];
    }
    return _buttons;
}

//通过代码创建时调用
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self  setUP];
    }
    return self;
}
//通过XIB创建时调用
- (void)awakeFromNib{
    
    [self  setUP];
}


- (void)setUP
{
    
    //1.添加scrollView
    UIScrollView *scrollView=[[UIScrollView  alloc]   init];
    _scrollView=scrollView;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    [self  addSubview:scrollView];
    
    //2.给属性设置默认值,外界可以改变.(也可在控制器中拿到控件再设值)
    NSString *path = [[NSBundle  mainBundle]   pathForResource:@"subjects" ofType:@"plist"];
    NSArray *array = [NSArray   arrayWithContentsOfFile:path];
    self.dataArray = array;
    self.colNumber = 4;
    self.rowNumber = 2;
    //NSLog(@"%@",NSStringFromCGRect(self.frame));
}

/*
 layoutSubview设置控件尺寸是会布局子控件,控件尺寸没有改变时不会调用该方法.
 */
- (void)layoutSubviews
{
    [super  layoutSubviews];
    
    CGFloat  W=self.frame.size.width;
    CGFloat  H=self.frame.size.height;
    
    
    //1.布局scrollView及其子控件
    _scrollView.frame=CGRectMake(0, 0, W, H);
    
    //2.布局scrollView子控件
    NSInteger totalNumber = self.buttons.count;
    CGFloat width=W/self.colNumber;
    CGFloat height=H/self.rowNumber;
    //一页有多少btn
    NSInteger onePageButtonNumber = self.colNumber * self.rowNumber;
    //总共有多少页,用于设置scrowView的contentSize
    NSInteger totalPage = totalNumber%onePageButtonNumber == 0 ? totalNumber/onePageButtonNumber :totalNumber/onePageButtonNumber+1;
    
    for (int i= 0; i<totalNumber; i++) {
        UIButton *btn = self.buttons[i];
        //btn当前所在的页.
        NSInteger currentPage = i/onePageButtonNumber;
        CGFloat x=(i%self.colNumber)*width + currentPage*W;
        CGFloat y=((i - currentPage *onePageButtonNumber)/self.colNumber)*height;
        btn.frame = CGRectMake(x, y, width, height);
    }
    
    //3.设置scrowView的contentSize
    self.scrollView.contentSize = CGSizeMake(W*totalPage, self.frame.size.height);
    
    //NSLog(@"%@",NSStringFromCGRect(self.frame));
}

- (void)setDataArray:(NSArray *)dataArray{

    _dataArray = dataArray;
    
    //添加按钮.
    for (int i= 0; i<dataArray.count; i++) {
        //1.获取数据
        NSDictionary *dic = dataArray[i];
        NSString *title = dic[@"subject"];
        NSString *iconName = dic[@"subject_icon"];
        //2.创建控件并设值
        GDWButtonUpDown*btn = [[GDWButtonUpDown  alloc]  init];
        [btn  setTitle:title forState:UIControlStateNormal];
        [btn  setImage:[UIImage  imageNamed:iconName] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor  darkTextColor] forState:UIControlStateNormal];
        
        [self.buttons  addObject:btn];
        [self.scrollView  addSubview:btn];
        
    }
    

}



@end
