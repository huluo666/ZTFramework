/*
 ============================================================================
 Name           : ZTTabBarItemGroup.h
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTTabBarItemGroup declaration
 ============================================================================
 */

#import "ZTKit.h"
@class ZTTabBarModel;

/** tabBarGroup委托 */
@protocol ZTTabBarItemGroupDelegate <NSObject>

@required

/**
 *  点击
 *
 *  @param selectModel 选中的Model
 */
- (void)ZTTabBarItemGroup_Click:(ZTTabBarModel *)selectModel;

@end




/**
 *ZTTabBarItemGroup:tabBar分组
 *Author:Fighting
 **/
@interface ZTTabBarItemGroup : UIView

/** 委托 */
@property (nonatomic, unsafe_unretained)        id<ZTTabBarItemGroupDelegate>   delegate;

/** 背景图片 */
@property (nonatomic, ZT_ARC_STRONG)            UIImage                         *backGroudImage;

/** 选中某个 */
@property (nonatomic, unsafe_unretained)        int                             selectIndex;

/** 总item数 */
@property (nonatomic, unsafe_unretained)        NSInteger                       tabBarItemCount;

/** 存储TabBarItem */
@property (nonatomic, ZT_ARC_STRONG)            NSMutableArray                  *tabBarItemAry;

/**
 *  追加一个TabBarItem
 *
 *  @param model 数据
 */
- (void)appTabBarItem:(ZTTabBarModel *)model;

/**
 *  根据tabBarItem显示气泡
 *
 *  @param item tabBarItem
 *  @param num  数量
 */
- (void)bagedForTabBarItem:(int)item num:(int)num;

@end
