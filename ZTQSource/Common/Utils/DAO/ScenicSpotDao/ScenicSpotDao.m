//
//  ScenicSpotDao.m
//  ZTQ
//
//  Created by 杨洪 on 16/9/9.
//  Copyright © 2016年 杨洪. All rights reserved.
//

#import "ScenicSpotDao.h"
#import "ScenicSpotModel.h"
@implementation ScenicSpotDao

+ (NSArray *)findScenicSpotbyCityName:(NSString *) cityName{
    FMDatabase *db = [MyDbUtil createDBWithFilename:@"province.db"];
    [db open];
    
    NSMutableArray *mArray = [NSMutableArray array];
    FMResultSet *rs = [db executeQuery:@"select *from tb_jingqu where jingquLocation=?",cityName];
    while ([rs next]) {
        ScenicSpotModel *model = [[ScenicSpotModel alloc] init];
        model.ScenicSpotID = [rs stringForColumn:@"jingquID"];
        model.ScenicSpotName = [rs stringForColumn:@"jingquName"];
        model.ScenicSpotLocationCity = [rs stringForColumn:@"jingquLocation"];
        model.ScenicSpotLocatProvince = [rs stringForColumn:@"jingquProName"];
        [mArray addObject:model];
    }
    [db close];
    return [mArray copy];

}

+ (NSArray *)findScenicSpotbyProName:(NSString *) proName{
    FMDatabase *db = [MyDbUtil createDBWithFilename:@"province.db"];
    [db open];
    
    NSMutableArray *mArray = [NSMutableArray array];
    FMResultSet *rs = [db executeQuery:@"select *from tb_jingqu where jingquProName=?",proName];
    while ([rs next]) {
        ScenicSpotModel *model = [[ScenicSpotModel alloc] init];
        model.ScenicSpotID = [rs stringForColumn:@"jingquID"];
        model.ScenicSpotName = [rs stringForColumn:@"jingquName"];
        model.ScenicSpotLocationCity = [rs stringForColumn:@"jingquLocation"];
        model.ScenicSpotLocatProvince = [rs stringForColumn:@"jingquProName"];
        [mArray addObject:model];
    }
    [db close];
    return [mArray copy];
}

+ (NSArray *)findScenicSpotbyScenicSpotName:(NSString *) ScenicSpotName{
    FMDatabase *db = [MyDbUtil createDBWithFilename:@"province.db"];
    [db open];
    
    NSMutableArray *mArray = [NSMutableArray array];
    FMResultSet *rs = [db executeQuery:@"select *from tb_jingqu where jingquName=?",ScenicSpotName];
    while ([rs next]) {
        ScenicSpotModel *model = [[ScenicSpotModel alloc] init];
        model.ScenicSpotID = [rs stringForColumn:@"jingquID"];
        model.ScenicSpotName = [rs stringForColumn:@"jingquName"];
        model.ScenicSpotLocationCity = [rs stringForColumn:@"jingquLocation"];
        model.ScenicSpotLocatProvince = [rs stringForColumn:@"jingquProName"];
        [mArray addObject:model];
    }
    [db close];
    return [mArray copy];

}

+ (ScenicSpotModel *)findScenicSpotLocationNameByScenicSpotid:(NSString *) ScenicSpotID{
    
    FMDatabase *db = [MyDbUtil createDBWithFilename:@"province.db"];
    [db open];

    ScenicSpotModel *model = [ScenicSpotModel new];
    FMResultSet *rs = [db executeQuery:@"select * from tb_jingqu where jingquID=?",ScenicSpotID];
    
    
    while ([rs next]) {
        
        model.ScenicSpotID = [rs stringForColumn:@"jingquID"];
        model.ScenicSpotName = [rs stringForColumn:@"jingquName"];
        model.ScenicSpotLocationCity = [rs stringForColumn:@"jingquLocation"];
        model.ScenicSpotLocatProvince = [rs stringForColumn:@"jingquProName"];

    }
    [db close];
    return model;

}

+ (ScenicSpotModel *)findByProName:(NSString *)proName{
    FMDatabase *db = [MyDbUtil createDBWithFilename:@"province.db"];
    [db open];
    
    ScenicSpotModel *model = [ScenicSpotModel new];
    FMResultSet *rs = [db executeQuery:@"select * from tb_jingqu where jingquProName=? limit 0,1",proName];
    
    
    while ([rs next]) {
        
        model.ScenicSpotID = [rs stringForColumn:@"jingquID"];
        model.ScenicSpotName = [rs stringForColumn:@"jingquName"];
        model.ScenicSpotLocationCity = [rs stringForColumn:@"jingquLocation"];
        model.ScenicSpotLocatProvince = [rs stringForColumn:@"jingquProName"];
        
    }
    [db close];
    return model;
    

}
@end
