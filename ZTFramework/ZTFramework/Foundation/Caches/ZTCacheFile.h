/*
 ============================================================================
 Name           : ZTCacheFile.h
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTCacheFile declaration
 ============================================================================
 */

#import "ZTPrecompile.h"
#import "ZTCacheProtocol.h"

/** 文件缓存默认有效期 */
static const int ZT_CACHE_FILE_EXPIRES = 7 * 24 * 60 * 60;

/**
 *ZTCacheFile:文件缓存
 *Author:Fighting
 **/
@interface ZTCacheFile : NSObject<ZTCacheProtocol>

/** 缓存用户 */
@property (nonatomic, strong) NSString * cacheUser;

/** 缓存路径 */
@property (nonatomic, readonly, strong) NSString * cachePath;

/** 有效期 */
@property (nonatomic, readonly, unsafe_unretained)   NSTimeInterval   cacheMaxAge;

ZT_SINGLETON_AS(ZTCacheFile)

@end
