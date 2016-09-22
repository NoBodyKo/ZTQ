//
//  CustomIndexView.h
//  ZTQ
//
//  Created by 杨洪 on 16/9/21.
//  Copyright © 2016年 杨洪. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol indexDelegate;
@interface CustomIndexView : UIView
@property (nonatomic, strong) NSArray *indexes;
@property (nonatomic, weak)id <indexDelegate>delegate;
@property (nonatomic, strong)UIColor *indexColor;
- (void)reloadData;

@end

@protocol indexDelegate <NSObject>
@required
/**
 *  触摸到索引时触发
 *
 *  @param tableViewIndex 触发didSelectSectionAtIndex对象
 *  @param index          索引下标
 *  @param title          索引文字
 */
- (void)tableViewIndex:(CustomIndexView *)tableViewIndex didSelectSectionAtIndex:(NSInteger)index withTitle:(NSString *)title;


/**
 *  TableView中右边右边索引title
 *
 *  @param tableViewIndex 触发tableViewIndexTitle对象
 *
 *  @return 索引title数组
 */
- (NSArray *)tableViewIndexTitle:(CustomIndexView *)tableViewIndex;

/**
 *  开始触摸索引
 *
 *  @param tableViewIndex 触发tableViewIndexTouchesBegan对象
 */
- (void)tableViewIndexTouchesBegan:(CustomIndexView *)tableViewIndex;
/**
 *  触摸索引结束
 *
 *  @param tableViewIndex
 */
- (void)tableViewIndexTouchesEnd:(CustomIndexView *)tableViewIndex;


@end
