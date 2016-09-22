//
//  ZTQBasicWeatherInfo.m
//  ZTQ
//
//  Created by 杨洪 on 16/9/12.
//  Copyright © 2016年 杨洪. All rights reserved.
//

#import "ZTQBasicWeatherInfo.h"
#import "ZTQWheatherInfoCollectionViewCell.h"
#import "MyCollectionViewLayout.h"
#import "ZTQCityList.h"
@interface ZTQBasicWeatherInfo ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,AddressDelegate>

@property (nonatomic, strong) UIImageView *bgImageVew;
@property (nonatomic, strong) UIButton *cityLabel;
@property (nonatomic, strong) UILabel *wheatherInfoLabel;
@property (nonatomic, strong) UILabel *tempLabel;

@property (nonatomic, strong) UILabel *humLabel;
@property (nonatomic, strong) UILabel *airQulityLabel;
@property (nonatomic, strong) UICollectionView *futurWheatherInfoView;
@property (nonatomic, strong) WheatherInfoModel *weatherInfo;


@property (nonatomic, strong) NSMutableArray *hourlyWeatherInfoArray;


@end

@implementation ZTQBasicWeatherInfo

- (void)viewDidLoad {
    [super viewDidLoad];
    ((AppDelegate*)[UIApplication sharedApplication].delegate).delegate=self;
    
    [self prepareView];
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    //取得第一个Documents文件夹的路径
    
    NSString *filePath = [path objectAtIndex:0];
    
    
    
    NSString *plistPath = [filePath stringByAppendingPathComponent:@"weatherInfo.plist"];

    NSMutableArray *historyDataArray = [NSMutableArray arrayWithContentsOfFile:plistPath];
    DLog(@"%@",plistPath);
    DLog(@"%@",historyDataArray);
    if (historyDataArray.count > 0) {
        
        for (NSDictionary *tempDict in historyDataArray) {
            _weatherInfo = [WheatherInfoModel new];
            [_weatherInfo setValuesForKeysWithDictionary:tempDict];
        }
        [self reloadDataWith:_weatherInfo];
    }

    
//    [self getData];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
  
   

}

- (void)prepareView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _bgImageVew = [[UIImageView alloc] init];
    [self.view addSubview:_bgImageVew];
    [self.view sendSubviewToBack:_bgImageVew];
    [_bgImageVew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view); 
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    _cityLabel = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cityLabel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _cityLabel.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_cityLabel addTarget:self action:@selector(changeCity:) forControlEvents:UIControlEventTouchUpInside];
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
    _tempLabel.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:_tempLabel];
    
    [_tempLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_wheatherInfoLabel.mas_bottom).offset(2);
        make.centerX.equalTo(self.view.mas_centerX).offset(10);
        make.width.equalTo(@20);
        make.height.equalTo(@150);
    }];
    
    _airQulityLabel = [[UILabel alloc] init];
    _airQulityLabel.textColor = [UIColor whiteColor];
//    _airQulityLabel.backgroundColor = [UIColor blackColor];
    _airQulityLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_airQulityLabel];
    
    [_airQulityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_centerY).offset(80);
        make.left.equalTo(self.view).offset(2);
        make.width.equalTo(@80);
        make.height.equalTo(@20);
    }];

    
