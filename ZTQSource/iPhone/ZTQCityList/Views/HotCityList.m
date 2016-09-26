//
//  HotCityList.m
//  ZTQ
//
//  Created by 杨洪 on 16/9/21.
//  Copyright © 2016年 杨洪. All rights reserved.
//

#import "HotCityList.h"
@interface HotCityList()
@property (nonatomic, strong) NSArray *hotCityArray;

@end

@implementation HotCityList

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.frame = CGRectMake(0, 0, WIDTH - 15, self.frame.size.height);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.frame = self.frame;
        self.contentView.backgroundColor = [UIColor colorWithWhite:.95 alpha:1];
        
    }
    return self;
}

- (void)setData:(NSArray *)dataArray withCol:(int)col{
    _hotCityArray = [dataArray copy];
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
                cityButton.layer.borderWidth = .5;
                cityButton.layer.borderColor = [UIColor grayColor].CGColor;
                cityButton.layer.cornerRadius = 5;
                cityButton.tag = 200 + i * col + j;
                [cityButton setTitle:model.cityName forState:UIControlStateNormal];
                [cityButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                cityButton.backgroundColor = [UIColor whiteColor];
                [cityButton addTarget:self action:@selector(cityButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
                [self.contentView addSubview:cityButton];
               
            }
        }
    }

}

- (void)cityButtonClicked:(UIButton *)sender{
    if (self.block) {
        self.block(_hotCityArray[sender.tag - 200]);
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
