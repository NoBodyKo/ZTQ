//
//  ZTQHourlyWeatherInfo.m
//  ZTQ
//
//  Created by 杨洪 on 16/9/13.
//  Copyright © 2016年 杨洪. All rights reserved.
//

#import "ZTQHourlyWeatherInfo.h"

@implementation ZTQHourlyWeatherInfo
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    // JSON格式的数据中有一个键叫做description
    // 但是和它对应的属性名字叫desc
    // 该方法专门处理键和属性名字不对应的情况
    // 做这件事情是为了支持KVC(Key-Value Coding)
    
}

@end
