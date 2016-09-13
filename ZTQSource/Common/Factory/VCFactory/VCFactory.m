//
//  VCFactory.m
//  ZTQ
//
//  Created by 杨洪 on 16/9/12.
//  Copyright © 2016年 杨洪. All rights reserved.
//

#import "VCFactory.h"

@implementation VCFactory
+(UIWindow *) createWindow{
    static UIWindow *window = nil;
    if (!window) {
        window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        window.backgroundColor = [UIColor whiteColor];
        
    }
    return window;
}
+(UIViewController *) creatViewController:(NSString *) vcName{
    Class cls = NSClassFromString(vcName);
    return cls ? [[cls alloc] init] : nil;
}

+(UIViewController *) creatViewController:(NSString *)vcName WithBgColor:(UIColor *)bgColor{
    UIViewController *vc = [self creatViewController:vcName];
    if (vc) {
        vc.view.backgroundColor = bgColor;
        
    }
    return vc;
}

@end
