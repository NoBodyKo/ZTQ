//
//  ZTQBasicWeatherInfo.m
//  ZTQ
//
//  Created by 杨洪 on 16/9/12.
//  Copyright © 2016年 杨洪. All rights reserved.
//

#import "ZTQBasicWeatherInfo.h"
#import "ZTQWheatherInfoCollectionViewCell.h"
@interface ZTQBasicWeatherInfo ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong)UILabel *cityLabel;
@property (nonatomic, strong)UILabel *wheatherInfoLabel;
@property (nonatomic, strong)UILabel *tempLabel;

@property (nonatomic, strong)UILabel *humLabel;
@property (nonatomic, strong)UILabel *airQulityLabel;
@property (nonatomic, strong)UICollectionView *futurWheatherInfoView;

@end

@implementation ZTQBasicWeatherInfo

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareView];
    UIButton *testbut = [UIButton buttonWithType:UIButtonTypeCustom];
    testbut.frame = CGRectMake(150, 200, 80, 80);
    [testbut setTitle:@"test" forState:UIControlStateNormal];
    [testbut setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [testbut addTarget:self action:@selector(test:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:testbut];
//    [self.view setBackgroundColor:[UIColor orangeColor]];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
  
   

}
- (void)test:(UIButton *)sender{
    [_futurWheatherInfoView reloadData];
}
- (void)prepareView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _cityLabel = [[UILabel alloc] init];
    _cityLabel.textColor = [UIColor whiteColor];
    _cityLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_cityLabel];
    
    [_cityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(@80);
        make.height.equalTo(@40);
    }];
    
    _wheatherInfoLabel = [[UILabel alloc] init];
    _wheatherInfoLabel.textColor = [UIColor whiteColor];
    _wheatherInfoLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_wheatherInfoLabel];
    
    [_wheatherInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_cityLabel.mas_bottom).offset(2);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(@80);
        make.height.equalTo(@20);
    }];
    
    _tempLabel = [[UILabel alloc] init];
    _tempLabel.textColor = [UIColor whiteColor];
    _tempLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_tempLabel];
    
    [_tempLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_wheatherInfoLabel.mas_bottom).offset(2);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(@80);
        make.height.equalTo(@20);
    }];
    
    _airQulityLabel = [[UILabel alloc] init];
    _airQulityLabel.textColor = [UIColor whiteColor];
    _airQulityLabel.backgroundColor = [UIColor blackColor];
    _airQulityLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_airQulityLabel];
    
    [_airQulityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_centerY).offset(80);
        make.left.equalTo(self.view).offset(5);
        make.width.equalTo(@80);
        make.height.equalTo(@20);
    }];

    
    _humLabel = [[UILabel alloc] init];
    _humLabel.textColor = [UIColor whiteColor];
    _humLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_humLabel];
    
    [_humLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_airQulityLabel);
        make.left.equalTo(_airQulityLabel.mas_right).offset(2);
        make.width.equalTo(@80);
        make.height.equalTo(@20);
    }];

    
    
    UIView *headView = [[UIView alloc] init];
    
    headView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:headView];
    
    
    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_airQulityLabel.mas_bottom);
        make.left.equalTo(self.view).offset(2);
        make.width.equalTo(@60);
        make.bottom.equalTo(self.view.mas_bottom);
    }];

    //headView.transform = CGAffineTransformMakeRotation(M_PI / 2);
    NSArray *arr = @[@"时间",@"温度",@"湿度",@"风向",@"风力"];
    UIView * tempView = nil;
    for (int i = 0; i < arr.count; i++) {
        UILabel *label = [[UILabel alloc] init];
        
        label.font = [UIFont systemFontOfSize:14.0f];
        //label.backgroundColor = [UIColor grayColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor blackColor];
        label.text = arr[i];
        [headView addSubview:label];

        if (i == 0) {
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(headView);
                //make.height.equalTo(@(height));
                make.left.equalTo(headView);
//                make.centerY.equalTo(headView);
                make.width.equalTo(headView.mas_width);
            }];
        }else if (i == arr.count - 1){
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(tempView.mas_bottom);
                make.bottom.equalTo(headView);
                //make.height.equalTo(@(height));
//                make.centerY.equalTo(headView);
                make.left.equalTo(headView);
                make.height.equalTo(tempView);
                make.width.equalTo(headView.mas_width);
            }];

        }else{
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(tempView.mas_bottom);
                
                make.left.equalTo(headView);
                make.height.equalTo(tempView);
                //make.height.equalTo(@(height));
//                make.centerY.equalTo(headView);
                make.width.equalTo(headView.mas_width);
            }];
        }
        tempView = label;
    }

    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    _futurWheatherInfoView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    _futurWheatherInfoView.backgroundColor = [UIColor clearColor];
    _futurWheatherInfoView.showsVerticalScrollIndicator = NO;
    _futurWheatherInfoView.showsHorizontalScrollIndicator = NO;
    _futurWheatherInfoView.dataSource=self;
    _futurWheatherInfoView.delegate=self;
    [_futurWheatherInfoView registerClass:[ZTQWheatherInfoCollectionViewCell class] forCellWithReuseIdentifier:@"MyUICollectionViewCell"];
    [self.view addSubview:_futurWheatherInfoView];
    
    [_futurWheatherInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headView);
        make.left.equalTo(headView.mas_right);
        make.right.equalTo(self.view).offset(-2);
        make.bottom.equalTo(self.view);
    }];

}

#pragma mark UICollectionViewDataSource 回调
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 24;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * CellIdentifier = @"MyUICollectionViewCell";
    ZTQWheatherInfoCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
   
    cell.contentView.backgroundColor = [UIColor orangeColor];
    
//    for (UIView *v in cell.contentView.subviews) {
//        [v removeFromSuperview];
//    }
      //[cell.contentView addSubview:cityBut];
    [cell setData];
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout

//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(CGRectGetWidth(collectionView.frame) / 5, CGRectGetHeight(collectionView.frame));
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0f;
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0f;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
