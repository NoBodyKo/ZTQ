//
//  ProvinceDao.m
//  ZTQ
//
//  Created by 杨洪 on 16/9/9.
//  Copyright © 2016年 杨洪. All rights reserved.
//

#import "ProvinceDao.h"
#import "ProvinceModel.h"
@implementation ProvinceDao

+(NSArray *) findAll{
    FMDatabase *db = [MyDbUtil createDBWithFilename:@"province.db"];
    [db open];
    NSMutableArray *mArray = [NSMutableArray array];
    
    FMResultSet *rs = [db executeQuery:@"select *from tb_province order by keys asc"];
    while ([rs next]) {
        ProvinceModel *pro = [[ProvinceModel alloc] init];
        pro.proID = [rs intForColumn:@"proID"];
        pro.proName = [rs stringForColumn:@"proName"];
        pro.keys = [rs stringForColumn:@"keys"];
        [db close];
        [mArray addObject:pro];
    }
    
    return [mArray copy];
}

+(NSString *)findByProName:(NSString *)proname{
    FMDatabase *db = [MyDbUtil createDBWithFilename:@"province.db"];
    [db open];
    FMResultSet *rs = [db executeQuery:@"select *from tb_province where proName=? order by keys asc",proname];
    [db close];
    return [rs stringForColumn:@"proName"];
}


@end