//    _humLabel = [[UILabel alloc] init];
//    _humLabel.textColor = [UIColor blackColor];
//    _humLabel.textAlignment = NSTextAlignmentCenter;
//    [self.view addSubview:_humLabel];
//    
//    [_humLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_airQulityLabel);
//        make.left.equalTo(_airQulityLabel.mas_right).offset(2);
//        make.width.equalTo(@80);
//        make.height.equalTo(@20);
//    }];

    
    
    UIView *headView = [[UIView alloc] init];
    
    headView.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
    [self.view addSubview:headView];
    
    
    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_airQulityLabel.mas_bottom);
        make.left.equalTo(self.view).offset(2);
        make.width.equalTo(@40);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    

    //headView.transform = CGAffineTransformMakeRotation(M_PI / 2);
    NSArray *arr = @[@"时间",@"温度",@"湿度",@"风向",@"风力"];
    UIView * tempView = nil;
    for (int i = 0; i < arr.count; i++) {
        UILabel *label = [[UILabel alloc] init];
        
        label.font = [UIFont systemFontOfSize:14.0f];
        label.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = [UIColor whiteColor];
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
    _futurWheatherInfoView.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
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
    return _hourlyWeatherInfoArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * CellIdentifier = @"MyUICollectionViewCell";
    ZTQWheatherInfoCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
   
    cell.contentView.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
    
//    for (UIView *v in cell.contentView.subviews) {
//        [v removeFromSuperview];
//    }
      //[cell.contentView addSubview:cityBut];
    ZTQHourlyWeatherInfo * model = _hourlyWeatherInfoArray[indexPath.row];
    if (indexPath.row == 0) {
        model.date = @"现在";
    }
    [cell setDataWith:model];
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout

//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(floorf(CGRectGetWidth(collectionView.frame) / 5), CGRectGetHeight(collectionView.frame));//CGRectGetWidth(collectionView.frame) / 4
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.01f;
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.01f;
}


#pragma mark LoadData

- (void)getData{
    WEAKSELF;
    NSDictionary *dict = @{
                             @"cityid":[CityInfo shareUserInfo].cityID
                             };
    [MyRequest getDataByAddress:MYURL parmas:dict requestSucess:^(id result) {
       
        
        NSArray *tempArray;
        
        for (NSString *key in [result allKeys]) {
            tempArray = [result objectForKey:key];
            
        }
        NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        
        //取得第一个Documents文件夹的路径
        
        NSString *filePath = [path objectAtIndex:0];
        
        
        
        NSString *plistPath = [filePath stringByAppendingPathComponent:@"weatherInfo.plist"];
    
        [tempArray writeToFile:plistPath atomically:YES];
        
        for (NSDictionary *tempDict in tempArray) {
            _weatherInfo = [WheatherInfoModel new];
            [_weatherInfo setValuesForKeysWithDictionary:tempDict];
        }
        [weakSelf reloadDataWith:_weatherInfo];
//        DLog(@"%@",_weatherInfo);
        
    } failer:^(id failer) {
        DLog(@"%@",failer);
    }];
}

- (void)reloadDataWith:(WheatherInfoModel *)data{
    if (!_hourlyWeatherInfoArray) {
        _hourlyWeatherInfoArray = [NSMutableArray array];
    }
    [_hourlyWeatherInfoArray removeAllObjects];
    for (NSDictionary *tempDict in data.hourly_forecast) {
        ZTQHourlyWeatherInfo *model = [ZTQHourlyWeatherInfo new];
        [model setValuesForKeysWithDictionary:tempDict];
        [model setValuesForKeysWithDictionary:tempDict[@"wind"]];
        [_hourlyWeatherInfoArray addObject:model];
    }
    ZTQCurrentWeatherInfo *currentWeatherInfo = [ZTQCurrentWeatherInfo new];
    [currentWeatherInfo setValuesForKeysWithDictionary:data.now];
    [currentWeatherInfo setValuesForKeysWithDictionary:data.now[@"cond"]];
    [currentWeatherInfo setValuesForKeysWithDictionary:data.now[@"wind"]];
    
    ZTQAqiModel *aqiInfo = [ZTQAqiModel new];
    [aqiInfo setValuesForKeysWithDictionary:data.aqi[@"city"]];
    [_cityLabel setTitle:[CityInfo shareUserInfo].cityName forState:UIControlStateNormal];
    CGSize cityLabelNewSize = [_cityLabel.titleLabel setLabelWidth: [CityInfo shareUserInfo].cityName andLabFont:32.0 andMaxWidth:300 andMaxHeight:60];
    [_cityLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(cityLabelNewSize.height));
        make.width.equalTo(@(cityLabelNewSize.width));
        
    }];
    CGSize  weatherInfoLabelNewSize = [_wheatherInfoLabel setLabelWidth:currentWeatherInfo.txt andLabFont:17.0 andMaxWidth:300 andMaxHeight:60];
    [_wheatherInfoLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(weatherInfoLabelNewSize.height));
        make.width.equalTo(@(weatherInfoLabelNewSize.width));
        
    }];
    CGSize tempLabelNewSize = [_tempLabel setLabelWidth:[NSString stringWithFormat:@"%@°",currentWeatherInfo.tmp] andLabFont:72.0 andMaxWidth:300 andMaxHeight:180];
    [_tempLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(tempLabelNewSize.height));
        make.width.equalTo(@(tempLabelNewSize.width));
        
    }];
    
    CGSize aqiLabeNewSize = [_airQulityLabel setLabelWidth:[NSString stringWithFormat:@"空气质量：%@",aqiInfo.qlty] andLabFont:14.0 andMaxWidth:400 andMaxHeight:30];
    [_airQulityLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(aqiLabeNewSize.height));
        make.width.equalTo(@(aqiLabeNewSize.width));
        
    }];
