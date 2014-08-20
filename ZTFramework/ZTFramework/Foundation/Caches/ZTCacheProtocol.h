/*
 ============================================================================
 Name           : ZTCacheProtocol.h
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTCache declaration
 ============================================================================
 */

#import <Foundation/Foundation.h>

@protocol ZTCacheProtocol <NSObject>

/**
 *  Key是否存在
 *
 *  @param key Key
 *
 *  @return BOOL
 */
- (BOOL)hasObjectForKey:(id)key;

/**
 *  根据Key获取对象
 *
 *  @param key Key
 *
 *  @return id
 */
- (id)objectForKey:(id)key;

/**
 *  设置数据
 *
 *  @param sender Value
 *  @param key    Key
 */
- (void)setObject:(id)sender key:(id)key;

/**
 *  根据Key删除对象
 *
 *  @param key Key
 */
- (void)removeObjectForKey:(id)key;

/**
 *  删除所有对象
 */
- (void)removeAllObject;

/**
 *  获取Key下的对象
 *
 *  @param key Key
 *
 *  @return id
 */
- (id)objectForKeyedSubscript:(id)key;

/**
 *  设置Key下的对象
 *
 *  @param obj id
 *  @param key id
 */
- (void)setObject:(id)obj forKeyedSubscript:(id)key;

@end
