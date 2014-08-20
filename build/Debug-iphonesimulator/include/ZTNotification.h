/*
 ============================================================================
 Name           : ZTNotification.h
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTNotification declaration
 ============================================================================
 */

#import "ZTPrecompile.h"

#undef ZT_M_NOTIFICATION_NAME

/** 通知名称 */
#define ZT_M_NOTIFICATION_NAME(__name) ZT_TEXT(__name)

/** 通知方法 */
#define ZT_NOTIFICATION_ON_1(__name) -(void)__name##NotificationHandle:(NSNotification *)notification

/** 通知回调 */
typedef void(^ ZTNotification_block)(NSNotification *notification);

/**
 *ZTNotification:通知
 *Author:Fighting
 **/
@interface ZTNotification : NSObject

@end

/**
 *ZTNotification+NSObject:通知
 *Author:Fighting
 **/
@interface NSObject (ZTNotification)

/** 所有通知 */
@property (nonatomic, readonly, strong) NSMutableDictionary *notifications;

/**
 *  注册通知
 *
 *  @param name 通知名
 */
- (void)registerNotification:(NSString *)name;

/**
 *  注册通知
 *
 *  @param name  通知名
 *  @param block 回调
 */
- (void)registerNotification:(NSString *)name block:(ZTNotification_block)block;

/**
 *  注销通知
 *
 *  @param name 通知名
 */
- (void)unregisterNotification:(NSString*)name;

/**
 *  注销所有通知
 */
- (void)unregisterAllNotification;

/**
 *  发送通知
 *
 *  @param name     通知名
 *  @param userInfo 数据
 */
- (void)postNotification:(NSString *)name userInfo:(id)userInfo;

@end
