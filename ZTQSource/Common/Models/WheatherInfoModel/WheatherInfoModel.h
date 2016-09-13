//
//  WheatherInfoModel.h
//  ZTQ
//
//  Created by 杨洪 on 16/9/13.
//  Copyright © 2016年 杨洪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WheatherInfoModel : NSObject
/**
 * @brief 数组属性.
 *
 * 天气告警信息
 */
@property (nonatomic, strong) NSArray *alarms;

/**
 * @brief 字典属性.
 *
 * 空气质量信息
 */
@property (nonatomic, strong) NSDictionary *aqi;

/**
 * @brief 字典属性.
 *
 * 城市基本信息
 */
@property (nonatomic, strong) NSDictionary *basic;

/**
 * @brief 数组属性.
 *
 * 未来几天天气信息
 */
@property (nonatomic, strong) NSArray *daily_forecast;

/**
 * @brief 数组属性.
 *
 * 未来24小时天气信息
 */
@property (nonatomic, strong) NSArray *hourly_forecast;

/**
 * @brief 字典属性.
 *
 * 当前天气信息
 */
@property (nonatomic, strong) NSDictionary *now;

/**
 * @brief 字符串属性.
 *
 * 是否成功标志
 */

@property (nonatomic, copy) NSString *status;

/**
 * @brief 字典属性.
 *
 * 日常指数信息
 */
@property (nonatomic, strong) NSDictionary *suggestion;
@end
