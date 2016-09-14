//
//  ZTQCustomLabel.m
//  ZTQ
//
//  Created by 杨洪 on 16/9/14.
//  Copyright © 2016年 杨洪. All rights reserved.
//

#import "ZTQCustomLabel.h"

@implementation ZTQCustomLabel


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.font = [UIFont systemFontOfSize:12];
        self.adjustsFontSizeToFitWidth = YES;
        self.textAlignment = NSTextAlignmentCenter;
        self.textColor = [UIColor whiteColor];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
