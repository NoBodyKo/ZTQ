//
//  ZTQWheatherInfoCollectionViewCell.m
//  ZTQ
//
//  Created by 杨洪 on 16/9/12.
//  Copyright © 2016年 杨洪. All rights reserved.
//

#import "ZTQWheatherInfoCollectionViewCell.h"
#define MYWIDTH (WIDTH - 90) / 4
#define MYHEIGHT 300

@implementation ZTQWheatherInfoCollectionViewCell{
    ZTQCustomLabel *myDateLabel;
    ZTQCustomLabel *myTmpLabel;
    ZTQCustomLabel *myHumLabel;
    ZTQCustomLabel *myWindDirLabel;
    ZTQCustomLabel *myWindScLabel;
    
    UIView *cellView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self creatUI];
    }
    return self;
}

-(void) creatUI{
    cellView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    myDateLabel = [[ZTQCustomLabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) / 5)];
   
    
    myTmpLabel = [[ZTQCustomLabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(myDateLabel.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) / 5)];
  
    
    myHumLabel = [[ZTQCustomLabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(myTmpLabel.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) / 5)];
    
    myWindDirLabel = [[ZTQCustomLabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(myHumLabel.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) / 5)];
    myWindDirLabel.textColor = [UIColor whiteColor];
    
    
    myWindScLabel = [[ZTQCustomLabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(myWindDirLabel.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) / 5)];
    myWindScLabel.textAlignment = NSTextAlignmentCenter;
    [cellView addSubview:myDateLabel];
    [cellView addSubview:myTmpLabel];
    [cellView addSubview:myHumLabel];
    [cellView addSubview:myWindDirLabel];
    [cellView addSubview:myWindScLabel];
    
    
    cellView.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:cellView];
}

- (void)setDataWith:(ZTQHourlyWeatherInfo *)model{
 
    NSArray *array=[model.date componentsSeparatedByString:@" "];
    if (array.count > 1) {
        NSString *str = array[1];
        myDateLabel.text = str;
    }else{
        myDateLabel.text = model.date;
    }
    
    
    myTmpLabel.text = [NSString stringWithFormat:@"%@°",model.tmp];
    myHumLabel.text = [NSString stringWithFormat:@"%@%%",model.hum];
    myWindDirLabel.text = model.dir;
    myWindScLabel.text = model.sc;

}
- (void)setData{
    myDateLabel.text = @"test";
    myHumLabel.text = @"test";
    myTmpLabel.text = @"test";
    myWindScLabel.text = @"test";
    myWindDirLabel.text = @"test";
}
@end