//    for (NSDictionary *temDict in data.daily_forecast) {
//        ZTQDailyWeatherInfo *model = [ZTQDailyWeatherInfo new];
//        [model setValuesForKeysWithDictionary:temDict[@"cond"]];
//        [model setValuesForKeysWithDictionary:temDict[@"tmp"]]
//        [model setValuesForKeysWithDictionary:temDict[@"wind"]]
//        
//    }
    NSString *weatherStr = [ChineseToPinyin pinyinFromChiniseString:[currentWeatherInfo.txt getSubStrBySeparatedStr:@"/"][0]];
    weatherStr = [weatherStr lowercaseString];
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"BG%@",weatherStr]];
    if (image == nil) {
        image = [UIImage imageNamed:@"BG3"];
    }
    _bgImageVew.image = image;
    [_futurWheatherInfoView reloadData];

}



- (void)changeCity:(UIButton *)sender{
    ZTQCityList *cityList = [ZTQCityList new];
    UINavigationController *newNav = [[UINavigationController alloc] initWithRootViewController:cityList];
    [newNav.navigationBar setBackgroundImage:[UIImage imageNamed:@"BG3.png"] forBarMetrics:UIBarMetricsDefault];


//    newNav.hidesBarsWhenKeyboardAppears = YES;

    [self.navigationController presentViewController:newNav animated:YES completion:nil];
}

-(void)didFailedLocation
{
    ((AppDelegate*)[UIApplication sharedApplication].delegate).isGetLocatNow = NO;
    [UIAlertController showAlsert:@"未能定位到当前城市" withVC:self okAction:^{
        if ([NSString StringIsNull:[CityInfo shareUserInfo].cityID]) {
            [CityInfo shareUserInfo].cityName = @"北京";
            [CityInfo shareUserInfo].cityProvince = @"北京";
            [CityInfo shareUserInfo].cityCountry = @"中国";
            [CityInfo shareUserInfo].cityID = [CityDao findCityIdByCityName:[CityInfo shareUserInfo].cityName andProName:[CityInfo shareUserInfo].cityProvince];
            
        }
        [self getData];
    }];
  
}


-(void)didSUccessLocation{
    ((AppDelegate*)[UIApplication sharedApplication].delegate).isGetLocatNow = NO;
   
    
    [CityInfo shareUserInfo].cityID = [CityDao findCityIdByCityName:[CityInfo shareUserInfo].cityName andProName:[CityInfo shareUserInfo].cityProvince];
    [ScenicSpotInfo shareUserInfo].scenicLocatPro = [CityInfo shareUserInfo].cityProvince;
     ScenicSpotModel *scenicPot = [ScenicSpotDao findByProName:[CityInfo shareUserInfo].cityProvince];
    [ScenicSpotInfo shareUserInfo].scenicName = scenicPot.ScenicSpotName;
    [ScenicSpotInfo shareUserInfo].scenicID = scenicPot.ScenicSpotID;
    [ScenicSpotInfo shareUserInfo].scenicLocation = scenicPot.ScenicSpotLocationCity;
    [ScenicSpotInfo shareUserInfo].scenicLocatPro = scenicPot.ScenicSpotLocatProvince;
    [self getData];
    
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
