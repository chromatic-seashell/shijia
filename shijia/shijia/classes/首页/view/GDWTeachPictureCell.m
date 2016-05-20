//
//  GDWTeachPictureCell.m
//  shijia
//
//  Created by apple on 16/5/12.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GDWTeachPictureCell.h"
#import "GDWTeachPictureCollectionCell.h"


@interface GDWTeachPictureCell ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;


@end


@implementation GDWTeachPictureCell


static  NSString * const  teachPictureCollectionCell = @"teachPictureCollectionCell";

- (void)awakeFromNib {
    
    //self.collectionView.backgroundColor = [UIColor  redColor];
    //1.注册cell
    [self.collectionView  registerClass:[GDWTeachPictureCollectionCell  class] forCellWithReuseIdentifier:teachPictureCollectionCell];
    
    //2.给collectionView设置数据源和代理
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.bounces = NO;
    self.collectionView.scrollEnabled = NO;
    
    //3.设置item尺寸
    UICollectionViewFlowLayout *layout =(UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    layout.itemSize = [self  calculateItemSize];
    
}

- (void)layoutSubviews{

    [super  layoutSubviews];
     self.height = [self  calculateCollectionViewHight];
    
}

- (CGSize)calculateItemSize{

    CGFloat border = GDWItemBorder;
    CGFloat width = GDWScreenW;
    CGFloat itemW = (width - border*3)/4;
    CGFloat itemH = itemW;
    return  CGSizeMake(itemW, itemH);
}
- (CGFloat)calculateCollectionViewHight{
    return [self  calculateItemSize].width*3 + 2*GDWItemBorder;
}

#pragma mark - 重写set方法
- (void)setTeachPictureModels:(NSArray *)teachPictureModels{

    _teachPictureModels = teachPictureModels;
    

}

#pragma mark -
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.teachPictureModels.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //1.获取cell
    GDWTeachPictureCollectionCell *cell = [collectionView  dequeueReusableCellWithReuseIdentifier:teachPictureCollectionCell forIndexPath:indexPath];
    //2.给cell设置模型
    GDWTeachPictureModel *teachPictureModel = self.teachPictureModels[indexPath.item];
    cell.teachPictureModel = teachPictureModel;
    return cell;

}

@end
