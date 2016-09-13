//
//  ScenicSpotDao.h
//  ZTQ
//
//  Created by 杨洪 on 16/9/9.
//  Copyright © 2016年 杨洪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ScenicSpotModel.h"
@interface ScenicSpotDao : NSObject

/**
 通过城市名查找景区
 */
+ (NSArray *)findScenicSpotbyCityName:(NSString *) cityName;
/**
 通过省份名查找景区
 */
+ (NSArray *)findScenicSpotbyProName:(NSString *) proName;
/**
 通过景区名查找景区
 */
+ (NSArray *)findScenicSpotbyScenicSpotName:(NSString *) ScenicSpotName;
/**
 通过景区ID查找所在地
 */
+ (ScenicSpotModel *)findScenicSpotLocationNameByScenicSpotid:(NSString *) ScenicSpotID;

+ (ScenicSpotModel *)findByProName:(NSString *)proName;

@end
