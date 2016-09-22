//
//  UIAlertController+CustomAlert.m
//  ZTQ
//
//  Created by 杨洪 on 16/9/9.
//  Copyright © 2016年 杨洪. All rights reserved.
//

#import "UIAlertController+CustomAlert.h"

@implementation UIAlertController (CustomAlert)
+ (void) showAlsert:(NSString *) msg withTitle:(NSString *) title withVC:(UIViewController *) vc cancelAction:(void(^)())cancelBlock okAction:(void(^)())okBlock{
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    ac.view.layer.cornerRadius = 10;
    //    ac.view.backgroundColor = [UIColor colorWithRed:201 green:120 blue:60 alpha:0.6];
    UIAlertAction *canCel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (cancelBlock) {
            cancelBlock();
        }
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (okBlock) {
            okBlock();
        }
    }];
    [ac addAction:okAction];
    [ac addAction:canCel];
    [vc presentViewController:ac animated:YES completion:^{
        
    }];

}

+ (void) showAlsert:(NSString *) msg withVC:(UIViewController *)vc okAction:(void(^)())okBlock{
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
    ac.view.layer.cornerRadius = 10;
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (okBlock) {
            okBlock();
        }
    }];
    [ac addAction:okAction];
    [vc presentViewController:ac animated:YES completion:nil];
}

+ (void) showAlsert:(NSString *) msg withVC:(UIViewController *)vc{
   __block UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"" message:msg preferredStyle:UIAlertControllerStyleAlert];
    ac.view.bounds = CGRectMake(0, 0, 50, 50);
    ac.view.layer.cornerRadius = 25;
    [vc presentViewController:ac animated:YES completion:^{
        [UIView animateWithDuration:2.0 animations:^{
            ac.view.alpha = 0;
        } completion:^(BOOL finished) {
            [ac dismissViewControllerAnimated:YES completion:nil];
        }];
    }];
}
@end
