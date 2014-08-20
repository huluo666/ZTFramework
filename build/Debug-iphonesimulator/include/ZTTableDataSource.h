/*
 ============================================================================
 Name           : ZTTableDataSource.h
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTTableDataSource declaration
 ============================================================================
 */

#import "ZTKit.h"

@class ZTTableView;
@class ZTTableCell;
@class ZTTableSectionModel;

/** cell配置 */
typedef void(^ ZTTableDataSourceCellConfig)(ZTTableCell *cell, id data, NSIndexPath *indexPath);

/**
 *ZTTableDataSource:数据绑定
 *Author:Fighting
 **/
@interface ZTTableDataSource : NSObject<UITableViewDataSource>

/** 数据 */
@property (nonatomic, ZT_ARC_STRONG)               id                  datas;

/** 分组数据 */
@property (nonatomic, ZT_ARC_STRONG)               NSMutableArray      *sectionDatas;

/** 是否显示索引 */
@property (nonatomic, unsafe_unretained)    BOOL                indexShow;

/**
 *  初始化配置
 *
 *  @param cellIdentifier cell名称
 *  @param cellConfig     cell配置
 *
 *  @return instancetype
 */
- (instancetype)initConfigWith:(NSString *)cellIdentifier cellConfig:(ZTTableDataSourceCellConfig)cellConfig;

/**
 *  获取单项数据
 *
 *  @param indexPath NSIndexPath
 *
 *  @return id
 */
- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  获取单项Cell
 *
 *  @param table     ZTTableView
 *  @param indexPath NSIndexPath
 *
 *  @return ZTTableCell
 */
- (ZTTableCell *)itemCellAtIndexPath:(ZTTableView *)table indexPath:(NSIndexPath *)indexPath;

@end
