//
//  ZTQWheatherInfoCollectionViewCell.h
//  ZTQ
//
//  Created by 杨洪 on 16/9/12.
//  Copyright © 2016年 杨洪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZTQWheatherInfoCollectionViewCell : UICollectionViewCell

- (void)setDataWith:(ZTQHourlyWeatherInfo *)model;
- (void)setData;
@end
