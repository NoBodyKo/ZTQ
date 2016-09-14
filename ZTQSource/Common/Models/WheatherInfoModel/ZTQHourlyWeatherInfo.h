//
//  ZTQHourlyWeatherInfo.h
//  ZTQ
//
//  Created by 杨洪 on 16/9/13.
//  Copyright © 2016年 杨洪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZTQHourlyWeatherInfo : NSObject

@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *hum;
@property (nonatomic, copy) NSString *tmp;
@property (nonatomic, copy) NSString *dir;
@property (nonatomic, copy) NSString *sc;


@end
