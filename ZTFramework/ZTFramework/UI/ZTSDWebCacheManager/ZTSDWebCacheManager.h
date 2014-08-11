/*
 ============================================================================
 Name           : ZTSDWebCacheManager.h
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTSDWebCacheManager declaration
 ============================================================================
 */

#import "ZTKit.h"

/** 清空完后，回调 */
typedef void (^ ZTSDWebCacheManagerBlock)();

/**
 *ZTSDWebCacheManager:缓存管理
 *Author:Fighting
 **/
@interface ZTSDWebCacheManager : NSObject

/**
 *  清空缓存
 *
 *  @param block 回调
 */
+ (void)cacheClear:(ZTSDWebCacheManagerBlock)block;

/**
 *  缓存大小
 *
 *  @return 缓存大小
 */
+ (NSString *)cacheSize;

@end
