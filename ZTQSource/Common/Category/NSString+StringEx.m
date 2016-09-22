//
//  NSString+StringEx.m
//  ZTQ
//
//  Created by 杨洪 on 16/9/9.
//  Copyright © 2016年 杨洪. All rights reserved.
//

#import "NSString+StringEx.h"

@implementation NSString (StringEx)

+ (BOOL)StringIsNull:(NSString *) str{
    
    if(str == nil || [str isEqualToString: @"<null>"] || [str isEqualToString: @""] || [str isEqualToString: @"null"] || [str isEqualToString: @"NULL"] || [str isEqualToString: @"(NULL)"] || [str isEqualToString: @"(null)"] ){
        return YES;
    }else{
        return NO;
    }
}

- (NSArray *)getSubStrBySeparatedStr:(NSString *)separatedString{
    return  [self componentsSeparatedByString:separatedString];
}
@end
