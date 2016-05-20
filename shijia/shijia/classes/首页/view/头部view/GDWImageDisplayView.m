//
//  GDWImageDisplayView.m
//  UIScrollView-循环展示图片
//
//  Created by apple on 15/8/28.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "GDWImageDisplayView.h"

#define scrollWidthScale  0

@interface GDWImageDisplayView ()<UIScrollViewDelegate>

@property (nonatomic,weak)  UIImageView * leftImageView;
@property (nonatomic,weak)  UIImageView * centerImageView;
@property (nonatomic,weak)  UIImageView * rightImageView;

@property (nonatomic,weak)  UIScrollView *scrollView;
@property (nonatomic,assign) NSInteger  imageTotalNumber;


/* 页码控制器 */
@property (nonatomic,weak) UIPageControl *pageControl;

/* 定时器 */
@property (nonatomic,weak) NSTimer *timer;


@end


@implementation GDWImageDisplayView

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
    _scrollView.showsHorizontalScrollIndicator=NO;
    _scrollView.pagingEnabled=NO;
    scrollView.delegate=self;
    [self  addSubview:scrollView];
    
    //2.添加imageView
    //左边image
    UIImageView *imageView0=[[UIImageView alloc] init];
    _leftImageView=imageView0;
    //中间image
     UIImageView *imageView=[[UIImageView alloc] init];
    _centerImageView=imageView;
    //右边image
    UIImageView *imageView1=[[UIImageView alloc] init];
    _rightImageView=imageView1;
    
    [_scrollView  addSubview:_leftImageView];
    [_scrollView addSubview:_centerImageView];
    [_scrollView addSubview:_rightImageView];
    
    //3添加页码控制器.
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    [self addSubview:pageControl];
    _pageControl = pageControl;
    
    
    //4.创建定时器
    NSTimer *timer = [NSTimer  scheduledTimerWithTimeInterval:3 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
    [[NSRunLoop  currentRunLoop]  addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
  

}
/** timer懒加载 */
- (NSTimer *)timer{
    if (!_timer) {
        NSTimer *timer = [NSTimer   timerWithTimeInterval:3 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
        [[NSRunLoop  currentRunLoop]  addTimer:timer forMode:NSRunLoopCommonModes];
        _timer = timer;
    }
    return _timer;
}

#pragma mark 定时器监听的方法.
- (void)timeChange{

    //使scrowView的ContentOffset偏移量增加一个scrowView的宽度.
    CGPoint currentContentSize = self.scrollView.contentOffset;
    CGFloat width = self.scrollView.frame.size.width;
   
    currentContentSize.x +=  width ;
    CGPoint offsetPoint= currentContentSize;
    
    [ _scrollView  setContentOffset:offsetPoint animated:YES];

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
    _scrollView.frame=CGRectMake(scrollWidthScale*W, 0, (1-scrollWidthScale)*W, H);
    _scrollView.contentSize=CGSizeMake(4*W, 0);
    
    CGFloat width=_scrollView.frame.size.width;
    CGFloat hight=_scrollView.frame.size.height;
    
   
    _leftImageView.frame=CGRectMake(-width, 0, width, hight);
    _leftImageView.image=self.images[_imageTotalNumber-1];
    
    
    _centerImageView.frame=CGRectMake(0, 0, width, hight);
    _centerImageView.image=self.images[0];
    
    _rightImageView.frame=CGRectMake(width, 0, width, hight);
    _rightImageView.image=self.images[1];
    
    
    //2.布局pageControl
    CGFloat pageW = 80;
    CGFloat pageH = 20;
    CGFloat pageX = W - pageW;
    CGFloat pageY = H - pageH;
    self.pageControl.frame = CGRectMake(pageX*0.5, pageY, pageW, pageH);
    

}

- (void)setImages:(NSArray *)images
{
    _images=images;
    _imageTotalNumber=images.count;
    
    //设置pageControl属性
    self.pageControl.numberOfPages = _imageTotalNumber;
    self.pageControl.currentPage = 0;
    self.pageControl.currentPageIndicatorTintColor = [UIColor lightGrayColor];
    self.pageControl.pageIndicatorTintColor = [UIColor  whiteColor];
    
    [self  layoutIfNeeded];
}



#pragma mark  scrollView的代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    static int n=1;
    NSInteger index;
    static NSInteger  currentPageNumber=0;
    //临时的UIImageView指针变量
    static UIImageView *temp1;
    static UIImageView *temp2;
    
    CGFloat width=_scrollView.frame.size.width;
    CGSize size =_scrollView.contentSize;
    //确定当前页码数.
    CGFloat offsetX=_scrollView.contentOffset.x;
    CGFloat scale=offsetX/width;
    if (scale>=0) {
        scale +=0.5;
    }else{
        scale -=0.5;
    }
    index=(int)scale%_imageTotalNumber;
    //中间的imageView中间点的x轴坐标.
    CGFloat centerImageX=_centerImageView.frame.origin.x+width*.5;
    
    //向左滑动,切换图片是时.
    if (offsetX>centerImageX) {
        //循环利用
        temp1=_centerImageView;
        temp2=_rightImageView;
        _rightImageView=_leftImageView;
        _centerImageView=temp2;
        _leftImageView=temp1;
        
        CGRect frame=_rightImageView.frame;
        frame.origin.x +=3*width;
        _rightImageView.frame=frame;
        size.width +=width;
        _scrollView.contentSize=size;
        
        //切换图片
        [self  changeImagesForImageViewsInScrollViewWithIndex:index isLeftDragging:true currentPageNumberRef:&currentPageNumber];
        //设置pageControl的页码
        self.pageControl.currentPage = currentPageNumber;
    }
    //向右滑动,切换图片时.
    if(offsetX<centerImageX-width)
    {
        //循环利用
        temp1=_leftImageView;
        temp2=_centerImageView;
         _leftImageView=_rightImageView;
        _centerImageView=temp1;
        _rightImageView=temp2;
        
        CGRect frame=_leftImageView.frame;
        frame.origin.x -=3*width;
        _leftImageView.frame=frame;
        
        //保证scrowView的contentSize的最小宽度
        if (size.width >= 4*width) {
            size.width -=width;
        }
        _scrollView.contentSize=size;
        n++;
        //切换图片.
        [self  changeImagesForImageViewsInScrollViewWithIndex:index isLeftDragging:false currentPageNumberRef:&currentPageNumber];
        //设置pageControl的页码
        self.pageControl.currentPage = currentPageNumber;
    }
    
    //当向右滑动时,根据n值的变化,增加向右滑动的区域.
    _scrollView.contentInset=UIEdgeInsetsMake(0, n*width, 0, 0);
    
    //转场动画要和界面切换的代码放在一起.
   /*
    CATransition  *transitionAnim=[CATransition   animation];
    transitionAnim.type=@"rippleEffect";
    transitionAnim.duration=1;
    [_scrollView.layer   addAnimation:transitionAnim forKey:nil];
    */
    
}
#pragma mark 改变scrollView中imageView的图片.
- (void)changeImagesForImageViewsInScrollViewWithIndex:(NSInteger)index  isLeftDragging:(BOOL)isLeftDragging currentPageNumberRef:(NSInteger *)currentPageNumber{

    if (isLeftDragging) {//左滑动
        if (index>=0)
        {
            _centerImageView.image=_images[index];
            if (index==_imageTotalNumber-1) {
                _rightImageView.image=_images[0];
            }else{
                _rightImageView.image=_images[index+1];
            }
            if (index==0) {
                _leftImageView.image=_images[_imageTotalNumber-1];
            }else{
                _leftImageView.image=_images[index-1];
            }
            
            *currentPageNumber=index;
        }else{
            
            NSInteger temp=_imageTotalNumber+index;
            _centerImageView.image=_images[temp];
            if (temp==_imageTotalNumber-1) {
                _rightImageView.image=_images[0];
            }else{
                _rightImageView.image=_images[temp+1];
            }
            if (temp==0) {
                _leftImageView.image=_images[_imageTotalNumber-1];
            }else{
                _leftImageView.image=_images[temp-1];
            }
            *currentPageNumber=temp;
        }
    }else{//向右滑动
    
        if (index>=0) {
            _centerImageView.image=_images[index];
            
            if (index==_imageTotalNumber-1) {
                _rightImageView.image=_images[0];
            }else{
                _rightImageView.image=_images[index+1];
            }
            if (index==0) {
                _leftImageView.image=_images[_imageTotalNumber-1];
            }else{
                _leftImageView.image=_images[index-1];
            }
            
            *currentPageNumber=index;
        }else{
            NSInteger tempIndex=_imageTotalNumber-labs(index);
            _centerImageView.image=_images[tempIndex];
            
            if (tempIndex==_imageTotalNumber-1) {
                _rightImageView.image=_images[0];
            }else{
                _rightImageView.image=_images[tempIndex+1];
            }
            if (tempIndex==0) {//
                _leftImageView.image=_images[_imageTotalNumber-1];
            }else{
                _leftImageView.image=_images[tempIndex-1];
            }
            
            *currentPageNumber=tempIndex;
        }
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.timer   setFireDate:[NSDate  distantFuture]];
    
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //1.调整ScrollView的contentOffset
    [self  adjustScrollViewContentSize];
    //2.当没惯性时开启定时器.
    if (decelerate == false) {//没有惯性
        
        [self.timer  setFireDate:[NSDate  dateWithTimeIntervalSinceNow:1]];
   }
    
}
/** 当scrollView惯性为0时,条用该方法 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //1.调整ScrollView的contentOffset
    [self  adjustScrollViewContentSize];
    //2.开启定时器.
    [self.timer  setFireDate:[NSDate  dateWithTimeIntervalSinceNow:1]];
}

/*
  调整ScrollView的contentOffset,使scrollView显示完整一页内容.
 */
- (void)adjustScrollViewContentSize{

    CGPoint currentContentSize = self.scrollView.contentOffset;
    CGFloat width = self.scrollView.frame.size.width;
    
    int M = (int )currentContentSize.x/width;
    int N = (int)((currentContentSize.x/width) +0.5);
    if (M == N) {
        currentContentSize.x =  width * M;
    }else{
        currentContentSize.x =  width * N;
    }
    CGPoint offsetPoint= currentContentSize;
    [ _scrollView  setContentOffset:offsetPoint animated:YES];
}

@end
