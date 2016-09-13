//
//  MyRequest.h
//  ZTQ
//
//  Created by 杨洪 on 16/9/8.
//  Copyright © 2016年 杨洪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyRequest : NSObject

//+ (void)getDataByAddress:(NSString *)addressName requestSucess:(void (^)(id result))successBlock failer:(void (^)(id failer)) failBlock;

+ (void)getDataByAddress:(NSString *)addressName parmas:(id)parmas requestSucess:(void (^)(id result))successBlock failer:(void (^)(id failer)) failBlock;

@end
