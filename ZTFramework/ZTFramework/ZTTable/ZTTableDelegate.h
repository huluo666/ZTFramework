/*
 ============================================================================
 Name           : ZTTableDelegate.h
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTTableDelegate declaration
 ============================================================================
 */

#import "ZTKit.h"

@class ZTTableCell;
@class ZTTableView;

/** cell高度Block */
typedef CGFloat (^ ZTTableDelegateCellHeight) (NSIndexPath *indexPath);

/** 选中某行时的block */
typedef void (^ ZTTableDelegateCellSelect) (ZTTableCell *cell, NSIndexPath *indexPath, id item);

/** sectionHeader高度 */
typedef CGFloat (^ ZTTableDelegateSectionHeaderHeight) (NSInteger section);

/** 加载更多数据 */
typedef void(^ ZTLoadMoreData)();





/**
 *ZTTableDelegate:表格委托
 *Author:Fighting
 **/
@interface ZTTableDelegate : NSObject<UITableViewDelegate>

/** 数据 */
@property (nonatomic, strong)               id                                          datas;

/** section 间距 */
@property (nonatomic, unsafe_unretained)    float                                       sectionGap;

/** 分组数据 */
@property (nonatomic, strong)               NSMutableArray                              *sectionDatas;

/** Cell高度 */
@property (nonatomic, copy)                 ZTTableDelegateCellHeight                   cellHeight;

/** Cell选中某行 */
@property (nonatomic, copy)                 ZTTableDelegateCellSelect                   cellSelect;

/** sectionHeader 高度 */
@property (nonatomic, copy)                 ZTTableDelegateSectionHeaderHeight          sectionHeaderHeight;

/** 加载更多数据 */
@property (nonatomic, copy)                 ZTLoadMoreData                              loadMoreData;

@end
