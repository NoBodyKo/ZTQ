//
//  AppDelegate.m
//  ZTQ
//
//  Created by 杨洪 on 16/8/9.
//  Copyright © 2016年 杨洪. All rights reserved.
//

#import "AppDelegate.h"
#import "ZTQTabBar.h"
#define LocationTimeout 18
#define ReGeocodeTimeout 18
@interface AppDelegate () <AMapLocationManagerDelegate>{
    
    AMapLocationManager*LocationManager;
}


@end

@implementation AppDelegate

//判断apiKey是否可用
- (void)configureAPIKey
{
    if ([MapAPIKey length] == 0)
    {
        NSString *reason = [NSString stringWithFormat:@"apiKey为空，请检查key是否正确设置。"];
        [UIAlertController showAlsert:reason withVC:self.window.rootViewController okAction:^{
            
        }];
    }
    
    [AMapServices sharedServices].apiKey = (NSString *)MapAPIKey;
    
}

//创建定位
- (void)createLocationManager{
    LocationManager = [AMapLocationManager new];
    [LocationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    LocationManager.delegate = self;
    [LocationManager setLocationTimeout:LocationTimeout];
    [LocationManager setReGeocodeTimeout:ReGeocodeTimeout];
    
}

//开始定位
- (void)locationStart{
    //[LocationManager startUpdatingLocation];
    _isGetLocatNow = YES;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.window animated:YES];
    hud.label.text = @"正在定位";
    hud.removeFromSuperViewOnHide = YES;
    [LocationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        
        if (error)
        {
            DLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            
        }
        
        DLog(@"location:%@", location);
        DLog(@"regeocode:%@",regeocode.description);
        if (regeocode)
        {
            [MBProgressHUD hideHUDForView:self.window animated:YES];
            _isGetLocatNow = NO;
            if ([NSString StringIsNull:[CityInfo shareUserInfo].cityName]) {
                [CityInfo shareUserInfo].cityProvince = [regeocode.province substringToIndex:regeocode.province.length -  1];
                [CityInfo shareUserInfo].cityCountry = regeocode.country;
                [CityInfo shareUserInfo].cityDistrict = regeocode.district;
                [CityInfo shareUserInfo].cityStreet = regeocode.street;
                BOOL isMDcity = [NSString StringIsNull:regeocode.city];
                if (isMDcity) {
                    [CityInfo shareUserInfo].cityName = [regeocode.province substringToIndex:regeocode.province.length -  1];
                    //NSLog(@"%@",[CityInfo shareUserInfo].cityName);
                }else{
                    [CityInfo shareUserInfo].cityName = [regeocode.city substringToIndex:regeocode.province.length -  1];
                    
                }
                [_delegate didSUccessLocation];
                
            }else{
                BOOL isMDcity = [NSString StringIsNull:regeocode.city];
                NSString *Currentcity;
                if (isMDcity) {
                    Currentcity = [regeocode.province substringToIndex:regeocode.province.length -  1];
                    //NSLog(@"%@",[CityInfo shareUserInfo].cityName);
                }else{
                    Currentcity = [regeocode.city substringToIndex:regeocode.province.length -  1];
                    
                }
                if ([Currentcity isEqualToString:[CityInfo shareUserInfo].cityName ]) {
                    [_delegate didSUccessLocation];
                }else{
                    [UIAlertController showAlsert:@"当前所选城市与定位城市不一致，是否切换？" withTitle:@"提示" withVC:self.window.rootViewController cancelAction:^{
                        [_delegate didSUccessLocation];
                    } okAction:^{
                        [CityInfo shareUserInfo].cityProvince = [regeocode.province substringToIndex:regeocode.province.length -  1];
                        [CityInfo shareUserInfo].cityCountry = regeocode.country;
                        [CityInfo shareUserInfo].cityDistrict = regeocode.district;
                        [CityInfo shareUserInfo].cityStreet = regeocode.street;
                        [CityInfo shareUserInfo].cityName = Currentcity;
                        [_delegate didSUccessLocation];
                    }];
                }
                
                
            }
            //[CityInfo shareUserInfo].cityID = [NSString stringWithFormat:@"CN%@%@",regeocode.citycode,regeocode.adcode];
            //NSLog(@"reGeocode:%@", regeocode);
            
        }else{
             [MBProgressHUD hideHUDForView:self.window animated:YES];
            _isGetLocatNow = NO;
            [_delegate didFailedLocation];
        }
        
    }];
}
//基本配置
- (void)initForApp{
    NSFileManager *fm = [NSFileManager defaultManager];
    
    
    
    //1. 通过 NSFileManager 对象 fm 来判断文件是否存在，存在 返回YES  不存在返回NO
    
   
    
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    //取得第一个Documents文件夹的路径
    
    NSString *filePath = [path objectAtIndex:0];
    
    
    
    NSString *plistPath = [filePath stringByAppendingPathComponent:@"weatherInfo.plist"];
//    DLog(@"%@",plistPath);
     BOOL isExist = [fm fileExistsAtPath:plistPath];
    if (!isExist) {
        [[NSUserDefaults standardUserDefaults] setObject:plistPath forKey:@"weatherInfoPath"];
        
        //开始创建文件
        
        [fm createFileAtPath:plistPath contents:nil attributes:nil];

    }
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Override point for customization after application launch.
    [self configureAPIKey];
    [self createLocationManager];
    [self initForApp];
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [_window makeKeyAndVisible];
    
    ZTQTabBar *rootTabBar = [ZTQTabBar new];
    _window.rootViewController = rootTabBar;
     [self locationStart];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void) amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error{
   
    [_delegate didFailedLocation];
    [manager stopUpdatingLocation];
    
}

- (void) amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location{
    //CLLocation *currentLocation = location;
    [LocationManager stopUpdatingLocation];
    CLLocationCoordinate2D coor = location.coordinate;
    //   NSLog(@"%lf--------%lf",coor.latitude,coor.longitude);
    
    [self getAddressByLatitude:coor.latitude longitude:coor.longitude];
    

}

-(void)getAddressByLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude{
    //反地理编码
    
    [_delegate getLatitude:latitude withLongitude:longitude];
    
}
@end
