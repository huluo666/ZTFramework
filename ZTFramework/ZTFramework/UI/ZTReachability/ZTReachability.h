/*
 ============================================================================
 Name           : ZTReachability.h
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTReachability declaration
 ============================================================================
 */

#import "ZTKit.h"

/**
 *ZTReachability:网络监控状态,WIFI,3G,是否连接网络
 *Author:Fighting
 **/
@interface ZTReachability : NSObject

/** 单例模式 */
ZT_SINGLETON_AS(ZTReachability);

/**
 *  是否有网络
 *
 *  @return BOOL
 */
- (BOOL)isEnableNet;

/**
 *  是否wifi
 *
 *  @return BOOL
 */
- (BOOL)isEnableWIFI;

/**
 *  是否3G
 *
 *  @return BOOL
 */
- (BOOL)isEnable3G;

/**
 *  返回当前网络类型字符串
 *
 *  @return string
 */
- (NSString *)NetworkString;

@end
