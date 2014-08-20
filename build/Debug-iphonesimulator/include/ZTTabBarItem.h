/*
 ============================================================================
 Name           : ZTTabBarItem.h
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTTabBarItem declaration
 ============================================================================
 */

#import "ZTKit.h"
@class ZTTabBarModel;


/** tabBarItem委托 */
@protocol ZTTabBarItemDelegate <NSObject>

@required

/**
 *  tabBarItem点击
 *
 *  @param sender 回调对象
 */
- (void)ZTTabBarItemClick:(id)sender;

@end


/**
 *ZTTabBarItem:tabBar单个对象视图
 *Author:Fighting
 **/
@interface ZTTabBarItem : UIView

/** 委托 */
@property (nonatomic, unsafe_unretained)    id<ZTTabBarItemDelegate>    delegate;

/** 选中 */
@property (nonatomic, unsafe_unretained)    BOOL                        selected;

/** 数据 */
@property (nonatomic, ZT_ARC_STRONG)               ZTTabBarModel               *data;

/** 气泡数字 */
@property (nonatomic, unsafe_unretained)    int                         badgeNumber;

/**
 *  初始化tabBarItem
 *
 *  @param Model 数据模型
 *  @param frame 宽高
 *
 *  @return id
 */
- (instancetype)initConfigWith:(ZTTabBarModel *)Model frame:(CGRect)frame;

@end
