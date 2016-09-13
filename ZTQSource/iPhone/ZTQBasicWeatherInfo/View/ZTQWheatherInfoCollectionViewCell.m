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
    UILabel *myDateLabel;
    UILabel *myTmpLabel;
    UILabel *myHumLabel;
    UILabel *myWindDirLabel;
    UILabel *myWindScLabel;
    
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
    myDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) / 5)];
    myDateLabel.textColor = [UIColor whiteColor];
    
    myTmpLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(myDateLabel.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) / 5)];
    myTmpLabel.textColor = [UIColor whiteColor];
    
    myHumLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(myTmpLabel.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) / 5)];
    myHumLabel.textColor = [UIColor whiteColor];
    myWindDirLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(myHumLabel.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) / 5)];
    myWindDirLabel.textColor = [UIColor whiteColor];
    myWindScLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(myWindDirLabel.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) / 5)];
    myWindScLabel.textColor = [UIColor whiteColor];
    [cellView addSubview:myDateLabel];
    [cellView addSubview:myTmpLabel];
    [cellView addSubview:myHumLabel];
    [cellView addSubview:myWindDirLabel];
    [cellView addSubview:myWindScLabel];
    
    
    cellView.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:cellView];
}

- (void)setData{
    myDateLabel.text = @"test";
    myHumLabel.text = @"test";
    myTmpLabel.text = @"test";
    myWindScLabel.text = @"test";
    myWindDirLabel.text = @"test";
}

@end
