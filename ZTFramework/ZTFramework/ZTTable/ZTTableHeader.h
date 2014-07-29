//
//  TCTableHeader.h
//  TongChengSearch
//
//  Created by Fighting on 14-5-28.
//  Copyright (c) 2014年 tcsos.com. All rights reserved.
//

#ifndef TongChengSearch_TCTableHeader_h
#define TongChengSearch_TCTableHeader_h

static NSString * const cellMoreIdentifier = @"CellMore";       //加载更多

typedef NS_ENUM(NSInteger, TCTableViewState) {
    TCTableViewState_None,          //默认
    TCTableViewState_Loading,       //加载中...
    TCTableViewState_PullEnd        //加载完成
};

#endif
