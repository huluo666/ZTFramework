/*
 ============================================================================
 Name           : ZTTabBar.h
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTTabBar declaration
 ============================================================================
 */

#import "ZTKit.h"

@class ZTTabBarModel;
@class ZTTabBarConfigs;

//配置
UIKIT_EXTERN const ZTTabBarConfigs *tabBarConfig;

/**
 *ZTTabBar:TabBar主函数
 *Author:Fighting
 **/
@interface ZTTabBar : UIViewController

/**
 *  单例模式
 *
 *  @return ZTTabBar
 */
+ (ZTTabBar *)sharedInstance;

/** 切换到某个索引 */
@property (nonatomic, unsafe_unretained)                int                         selectedIndex;

/** 总数 */
@property (readonly, nonatomic, unsafe_unretained)      NSInteger                   tabBarItemCount;

/**
 *  初始化配置
 *
 *  @param ZTTabBarConfig 配置
 */
- (void)initWithConfig:(ZTTabBarConfigs *)config;

/**
 *  追加一个TabBarItem
 *
 *  @param model 数据
 */
- (void)appendTabBar:(ZTTabBarModel *)model;

/**
 *  获取model
 *
 *  @param current 位置
 *
 *  @return ZTTabBarModel
 */
- (ZTTabBarModel *)getTabBarModel:(int)current;

/**
 *  隐藏,显示 tabBar
 *
 *  @param yesORno  隐藏,显示
 *  @param animated 动画
 */
- (void)hiddenTabBar:(BOOL)yesORno animated:(BOOL)animated;

@end
