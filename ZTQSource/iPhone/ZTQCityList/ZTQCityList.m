//
//  ZTQCityList.m
//  ZTQ
//
//  Created by 杨洪 on 16/9/20.
//  Copyright © 2016年 杨洪. All rights reserved.
//

#import "ZTQCityList.h"
#import "CityDao.h"
#import "CustomIndexView.h"
#import "HotCityList.h"
static const CGFloat NavgationHeight = 64;
@interface ZTQCityList ()<UITableViewDelegate, UITableViewDataSource,indexDelegate,UISearchBarDelegate>
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *cityKeysArray;
@property (nonatomic, strong) UILabel *indexLabel;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) CustomIndexView *indexView;
@property (nonatomic, strong) UITableView *searchResultTableView;
@property (nonatomic, strong) UITapGestureRecognizer *tapGestuer;
@property (nonatomic, strong) UISearchBar *mySearchBar;
@property (nonatomic, strong) NSMutableArray *searchResultArray;
@property (nonatomic, strong) NSMutableArray *hotCityArray;
@property (nonatomic, strong) NSString *keyWordStr;
@end

@implementation ZTQCityList


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareForview];
    [self getAllCityInfo];
    self.view.backgroundColor = [UIColor colorWithWhite:.95 alpha:1];
    _searchResultArray = [NSMutableArray array];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)prepareForview{
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    _mySearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 40)];
    _mySearchBar.delegate = self;
    _mySearchBar.returnKeyType = UIReturnKeySearch;
    _mySearchBar.showsCancelButton = NO;
    
    _mySearchBar.placeholder = @"输入城市/省份/地区名称";
    [self.view addSubview:_mySearchBar];

    
    _indexLabel = [[UILabel alloc] init];
    _indexLabel.center = self.view.center;
    _indexLabel.bounds = CGRectMake(0, 0, 50, 50);
    _indexLabel.layer.cornerRadius = 25;
    _indexLabel.layer.masksToBounds = YES;
    _indexLabel.font = [UIFont systemFontOfSize:30];
    _indexLabel.textAlignment = NSTextAlignmentCenter;
//    _indexLabel.backgroundColor = [UIColor redColor];
    _indexLabel.hidden = YES;
    [self.view addSubview:_indexLabel];
    
    
    _searchResultTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_mySearchBar.frame), self.view.bounds.size.width, self.view.bounds.size.height - 40 - NavgationHeight) style:UITableViewStyleGrouped];
    _searchResultTableView.delegate = self;
    _searchResultTableView.dataSource = self;
    _searchResultTableView.backgroundColor = [UIColor colorWithWhite:.5 alpha:.5];
    _searchResultTableView.showsVerticalScrollIndicator = NO;
    _searchResultTableView.showsHorizontalScrollIndicator = NO;
    _searchResultTableView.estimatedRowHeight = 40;
    _searchResultTableView.hidden = YES;
    [self.view addSubview:_searchResultTableView];

    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_mySearchBar.frame) + 3, self.view.bounds.size.width - 15, self.view.bounds.size.height - 40 - NavgationHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.estimatedRowHeight = 40;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    
    _indexView = [[CustomIndexView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_tableView.frame), CGRectGetMinY(_tableView.frame), 15, self.view.bounds.size.height - 40 - NavgationHeight)];
    _indexView.delegate = self;
