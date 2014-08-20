/*
 ============================================================================
 Name           : ZTCacheFile.m
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTCacheFile declaration
 ============================================================================
 */

#import "ZTCacheFile.h"
#import "ZTSandbox.h"
#import "ZTSystemInfo.h"
#import "NSObject+ZT.h"

@implementation ZTCacheFile

ZT_SINGLETON_DEF(ZTCacheFile)


#pragma mark - Private

- (id)init {
    self = [super init];
    
    if (self) {
        
        _cacheUser = @"";
        
        _cachePath = [NSString stringWithFormat:@"%@/%@/Cache/", [ZTSandbox libCachePath], [ZTSystemInfo appVersion]];
        
        _cacheMaxAge =  ZT_CACHE_FILE_EXPIRES;
    }
    
    return self;
}

//根据文件名获取KEY
- (NSString *)fileNameForKey:(NSString *)key {
    NSString * pathName = _cachePath;
    
    if (_cacheUser && 0 < _cacheUser.length) {
        pathName = [_cachePath stringByAppendingFormat:@"%@/", _cacheUser];
    }
    
    [ZTSandbox touch:pathName];
    
    pathName = [pathName stringByAppendingString:key];
    
    NSTimeInterval time = [[[[NSFileManager defaultManager] attributesOfItemAtPath:pathName error:nil] fileModificationDate] timeIntervalSinceNow];
    
    if (time + _cacheMaxAge < 0) {
        pathName = nil;
        
        [[NSFileManager defaultManager] removeItemAtPath:pathName error:nil];
    }
    
    return pathName;
}

- (void)dealloc {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

#pragma mark - Public

#pragma mark - Delegate

//Key是否存在
- (BOOL)hasObjectForKey:(id)key {
    return [[NSFileManager defaultManager] fileExistsAtPath:[self fileNameForKey:key]];
}

//获取缓存值
- (id)objectForKey:(id)key {
    return [NSData dataWithContentsOfFile:[self fileNameForKey:key]];
}

//设置对象值
- (void)setObject:(id)sender key:(id)key {
    if (nil == sender) {
        [self removeObjectForKey:key];
        return;
    }
    
    NSData *data = [sender asNSData];
    
    if (data) {
        [data writeToFile:[self fileNameForKey:key]
                  options:NSDataWritingAtomic
                    error:NULL];
    }
}

//删除key缓存
- (void)removeObjectForKey:(id)key {
    [[NSFileManager defaultManager] removeItemAtPath:[self fileNameForKey:key] error:nil];
}

//清除所有缓存
- (void)removeAllObject {
	[[NSFileManager defaultManager] removeItemAtPath:_cachePath error:NULL];
	[[NSFileManager defaultManager] createDirectoryAtPath:_cachePath
							  withIntermediateDirectories:YES
											   attributes:nil
													error:NULL];
}

//获取Key下的对象
- (id)objectForKeyedSubscript:(id)key {
    return [self objectForKey:key];
}

//设置Key下的对象
- (void)setObject:(id)obj forKeyedSubscript:(id)key {
    [self setObject:obj key:key];
}

@end
