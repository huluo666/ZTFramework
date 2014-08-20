/*
 ============================================================================
 Name           : ZTTabBarConfigs.h
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTTabBarConfigs declaration
 ============================================================================
 */

#import "ZTKit.h"

/**
 *ZTTabBarConfigs:tabBar配置
 *Author:Fighting
 **/
@interface ZTTabBarConfigs : NSObject

/** transition背景色 */
@property (nonatomic, unsafe_unretained)    CGColorRef  transitionBackgroudColor;

/** tabBarItem文字大小 */
@property (nonatomic, unsafe_unretained)    CGFloat     tabBarItemTextSize;

/** tabBarItem文字颜色 */
@property (nonatomic, unsafe_unretained)    CGColorRef  tabBarItemTextColor;

/** tabBarItem高亮文字颜色 */
@property (nonatomic, unsafe_unretained)    CGColorRef  tabBarItemTextHighlightedColor;

/** 背景图 */
@property (nonatomic, unsafe_unretained)    CGImageRef  tabBarBackgroudImage;

/** 气泡通知名 */
@property (nonatomic, ZT_ARC_STRONG)        NSString    *tabBarBadgeNotificationName;

@end