//    _indexView.indexColor = [UIColor blueColor];
    [self.view addSubview:_indexView];
    [self.view bringSubviewToFront:_indexLabel];
    
}
- (void)backAction{
    [_searchResultArray removeAllObjects];
    [_hotCityArray removeAllObjects];
    [_dataArray removeAllObjects];
    [_mySearchBar resignFirstResponder];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
- (void)getAllCityInfo{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    if (!_cityKeysArray){
        _cityKeysArray = [NSMutableArray array];
    }
    [_dataArray addObjectsFromArray:[CityDao getAllCity]];
    for (CityModel *model in _dataArray) {
        if (![_cityKeysArray containsObject:model.keys]) {
            [_cityKeysArray addObject:model.keys];
        }
    }
    [_cityKeysArray insertObject:@"#" atIndex:0];
     [self getHotCityInfo];
    [_indexView reloadData];
    [_tableView reloadData];
}

- (void)getCityByKeyWords:(NSString *)keyWords{
    if (!_searchResultArray) {
        _searchResultArray = [NSMutableArray array];
    }
    [_searchResultArray removeAllObjects];
    if (keyWords.length > 0) {
         [_searchResultArray addObjectsFromArray:[CityDao getAllCityByKeyWords:keyWords]];
    }
   
    [_searchResultTableView reloadData];
}
- (void)getHotCityInfo{
    if (!_hotCityArray) {
        _hotCityArray = [NSMutableArray array];
    }
    NSArray *hotcityArray = @[@"北京",@"上海",@"重庆",@"成都",@"深圳",@"广州",@"厦门",@"杭州"];
    NSArray *hotcCityProArr = @[@"北京",@"上海",@"重庆",@"四川",@"广东",@"广东",@"福建",@"浙江"];
    NSArray *hotcityIdArray = @[@"CN101010100",@"CN101020100",@"CN101040100",@"CN101270101",@"CN101280601",@"CN101280101",@"CN101230201",@"CN101210101"];
    for (int i = 0; i < hotcityArray.count; i++) {
        CityModel *model = [CityModel new];
        model.cityName = hotcityArray[i];
        model.proName = hotcCityProArr[i];
        model.cityID = hotcityIdArray[i];
        [_hotCityArray addObject:model];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) addGestuer{
    _tapGestuer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)];
    [self.view addGestureRecognizer:_tapGestuer];
}

- (void)removeGestuer{
    [self.view removeGestureRecognizer:_tapGestuer];
}
#pragma mark UISearchBarDelegate 回调
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (searchText.length <= 0) {
        _searchResultTableView.backgroundColor = [UIColor colorWithWhite:.5 alpha:.5];
    }else{
        _searchResultTableView.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
    }
    _keyWordStr = searchText;
    [self getCityByKeyWords:searchText];
}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    _mySearchBar.showsCancelButton = YES;
    _searchResultTableView.hidden = NO;
    [self.view bringSubviewToFront:_searchResultTableView];
    [self addGestuer];
    return YES;
}
-(void) searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self getCityByKeyWords:searchBar.text];
    [_mySearchBar resignFirstResponder];
}
-(void) searchBarCancelButtonClicked:(UISearchBar *)searchBar{
     _mySearchBar.showsCancelButton = NO;
    searchBar.text = nil;
    [searchBar resignFirstResponder];
    [_searchResultArray removeAllObjects];
    [self.view sendSubviewToBack:_searchResultTableView];
    _searchResultTableView.backgroundColor = [UIColor colorWithWhite:.5 alpha:.5];
    _searchResultTableView.hidden = YES;
//    self.navigationController.navigationBarHidden = NO;
}

- (void)dismissKeyboard:(UITapGestureRecognizer *)tapGuesTuer{
    
    [_mySearchBar resignFirstResponder];
    [self.view removeGestureRecognizer:tapGuesTuer];
    if (_searchResultArray.count <= 0) {
        _mySearchBar.text = nil;
        _mySearchBar.showsCancelButton = NO;
        _searchResultTableView.backgroundColor = [UIColor colorWithWhite:.5 alpha:.5];
        [self.view sendSubviewToBack:_searchResultTableView];
        _searchResultTableView.hidden = YES;
    }
}


