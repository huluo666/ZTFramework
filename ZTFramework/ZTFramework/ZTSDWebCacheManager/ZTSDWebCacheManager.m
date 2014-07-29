/*
 ============================================================================
 Name           : ZTSDWebCacheManager.m
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTSDWebCacheManager declaration
 ============================================================================
 */

#import "ZTSDWebCacheManager.h"
#import "SDImageCache.h"

@implementation ZTSDWebCacheManager

//清空缓存
+ (void)cacheClear:(ZTSDWebCacheManagerBlock)block {
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        if (block) {
            block();
        }
    }];
    
    [[SDImageCache sharedImageCache] clearMemory];
}

//缓存大小
+ (NSString *)cacheSize {
    return [NSString stringWithFormat:@"%.2fM", ([[SDImageCache sharedImageCache] getSize] / 1024.0f / 1024.0f)];
}

@end
