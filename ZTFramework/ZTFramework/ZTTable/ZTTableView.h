/*
 ============================================================================
 Name           : ZTTableView.h
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTTableView declaration
 ============================================================================
 */

#import "ZTKit.h"
@class ZTTableMoreCell;

/**
 *ZTTableView:tableView
 *Author:Fighting
 **/
@interface ZTTableView : UITableView

/** 加载更多 */
@property (nonatomic, unsafe_unretained) BOOL isLoadMore;

/** 是否已经到达底部 */
@property (nonatomic, unsafe_unretained) BOOL isBottom;

/** 外部触发加载更多 */
@property (nonatomic, unsafe_unretained) BOOL isOutTouchLoadMore;

/** 状态 */
@property (nonatomic, unsafe_unretained) ZTTableViewState state;

/** 更多cell */
@property (nonatomic, strong) ZTTableMoreCell *moreCell;

@end
