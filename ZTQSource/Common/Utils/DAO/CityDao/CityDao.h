//
//  CityDao.h
//  ZTQ
//
//  Created by 杨洪 on 16/9/9.
//  Copyright © 2016年 杨洪. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CityModel;
@interface CityDao : NSObject
/**
 通过城市ID查找
 */
+ (CityModel *) findByCityId:(NSString *) cityId;
/**
 通过城市名查找
 */
+ (NSArray *) findByCityName:(NSString *) cityName;
/**
 通过省份查找城市
 */
+ (NSArray *) findAllByProName:(NSString *) proNameStr;
/**
 通过省份和城市查找ID
 */
+ (NSString *) findCityIdByCityName:(NSString *)cityName andProName:(NSString *)proName;

/**
 获得全部城市信息
 */
+ (NSArray *) getAllCity;

+ (NSArray *) getAllCityKeys;

@end
