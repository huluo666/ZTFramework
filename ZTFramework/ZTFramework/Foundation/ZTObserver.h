/*
 ============================================================================
 Name           : ZTObserver.h
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTObserver declaration
 ============================================================================
 */

#import "ZTPrecompile.h"

#undef  ZT_KVO_NAME

/** KVO名称 */
#define ZT_KVO_NAME(__name)         ZT_TEXT(__name)

/** KVO方法 */
#define	ZT_KVO_ON_1(__property)     -(void) __property##New:(id)newValue
#define	ZT_KVO_ON_2(__property)     -(void) __property##New:(id)newValue old:(id)oldValue
#define	ZT_KVO_ON_3(__property)     -(void) __property##In:(id)sourceObject new:(id)newValue
#define	ZT_KVO_ON_4(__property)     -(void) __property##In:(id)sourceObject new:(id)newValue old:(id)oldValue

/** KVO设置 */
#define ZT_KVO_newANDold            (NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld)

typedef void(^ZTObserver_block_sourceObject_new_old)(id sourceObject, id newValue, id oldValue);

/**
 *ZTObserver:KVO封装
 *Author:Fighting
 **/
@interface ZTObserver : NSObject

@end

@interface NSObject (ZTObserver)

/** 所有观察对象 */
@property (nonatomic, readonly, strong) NSMutableDictionary *observers;

/**
 *  KVO观察
 *
 *  @param sender   被观察的对象 - self
 *  @param property 被观察的属性 - keypath
 */
- (void)observerWithObject:(id)sender property:(NSString*)property;

/**
 *  KVO观察
 *
 *  @param sender   被观察的对象 - self
 *  @param property 被观察的属性 - keypath
 *  @param block    回调
 */
- (void)observerWithObject:(id)sender property:(NSString*)property block:(ZTObserver_block_sourceObject_new_old)block;

/**
 *  删除KVO观察
 *
 *  @param sourceObject 被观察的对象 - self
 *  @param property     被观察的属性 - keypath
 */
- (void)removeObserverWithObject:(id)sender property:(NSString *)property;

/**
 *  删除KVO观察
 *
 *  @param sender 被观察的对象 - self
 */
- (void)removeObserverWithObject:(id)sender;

/**
 *  删除所有KVO观察
 */
- (void)removeAllObserver;

@end


