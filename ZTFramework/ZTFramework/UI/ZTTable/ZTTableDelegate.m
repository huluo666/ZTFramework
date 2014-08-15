/*
 ============================================================================
 Name           : ZTTableDelegate.m
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTTableDelegate declaration
 ============================================================================
 */

#import "ZTTableDelegate.h"
#import "ZTTableSectionModel.h"
#import "ZTTableView.h"
#import "ZTTableMoreCell.h"

@implementation ZTTableDelegate

- (instancetype)init {
    if (self = [super init]) {
        sectionDatas = [NSMutableArray array];
    }
    
    return self;
}

//sectionHeader高度
- (CGFloat)tableView:(ZTTableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (sectionHeaderHeight) {
        return sectionHeaderHeight(section);
    }
    
    return 0.0f;
}

//cell高度
- (CGFloat)tableView:(ZTTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
        
    //加载更多
    if (tableView.isLoadMore && tableView.numberOfSections == 1 && indexPath.row == [datas count]) {
        return 44;
    }
    
    if (cellHeight) {        
        return cellHeight(indexPath);
    }
    
    return cellDefH;
}

//点击
- (void)tableView:(ZTTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (!cellSelect) {
        return;
    }
    
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    id dataBase = nil;
    
    if ([sectionDatas count] < 1) {
        
        //点击到加载更多的cell,Bug修改
        if (tableView.isLoadMore && row >= [datas count]) {
            return;
        }
        
        dataBase = datas[row];
    } else {
        ZTTableSectionModel *sectionModel = [sectionDatas objectAtIndex:section];
        dataBase = [[datas objectForKey:sectionModel.key] objectAtIndex:row];
    }
    
    cellSelect((ZTTableCell *)[tableView cellForRowAtIndexPath:indexPath], indexPath, dataBase);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];    
}

//显示cell
- (void)tableView:(ZTTableView *)tableView willDisplayCell:(ZTTableCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //判断cell是否为自定义底部加载，是否自动触发加载更多
    if (tableView.isLoadMore &&
        indexPath.row == [datas count] &&
        [cell isKindOfClass:[ZTTableMoreCell class]]) {
        
        if (!loadMoreData) {
            return;
        }
        
        //外部第一次不触发
        if (tableView.isOutTouchLoadMore && tableView.state == ZTTableViewState_None) {
            return;
        }
        
        if (!(tableView.contentOffset.y + tableView.frame.size.height + 44.0f) >= tableView.contentSize.height) {
            return;
        }

        //正在加载中...
        if (tableView.state == ZTTableViewState_Loading) {
            return;
        }
        
        //加载更多
        if (tableView.state == ZTTableViewState_PullEnd) {
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                tableView.state = ZTTableViewState_Loading;
            });

            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                loadMoreData();
            });
        }
    }
}

//section 间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return sectionGap;
}



@synthesize sectionGap;
@synthesize loadMoreData;
@synthesize sectionHeaderHeight;
@synthesize sectionDatas;
@synthesize datas;
@synthesize cellSelect;
@synthesize cellHeight;
@end
