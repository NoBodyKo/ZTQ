//
//  UIAlertController+CustomAlert.h
//  ZTQ
//
//  Created by 杨洪 on 16/9/9.
//  Copyright © 2016年 杨洪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (CustomAlert)
+ (void) showAlsert:(NSString *) msg withTitle:(NSString *) title withVC:(UIViewController *) vc cancelAction:(void(^)())cancelBlock okAction:(void(^)())okBlock;

+ (void) showAlsert:(NSString *) msg withVC:(UIViewController *)vc;
@end
