//
//  ZTQTabBar.m
//  ZTQ
//
//  Created by 杨洪 on 16/9/12.
//  Copyright © 2016年 杨洪. All rights reserved.
//

#import "ZTQTabBar.h"

@interface ZTQTabBar ()

@end

@implementation ZTQTabBar

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *vcArray = [NSMutableArray array];
    NSArray *arr = @[@"基本信息",@"日常指数",@"未来七天",@"景点天气"];
    NSArray *imagearr = @[@"0-1",@"0-2",@"0-3",@"0-4"];
    
    
    
    NSArray *viewControllerArray = @[@"ZTQBasicWeatherInfo",@"ZTQLifeInfo",@"ZTQFutureWeatherInfo",@"ZTQScenicWeatherInfo"];
    
    for (int i = 0 ; i < viewControllerArray.count; i++) {
        
        UIViewController *vc = [VCFactory creatViewController:viewControllerArray[i]];
        UIImage *image = [UIImage imageNamed:imagearr[i]];
        CGSize imageSize = CGSizeMake(40.0, 40.0);
        
        
        vc.tabBarItem = [[UITabBarItem alloc] initWithTitle:arr[i] image:image tag:200 + i];
        vc.tabBarItem.image = [image imageByScalingToSize:imageSize];
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        
        
        NSArray *subviews = nav.navigationBar.subviews;
        for (id viewObj in subviews) {
            if (isIOS10) {
                //iOS10,改变了状态栏的类为_UIBarBackground
                NSString *classStr = [NSString stringWithUTF8String:object_getClassName(viewObj)];
                if ([classStr isEqualToString:@"_UIBarBackground"]) {
                    UIImageView *imageView=(UIImageView *)viewObj;
                    imageView.hidden=YES;
                   
                }
            }else{
                //iOS9以及iOS9之前使用的是_UINavigationBarBackground
                NSString *classStr = [NSString stringWithUTF8String:object_getClassName(viewObj)];
                if ([classStr isEqualToString:@"_UINavigationBarBackground"]) {
                    UIImageView *imageView=(UIImageView *)viewObj;
                    imageView.image = [UIImage imageNamed:@"bigShadow.png"];
                    imageView.hidden=YES;
                }
            }
        }
//        [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"bigShadow.png"] forBarMetrics:UIBarMetricsCompact];
        nav.navigationBar.translucent = YES;
        nav.navigationBar.layer.masksToBounds = YES;
//        vc.navigationItem.title = vc.tabBarItem.title;
        [vcArray addObject:nav];
    }
    
    
    //    //添加手势
    //    UISwipeGestureRecognizer *rihgtSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handlSwipe:)];
    //    rihgtSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    //    [self.view addGestureRecognizer:rihgtSwipe];
    //    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handlSwipe:)];
    //    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    //    [self.view addGestureRecognizer:leftSwipe];
    
    
    
    self.viewControllers = vcArray;
    self.selectedIndex = 0;
    self.tabBar.translucent = NO;
    
    [self.view setBackgroundColor:[UIColor whiteColor]];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
