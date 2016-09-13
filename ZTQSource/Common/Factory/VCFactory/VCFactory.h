//
//  VCFactory.h
//  ZTQ
//
//  Created by 杨洪 on 16/9/12.
//  Copyright © 2016年 杨洪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VCFactory : NSObject

+(UIWindow *) createWindow;

+(UIViewController *) creatViewController:(NSString *) vcName;

+(UIViewController *) creatViewController:(NSString *)vcName WithBgColor:(UIColor *)bgColor;
@end
