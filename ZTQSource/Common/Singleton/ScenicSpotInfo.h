//
//  ScenicSpotInfo.h
//  ZTQ
//
//  Created by 杨洪 on 16/9/9.
//  Copyright © 2016年 杨洪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScenicSpotInfo : NSObject
+(ScenicSpotInfo*)shareUserInfo;
@property (nonatomic, copy)NSString *scenicID;
@property (nonatomic, copy)NSString *scenicName;
@property (nonatomic, copy)NSString *scenicLocation;
@property (nonatomic, copy)NSString *scenicLocatPro;


@end