#pragma mark ScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == _searchResultTableView) {
        [self dismissKeyboard:_tapGestuer];
    }
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    if (tableView == _searchResultTableView) {
        return 1;
    }
    return _cityKeysArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    if (tableView == _searchResultTableView) {
        return _searchResultArray.count;
    }else{
        if (section == 0) {
            return 1;
        }
        NSUInteger rowCount = 0;
        for (CityModel *model in _dataArray) {
            if ([model.keys isEqualToString:_cityKeysArray[section]]) {
                rowCount += 1;
            }
        }
        return rowCount;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WEAKSELF;
    if (tableView == _searchResultTableView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchResultcell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SearchResultcell"];
        }
        CityModel *model = _searchResultArray[indexPath.row];
        
        NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:model.cityName];
        NSRange range = [model.cityName rangeOfString:_keyWordStr];
        [attributedStr addAttribute:NSForegroundColorAttributeName
         
                              value:[UIColor cyanColor]
         
                              range:NSMakeRange(range.location, range.length)];
        cell.textLabel.attributedText = attributedStr;
        return cell;
    }
    else if (indexPath.section == 0){
        
        HotCityList *cell = [tableView dequeueReusableCellWithIdentifier:@"hotList"];
        if (!cell) {
            cell = [[HotCityList alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"hotList"];
        }
        cell.block = ^(CityModel *model){
            [CityInfo shareUserInfo].cityName = model.cityName;
            [CityInfo shareUserInfo].cityID = model.cityID;
            [CityInfo shareUserInfo].cityProvince = model.proName;
            [weakSelf.navigationController dismissViewControllerAnimated:YES completion:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"getWeatherInfo" object:nil];
            }];
            
        };
        [cell setData:_hotCityArray withCol:3];
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        NSMutableArray *array = [NSMutableArray array];
        for (CityModel *model in _dataArray) {
            //        DLog(@"%@",model.cityName);
            
            if ([model.keys isEqualToString:_cityKeysArray[indexPath.section]]) {
                if (![array containsObject:model]) {
                    [array addObject:model];
                }
                
            }
        }
        CityModel *model = array[indexPath.row];
        
        cell.textLabel.text = model.cityName;
        // Configure the cell...
        
        return cell;
  
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (tableView == _searchResultTableView) {
        return nil;
    }else if (section == 0){
        return @"热门城市";
    }
    return _cityKeysArray[section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _searchResultTableView) {
        return 40;
    }
    if (indexPath.section == 0) {
        int total = (int)_hotCityArray.count;
        int row = total % 3 ? (total / 3 + 1) :  total / 3;
        return (row + 1) * 10 + row * 30;
    }
    return 40;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _searchResultTableView) {
        CityModel *model = _searchResultArray[indexPath.row];
        [CityInfo shareUserInfo].cityName = model.cityName;
        [CityInfo shareUserInfo].cityID = model.cityID;
        [CityInfo shareUserInfo].cityProvince = model.proName;
        [self.navigationController dismissViewControllerAnimated:YES completion:^{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"getWeatherInfo" object:nil];
        }];
    }else if (indexPath.section < 1){
        
    }else{
        CityModel *model = _dataArray[indexPath.row];
        [CityInfo shareUserInfo].cityName = model.cityName;
        [CityInfo shareUserInfo].cityID = model.cityID;
        [CityInfo shareUserInfo].cityProvince = model.proName;
        [self.navigationController dismissViewControllerAnimated:YES completion:^{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"getWeatherInfo" object:nil];
        }];

    }
}

#pragma mark CustomIndexViewDelegate
- (NSArray *)tableViewIndexTitle:(CustomIndexView *)tableViewIndex{
    return _cityKeysArray;
}

- (void)tableViewIndex:(CustomIndexView *)tableViewIndex didSelectSectionAtIndex:(NSInteger)index withTitle:(NSString *)title{
        [_tableView
         scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index]
         atScrollPosition:UITableViewScrollPositionTop animated:YES];
      _indexLabel.text = _cityKeysArray[index];

}

- (void)tableViewIndexTouchesBegan:(CustomIndexView *)tableViewIndex{
    
        _indexLabel.hidden = NO;
}

- (void)tableViewIndexTouchesEnd:(CustomIndexView *)tableViewIndex{
        [UIView animateWithDuration:2.0 animations:^{
             _indexLabel.alpha = 0;
        } completion:^(BOOL finished) {
            _indexLabel.alpha = 1;
            _indexLabel.hidden = YES;
        }];

}
//#pragma mark 添加索引
//-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
//
//{
//    
//    
//    
//    
//    
//    
//    return _cityKeysArray;
//    
//}
//#pragma mark 索引点击
//-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
//
//{
//    
//    
//    //点击索引，列表跳转到对应索引的行
//    
//    [tableView
//     scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index]
//     atScrollPosition:UITableViewScrollPositionTop animated:YES];
//    
//    _indexLabel.text = _cityKeysArray[index];
//    _indexLabel.hidden = NO;
//    [UIView animateWithDuration:2.0 animations:^{
//         _indexLabel.alpha = 0;
//    } completion:^(BOOL finished) {
//        _indexLabel.alpha = 1;
//        _indexLabel.hidden = YES;
//    }];
//    
//    
//    return index;
//    
//}
//
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
