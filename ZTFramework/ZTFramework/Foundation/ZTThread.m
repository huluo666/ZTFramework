/*
 ============================================================================
 Name           : ZTThread.m
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTThread declaration
 ============================================================================
 */


#import "ZTThread.h"

/** 后端任务队列名称 */
static const char backTaskQueueName[32] = "com.zt.taskQueue";

@interface ZTThread() {
    
    /** 前端 */
    dispatch_queue_t _foreQueue;
    
    /** 后端线程 */
    dispatch_queue_t _backQueue;
}

ZT_SINGLETON_AS(ZTThread);

@end

@implementation ZTThread

ZT_SINGLETON_DEF(ZTThread);

- (id)init {
    
    self = [super init];
    
    if (self) {
        _foreQueue = dispatch_get_main_queue();
        
        _backQueue = dispatch_queue_create(backTaskQueueName, nil);
    }
    
    return self;
}

//得到前端线程队列
+ (dispatch_queue_t)foreQueue {
    return [[ZTThread sharedInstance] foreQueue];
}

- (dispatch_queue_t)foreQueue {
    return _foreQueue;
}

//得到后端线程队列
+ (dispatch_queue_t)backQueue {
    return [[ZTThread sharedInstance] backQueue];
}

- (dispatch_queue_t)backQueue {
    return _backQueue;
}

//前端线程异步执行
+ (void)enqueueForeground:(dispatch_block_t)block {
    [[ZTThread sharedInstance] enqueueForeground:block];
}

- (void)enqueueForeground:(dispatch_block_t)block {
    dispatch_async(_foreQueue, block);
}

//后端线程异步执行
+ (void)enqueueBackground:(dispatch_block_t)block {
    [[ZTThread sharedInstance] enqueueBackground:block];
}

- (void)enqueueBackground:(dispatch_block_t)block {
    dispatch_async(_backQueue, block);
}

//前端线程异步执行
+ (void)enqueueForegroundWithDelay:(dispatch_time_t)ms block:(dispatch_block_t)block {
    [[ZTThread sharedInstance] enqueueForegroundWithDelay:ms block:block];
}

- (void)enqueueForegroundWithDelay:(dispatch_time_t)ms block:(dispatch_block_t)block {
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, ms * USEC_PER_SEC);
    dispatch_after(time, _foreQueue, block);
}

//后端线程异步执行
+ (void)enqueueBackgroundWithDelay:(dispatch_time_t)ms block:(dispatch_block_t)block {
    [[ZTThread sharedInstance] enqueueBackgroundWithDelay:ms block:block];
}

- (void)enqueueBackgroundWithDelay:(dispatch_time_t)ms block:(dispatch_block_t)block {
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, ms * USEC_PER_SEC);
    dispatch_after(time, _backQueue, block);
}

@end
