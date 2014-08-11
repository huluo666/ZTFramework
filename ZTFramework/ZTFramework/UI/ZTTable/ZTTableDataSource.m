/*
 ============================================================================
 Name           : ZTTableDataSource.m
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTTableDataSource declaration
 ============================================================================
 */

#import "ZTTableDataSource.h"
#import "ZTTableView.h"
#import "ZTTableCell.h"
#import "ZTTableSectionModel.h"
#import "ZTTableMoreCell.h"
#import "ZTTableDelegate.h"

static NSString * const cellMoreIdentifier = @"CellMore";       //加载更多

@interface ZTTableDataSource()

/** cell名 */
@property (nonatomic, copy)                     NSString                        *cellIdentifier;

/** cell配置block */
@property (nonatomic, copy)                     ZTTableDataSourceCellConfig     cellConfigureBlock;

/** 分组总数 */
@property (nonatomic, unsafe_unretained)        NSInteger                       sectionCount;

@end

@implementation ZTTableDataSource

- (instancetype)initConfigWith:(NSString *)name cellConfig:(ZTTableDataSourceCellConfig)block {
    if (self = [super init]) {
        cellIdentifier = name;
        sectionDatas = [NSMutableArray array];
        cellConfigureBlock = [block copy];
    }
    
    return self;
}

- (void)dealloc {
    cellConfigureBlock = nil;
}

//获取单项数据
- (id)itemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;

    if (sectionCount < 1) {
        return datas[row];
    }
    
    ZTTableSectionModel *mode = [sectionDatas objectAtIndex:section];
    return [[datas objectForKey:mode.key] objectAtIndex:row];
}

//获取单项Cell
- (ZTTableCell *)itemCellAtIndexPath:(ZTTableView *)table indexPath:(NSIndexPath *)indexPath {
    return (ZTTableCell *)[self tableView:table cellForRowAtIndexPath:indexPath];
}

//组数量
- (NSInteger)numberOfSectionsInTableView:(ZTTableView *)tableView {
    sectionCount = [sectionDatas count];
    return sectionCount < 1 ? 1 : sectionCount;
}

//单个组数据
- (NSInteger)tableView:(ZTTableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (sectionCount < 1) {
        
        NSUInteger count = [datas count];
        
        if (count < 1) {
            return count;
        }
        
        if (tableView.isLoadMore && !tableView.isBottom) {
            count += 1;
        }
        
        return count;
    }
    
    ZTTableSectionModel *mode = [sectionDatas objectAtIndex:section];
    return [[datas objectForKey:mode.key] count];
}

//组名
- (NSString *)tableView:(ZTTableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (sectionCount < 1) {
        return nil;
    }
    
    ZTTableSectionModel *mode = [sectionDatas objectAtIndex:section];
    return mode.title;
}

//cell
- (UITableViewCell *)tableView:(ZTTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //加载更多
    if (tableView.isLoadMore &&
        tableView.contentSize.height > (tableView.frame.size.height/2.0f)  &&
        sectionCount < 1 &&
        indexPath.row == [datas count] &&
        !tableView.isBottom) {
        
        tableView.moreCell = [tableView dequeueReusableCellWithIdentifier:cellMoreIdentifier];
            
        if (tableView.moreCell == nil) {
            tableView.moreCell = [[ZTTableMoreCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellMoreIdentifier];
            tableView.moreCell.backgroundColor = [UIColor clearColor];
        }
        
        return tableView.moreCell;
    }
    
    //普通cell
    ZTTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    id dataBase = [self itemAtIndexPath:indexPath];
    cellConfigureBlock(cell, dataBase, indexPath);
    return cell;
}

//右侧索引
-(NSArray *)sectionIndexTitlesForTableView:(ZTTableView *)TableView {
    
    if (!indexShow) {
        return nil;
    }
    
    if (sectionCount < 1) {
        return nil;
    }
    
    NSMutableArray *ary = [[NSMutableArray alloc] initWithCapacity:sectionCount];
    for (ZTTableSectionModel *item in  sectionDatas) {
        [ary addObject:item.key];
    }
    
    return ary;
}


@synthesize indexShow;
@synthesize sectionDatas;
@synthesize sectionCount;
@synthesize cellConfigureBlock;
@synthesize cellIdentifier;
@synthesize datas;
@end
