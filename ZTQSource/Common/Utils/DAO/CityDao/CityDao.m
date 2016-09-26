//
//  CityDao.m
//  ZTQ
//
//  Created by 杨洪 on 16/9/9.
//  Copyright © 2016年 杨洪. All rights reserved.
//

#import "CityDao.h"
#import "CityModel.h"
@implementation CityDao

+ (CityModel *) findByCityId:(NSString *) cityId{
    FMDatabase *db = [MyDbUtil createDBWithFilename:@"province.db"];
    [db open];
    
    CityModel *city = [[CityModel alloc] init];
    FMResultSet *rs = [db executeQuery:@"select * from tb_city where cityID=?",cityId];
    while ([rs next]) {
        city.cityID = [rs stringForColumn:@"cityID"];
        city.cityName = [rs stringForColumn:@"cityName"];
        city.proName = [rs stringForColumn:@"proName"];
        city.keys = [rs stringForColumn:@"keys"];
        
    }
    [db close];
    return city;
    

}

+ (NSArray *) findByCityName:(NSString *) cityName{
    
    FMDatabase *db = [MyDbUtil createDBWithFilename:@"province.db"];
    [db open];
    NSMutableArray *mArray = [NSMutableArray array];
    FMResultSet *rs = [db executeQuery:@"select * from tb_city where cityName=?",cityName];
    while ([rs next]) {
        CityModel *city = [[CityModel alloc] init];
        city.cityID = [rs stringForColumn:@"cityID"];
        city.cityName = [rs stringForColumn:@"cityName"];
        city.proName = [rs stringForColumn:@"proName"];
        city.keys = [rs stringForColumn:@"keys"];
        [mArray addObject:city];
    }
    [db close];
    return [mArray copy];

}

+ (NSArray *) findAllByProName:(NSString *) proNameStr{
    FMDatabase *db = [MyDbUtil createDBWithFilename:@"province.db"];
    [db open];
    NSMutableArray *mArray = [NSMutableArray array];
    FMResultSet *rs = [db executeQuery:@"select * from tb_city where proName=?",proNameStr];
    while ([rs next]) {
        CityModel *city = [[CityModel alloc] init];
        city.cityID = [rs stringForColumn:@"cityID"];
        city.cityName = [rs stringForColumn:@"cityName"];
        city.proName = [rs stringForColumn:@"proName"];
        city.keys = [rs stringForColumn:@"keys"];
        [mArray addObject:city];
    }
    [db close];
    return [mArray copy];

}

+ (NSString *) findCityIdByCityName:(NSString *)cityName andProName:(NSString *)proName{
    FMDatabase *db = [MyDbUtil createDBWithFilename:@"province.db"];
    [db open];
    NSString *cityID = nil;
    NSString *sqlStr = [NSString stringWithFormat:@"select * from tb_city where cityName='%@' and proName='%@'",cityName,proName];
    // FMResultSet *rs = [db executeQuery:@"select * from tb_city where cityName=? and proName=?",cityName,proName];
    FMResultSet *rs = [db executeQuery:sqlStr];
    while ([rs next]) {
        
        cityID = [rs stringForColumn:@"cityID"];
        
    }
    [db close];
    return cityID;
    

}

+ (NSArray *) getAllCity{
    FMDatabase *db = [MyDbUtil createDBWithFilename:@"province.db"];
    NSMutableArray *mArray = [NSMutableArray array];
    [db open];
    NSString *sqlStr = [NSString stringWithFormat:@"select * from tb_city order by keys asc"];
    
    FMResultSet *rs = [db executeQuery:sqlStr];
    while ([rs next]) {
        
        CityModel *city = [[CityModel alloc] init];
        city.cityID = [rs stringForColumn:@"cityID"];
        city.cityName = [rs stringForColumn:@"cityName"];
        city.proName = [rs stringForColumn:@"proName"];
        city.keys = [rs stringForColumn:@"keys"];
        [mArray addObject:city];
        
    }
    [db close];
    return mArray;

}

+ (NSArray *) getAllCityByKeyWords:(NSString *)keyWords{
    FMDatabase *db = [MyDbUtil createDBWithFilename:@"province.db"];
    NSMutableArray *mArray = [NSMutableArray array];
    [db open];
    NSString *sqlStr = [NSString stringWithFormat:@"select * from tb_city where cityName like '%%%@%%'",keyWords];
    
    FMResultSet *rs = [db executeQuery:sqlStr];
    while ([rs next]) {
        
        CityModel *city = [[CityModel alloc] init];
        city.cityID = [rs stringForColumn:@"cityID"];
        city.cityName = [rs stringForColumn:@"cityName"];
        city.proName = [rs stringForColumn:@"proName"];
        city.keys = [rs stringForColumn:@"keys"];
        [mArray addObject:city];
        
    }
    [db close];
    return mArray;

}
@end
