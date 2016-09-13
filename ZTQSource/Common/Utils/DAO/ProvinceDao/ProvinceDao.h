//
//  ProvinceDao.h
//  ZTQ
//
//  Created by 杨洪 on 16/9/9.
//  Copyright © 2016年 杨洪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProvinceDao : NSObject

/**
 通过名字查找省份
 */
+(NSString *) findByProName:(NSString *)proname;
/**
 查找所有省份
 */
+(NSArray *) findAll;


@end
