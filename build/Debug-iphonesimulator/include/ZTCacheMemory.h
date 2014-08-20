/*
 ============================================================================
 Name           : ZTCacheMemory.h
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTCacheFile declaration
 ============================================================================
 */

#import "ZTPrecompile.h"
#import "ZTCacheProtocol.h"

/** 缓存最大数 */
static const int ZT_CACHE_MEMORY_MAX_COUNT = 48;

/**
 *ZTCacheMemory:内存缓存
 *Author:Fighting
 **/
@interface ZTCacheMemory : NSObject<ZTCacheProtocol>

ZT_SINGLETON_AS(ZTCacheMemory)

@end
