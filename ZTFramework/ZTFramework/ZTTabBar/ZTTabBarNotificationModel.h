/*
 ============================================================================
 Name           : ZTTabBarNotificationModel.h
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTTabBarNotificationModel declaration
 ============================================================================
 */

#import "ZTKit.h"

/**
 *ZTTabBarNotificationModel:气泡通知数据模型
 *Author:Fighting
 **/
@interface ZTTabBarNotificationModel : NSObject

/** 第几个显示气泡 */
@property (nonatomic, unsafe_unretained) NSInteger tabBarItem;

/** 气泡数 */
@property (nonatomic, unsafe_unretained) int bagedNumber;

@end
