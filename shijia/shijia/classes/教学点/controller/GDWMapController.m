//
//  GDWMapController.m
//  shijia
//
//  Created by apple on 16/6/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GDWMapController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "GDWTeachPositionModel.h"
#import "GDWAnnotation.h"
#import "GDWAnnotationViewCalloutView.h"

#import <Masonry.h>

@interface GDWMapController ()<MKMapViewDelegate>

/** 地图 */
@property (nonatomic,weak)  MKMapView*mapView;
/** 大头针数组 */
@property (nonatomic, strong) NSMutableArray *annotations;
/** 位置管理者*/
@property (nonatomic, strong) CLLocationManager *locationM;

/** 地理编码*/
@property (nonatomic, strong) CLGeocoder *geoC;

@end

@implementation GDWMapController

/** 位置管理者属性的懒加载 */
-(CLLocationManager *)locationM
{
    if (!_locationM) {
        _locationM = [[CLLocationManager alloc] init];
        // 请求授权
        if(ISiOS(8.0))
        {
            [_locationM requestAlwaysAuthorization];
        }
        
    }
    return _locationM;
}
-(CLGeocoder *)geoC
{
    if (!_geoC) {
        _geoC = [[CLGeocoder alloc] init];
    }
    return _geoC;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.创建地图控件
    MKMapView *mapView = [[MKMapView  alloc]  init];
    self.mapView = mapView;
    //mapView.frame = self.view.bounds;
    [self.view  addSubview:mapView];
    //设置代理.
    self.mapView.delegate = self;
    
    /*
     给mapVeiw设置约束
     You have three choices when it comes to programmatically creating constraints:
         1.You can use layout anchors,
         2.you can use the NSLayoutConstraint class, or
         3.you can use the Visual Format Language.
     */
    //使用Masonry第三方框架布局
  
    self.mapView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.mapView  mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    
    //2. 请求用户定位授权
    [self locationM];
    
    //3. 设置mapView
    // 在地图上,显示用户位置,(通过一个发光的蓝点(大头针))
    self.mapView.showsUserLocation = YES;
    // 给地图设置区域
    [self  setUpMapViewRegion];
    
    

}
//使用VFL布局的代码
- (void)VFL:(UIView *)mapView{

    if(floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    //将自适应向布局约束的转化关掉(根据情况有时需要有时不需要)
    self.mapView.preservesSuperviewLayoutMargins = YES;
    self.mapView.translatesAutoresizingMaskIntoConstraints = NO;
    
    //创建一个存放约束的数组
    NSMutableArray * tempConstraints = [NSMutableArray array];
    
    /*
     创建水平方向的约束:在水平方向,leftButton距离父视图左侧的距离为80，leftButton宽度为60,rightButton和leftButton之间的距离为30，rightButton宽60
     */
    [tempConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[mapView]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(mapView)]];
    /*
     创建竖直方向的约束:在竖直方向上,leftButton距离父视图顶部30，leftButton高度30
     */
    [tempConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[mapView]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(mapView)]];
    //给视图添加约束
    [self.view addConstraints:tempConstraints];
}

- (void)setUpMapViewRegion{//制定一个地点设置地图的区域.

    NSString *address = @"广州市天河体育中心";
    [self.geoC  geocodeAddressString:address completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        //1.获取位置标记
        CLPlacemark *placemark = [placemarks firstObject];
    
        //2.设置区域
        MKCoordinateSpan span = MKCoordinateSpanMake(0.301766, 0.222131);
        CLLocationCoordinate2D coordinate = placemark.location.coordinate;
        MKCoordinateRegion region = MKCoordinateRegionMake(coordinate, span);
        [self.mapView setRegion:region animated:YES];
        
    }];



}



- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    //添加大头针数据模型
    [self.mapView  addAnnotations:self.annotations];


}


#pragma mark - MKMapViewDelegate
-(nullable MKAnnotationView *)mapView:(nonnull MKMapView *)mapView viewForAnnotation:(nonnull id<MKAnnotation>)annotation
{
    //1.如果大头针数据模型不是自定义的类型,返回系统的大头针.
    if (![annotation isKindOfClass:[GDWAnnotation  class]]) {
        //NSLog(@"%@",annotation);//<MKUserLocation: 0x12a176c10>
        return nil;
    }
    
    
    //2.自定义大头针视图
    static NSString *pinID = @"pinID";
    // 从缓存池 取出 大头针视图
    MKAnnotationView *view = [mapView dequeueReusableAnnotationViewWithIdentifier:pinID];
    // 如果大头针视图取出来为nil 我们就创建
    if (view == nil) {
        view = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pinID];
    }
    // 设置大头针视图可以弹框
    view.canShowCallout = YES;
    // 设置大头针图片
    view.image = [UIImage imageNamed:@"position_map_annotation_normal"];
    
    /*
     设置弹框的详情请视图
     1.利用xib自定义view,
     2.利用自定义view,自定义大头针弹出视图.
     */
    GDWAnnotation *anno = (GDWAnnotation *)annotation;
    GDWAnnotationViewCalloutView *view1 = (GDWAnnotationViewCalloutView *)[[[NSBundle  mainBundle]   loadNibNamed:@"GDWAnnotationViewCalloutView"    owner:nil options:nil]  firstObject];
    view1.annotation = anno;
    view.detailCalloutAccessoryView = view1;
    
    return view;
}

/**
 *  当地图更新到用户位置时调用
   self.mapView.userLocation.coordinate属性值,好像只能在代理方法中拿到值.
 */
//-(void)mapView:(nonnull MKMapView *)mapView didUpdateUserLocation:(nonnull MKUserLocation *)userLocation
//{
//    /**
//     *  MKUserLocation : 大头针数据模型,  只不过它遵循了大头针数据模型必须遵循的一个协议 MKAnnotation
//     */
//    
//    // 不但要显示地图中心, 还要缩放地图到合适的比例
//    // 创建一个区域跨度
//    MKCoordinateSpan span = MKCoordinateSpanMake(0.301766, 0.222131);
//    // 根据一个中心和跨度, 创建一个区域
//    MKCoordinateRegion region = MKCoordinateRegionMake(userLocation.location.coordinate, span);
//    // 设置地图区域
//    [mapView setRegion:region animated:YES];
//    
//    
//}


/**
 *  区域改变时调用
 */
//-(void)mapView:(nonnull MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
//{
//    //0.301766---0.222131
//    NSLog(@"%f---%f", mapView.region.span.latitudeDelta, mapView.region.span.longitudeDelta);
//    
//}




#pragma mark - 重写settter方法
- (void)setTeachPositionModels:(NSArray *)teachPositionModels{

    _teachPositionModels = teachPositionModels;
    //1.创建大头针数据模型
    NSMutableArray *annotations = [NSMutableArray  array];
    for (int i = 0; i<teachPositionModels.count; i++) {
        GDWTeachPositionModel *teachPositionModel = teachPositionModels[i];
        GDWAnnotation *annotation = [GDWAnnotation  annotationWith:teachPositionModel];
        [annotations  addObject:annotation];
    }
    self.annotations = annotations;
}
@end
