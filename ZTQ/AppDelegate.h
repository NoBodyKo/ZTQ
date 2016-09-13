//
//  AppDelegate.h
//  ZTQ
//
//  Created by 杨洪 on 16/8/9.
//  Copyright © 2016年 杨洪. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AddressDelegate <NSObject>
@optional
-(void)getLatitude:(CLLocationDegrees)latitude withLongitude:(CLLocationDegrees)longitud;
-(void)didSUccessLocation;
-(void)didFailedLocation;
@end


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property(nonatomic,strong)id<AddressDelegate> delegate;
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, assign) BOOL isGetLocatNow;


@end

