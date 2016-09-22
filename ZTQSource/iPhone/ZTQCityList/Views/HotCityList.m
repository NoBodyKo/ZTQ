//
//  HotCityList.m
//  ZTQ
//
//  Created by 杨洪 on 16/9/21.
//  Copyright © 2016年 杨洪. All rights reserved.
//

#import "HotCityList.h"

@implementation HotCityList

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.frame = CGRectMake(0, 0, WIDTH - 15, self.frame.size.height);
        self.contentView.frame = self.frame;
        
        
    }
    return self;
}

- (void)setData:(NSArray *)dataArray withCol:(int)col{
    if (col > 5) {
        col = 5;
    }
    int total = (int) dataArray.count;
    int row = total % col ? (total / col + 1) :  total / col;
    float h = 30.0;
    
    for (int i = 0; i < row; i++) {
        for (int j = 0; j < col; j++) {
            if (i * col + j < dataArray.count) {
                CityModel *model = dataArray[i * col + j];
                UIButton *cityButton = [UIButton buttonWithType:UIButtonTypeCustom];
                cityButton.frame = CGRectMake(10 + j * ((self.contentView.frame.size.width - (col + 1 ) * 10) / col + 10), 10 + i * (h + 10), (self.contentView.frame.size.width - (col + 1 ) * 10) / col, h);
                cityButton.tag = 200 + i * col + j;
                [cityButton setTitle:model.proName forState:UIControlStateNormal];
                [cityButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                cityButton.backgroundColor = [UIColor redColor];
                [cityButton addTarget:self action:@selector(proButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
                [self.contentView addSubview:cityButton];
               
            }
        }
    }

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
