//
//  MyDbUtil.h
//  ZTQ
//
//  Created by 杨洪 on 16/9/9.
//  Copyright © 2016年 杨洪. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface MyDbUtil : NSObject

/*!
 @method 根据指定文件名创建数据库连接
 @param filename 数据库文件名
 @return 指向数据库的FMDatabase指针
 */
+(FMDatabase *) createDBWithFilename:(NSString *) filename;

/*!
 @method 关闭数据库
 @param db 指向数据库的FMDatabase指针
 */
+(void) closeDB:(FMDatabase *) db;

@end
