/*
 ============================================================================
 Name           : ZTThread.h
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTThread declaration
 ============================================================================
 */

#import "ZTPrecompile.h"

/** GCD-前端线程 */
#define FOREGROUND_BEGIN		[ZTThread enqueueForeground:^{
#define FOREGROUND_BEGIN_(x)	[ZTThread enqueueForegroundWithDelay:(dispatch_time_t)x block:^{
#define FOREGROUND_COMMIT		}];

/** GCD-后端线程 */
#define BACKGROUND_BEGIN		[ZTThread enqueueBackground:^{
#define BACKGROUND_BEGIN_(x)	[ZTThread enqueueBackgroundWithDelay:(dispatch_time_t)x block:^{
#define BACKGROUND_COMMIT		}];

/**
 *ZTThread:GCD线程
 *Author:Fighting
 **/
@interface ZTThread : NSObject

/**
 *  得到前端线程队列
 *
 *  @return dispatch_queue_t
 */
+ (dispatch_queue_t)foreQueue;

/**
 *  得到后端线程队列
 *
 *  @return dispatch_queue_t
 */
+ (dispatch_queue_t)backQueue;

/**
 *  前端线程异步执行
 *
 *  @param block dispatch_block_t
 */
+ (void)enqueueForeground:(dispatch_block_t)block;

/**
 *  后端线程异步执行
 *
 *  @param block dispatch_block_t
 */
+ (void)enqueueBackground:(dispatch_block_t)block;

/**
 *  前端线程异步执行
 *
 *  @param ms    等待时间
 *  @param block dispatch_block_t
 */
+ (void)enqueueForegroundWithDelay:(dispatch_time_t)ms block:(dispatch_block_t)block;

/**
 *  后端线程异步执行
 *
 *  @param ms    等待时间
 *  @param block dispatch_block_t
 */
+ (void)enqueueBackgroundWithDelay:(dispatch_time_t)ms block:(dispatch_block_t)block;

@end
