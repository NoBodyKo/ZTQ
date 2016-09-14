//
//  ZTQDailyWeatherInfo.h
//  ZTQ
//
//  Created by 杨洪 on 16/9/13.
//  Copyright © 2016年 杨洪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZTQDailyWeatherInfo : NSObject

@property (nonatomic, copy) NSString *date;

@property (nonatomic, copy) NSString *code_d;
@property (nonatomic, copy) NSString *code_n;

@property (nonatomic, copy) NSString *txt_d;
@property (nonatomic, copy) NSString *txt_n;

@property (nonatomic, copy) NSString *max;
@property (nonatomic, copy) NSString *min;

@end
