/*
 ============================================================================
 Name           : ZTCacheMemory.m
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTCacheFile declaration
 ============================================================================
 */

#import "ZTCacheMemory.h"

@interface ZTCacheMemory()

/** 缓存key */
@property (nonatomic, strong) NSMutableArray * cacheKeys;

/** 缓存对象 */
@property (nonatomic, strong) NSMutableDictionary * cacheObjs;

/** 缓存总数 */
@property (nonatomic, unsafe_unretained) int cacheCount;

@end

@implementation ZTCacheMemory

ZT_SINGLETON_DEF(ZTCacheMemory)

#pragma mark - Private

- (id)init {
    self = [super init];
    
    if (self) {
        
        _cacheCount = 0;
        
        _cacheKeys = [[NSMutableArray alloc] init];
        _cacheObjs = [[NSMutableDictionary alloc] init];
        
#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(handleMemoryCacheNotification:)
                                                     name:UIApplicationDidReceiveMemoryWarningNotification
                                                   object:nil];
#endif
    }
    
    return self;
}

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Delegate

//Key是否存在
- (BOOL)hasObjectForKey:(id)key {
    return [_cacheObjs objectForKey:key] ? YES : NO;
}

//根据Key获取对象
- (id)objectForKey:(id)key {
    return [_cacheObjs objectForKey:key];
}

//设置数据
- (void)setObject:(id)sender key:(id)key {
    if (nil == key || nil == sender) {
        return;
    }
    
    _cacheCount++;
    
    while (_cacheCount >= ZT_CACHE_MEMORY_MAX_COUNT) {
        NSString *tmpKey = [_cacheKeys objectAtIndex:0];
        
        [_cacheObjs removeObjectForKey:tmpKey];
        [_cacheKeys removeObjectAtIndex:0];
        
        _cacheCount--;
    }
    
    [_cacheKeys addObject:key];
    [_cacheObjs setValue:sender forKeyPath:key];
}

//根据Key删除对象
- (void)removeObjectForKey:(id)key {
    if (![self hasObjectForKey:key]) {
        return;
    }
    
    [_cacheKeys removeObjectIdenticalTo:key];
    [_cacheObjs removeObjectForKey:key];
    _cacheCount--;
}

//删除所有对象
- (void)removeAllObject {
    [_cacheKeys removeAllObjects];
    [_cacheObjs removeAllObjects];
    _cacheCount = 0;
}

//获取Key下的对象
- (id)objectForKeyedSubscript:(id)key {
    return [self objectForKey:key];
}

//设置Key下的对象
- (void)setObject:(id)obj forKeyedSubscript:(id)key {
    [self setObject:obj key:key];
}

//内存通知
- (void)handleMemoryCacheNotification:(NSNotification *)notification {
#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
	if (![notification.name isEqualToString:UIApplicationDidReceiveMemoryWarningNotification]) {
        return;
	}
    
    [self removeAllObject];
#endif
}

@end
