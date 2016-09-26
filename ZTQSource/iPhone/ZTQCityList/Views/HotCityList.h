//
//  HotCityList.h
//  ZTQ
//
//  Created by 杨洪 on 16/9/21.
//  Copyright © 2016年 杨洪. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^hotCityBlock)(CityModel *);
@interface HotCityList : UITableViewCell
@property (nonatomic, copy) hotCityBlock block;
- (void)setData:(NSArray *)dataArray withCol:(int)col;

@end
