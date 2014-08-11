/*
 ============================================================================
 Name           : ZTTableMoreCell.h
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTTableMoreCell declaration
 ============================================================================
 */

#import "ZTTableCell.h"

/**
 *ZTTableMoreCell:更多Cell
 *Author:Fighting
 **/
@interface ZTTableMoreCell : ZTTableCell

/**
 *  状态视图
 *
 *  @param state 状态
 */
- (void)stateView:(ZTTableViewState) state;

@end
