/*
 ============================================================================
 Name           : ZTNotification.m
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTNotification declaration
 ============================================================================
 */

#import "ZTNotification.h"

#pragma mark - ZTNotification

/** 通知对象 */
#undef ZT_NOTIFICATION_NSOBJECT
#define ZT_NOTIFICATION_NSOBJECT    "NSObject.ZTNotification.notification"

/** 发送消息通知 */
void (*ZTNotification_action)(id, SEL, ...) = (void (*)(id, SEL, ...))objc_msgSend;

@interface ZTNotification()

/** 目标 */
@property (nonatomic, ZT_ARC_WEAK) id target;

/** 事件 */
@property (nonatomic, unsafe_unretained) SEL selector;

/** 触发对象 */
@property (nonatomic, ZT_ARC_WEAK) id  sender;

/** 名称 */
@property (nonatomic, copy) NSString * name;

/** 回调 */
@property (nonatomic, copy) ZTNotification_block block;

@end

@implementation ZTNotification

/** 初始化 */
- (instancetype)initWithName:(NSString *)name sender:(id)sender target:(id)target selector:(SEL)selector {
    
    self = [super init];
    
    if (self) {
        _name = name;
        _sender = sender;
        _target = target;
        _selector = selector;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(handleNotification:)
                                                     name:name
                                                   object:sender];
    }
    
    return self;
}

- (instancetype)initWithName:(NSString *)name sender:(id)sender block:(ZTNotification_block)block{
    self = [super init];
    if (self) {
        _name = name;
        _sender = sender;
        _block = block;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(handleNotification:)
                                                     name:name object:sender];
    }
    return self;
}

/** 通知handle */
- (void)handleNotification:(NSNotification *)notification {
    if (_block) {
        _block(notification);
        return;
    }
    
    ZTNotification_action(_target, _selector, notification);
}

- (void)dealloc {
    
    ZTLogD(@"notification dealloc ===> %@", _name);
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_name object:nil];
}

@end

#pragma mark - NSObject+ZTNotification

@implementation NSObject (ZTNotification)

@dynamic notifications;

- (id)notifications {
    
    id object = objc_getAssociatedObject(self, ZT_NOTIFICATION_NSOBJECT);
    
    if (nil == object) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:8];
        objc_setAssociatedObject(self, ZT_NOTIFICATION_NSOBJECT, dic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return dic;
    }
    
    return object;
}

//注册通知
- (void)registerNotification:(NSString *)name {
    SEL _sel = NSSelectorFromString([NSString stringWithFormat:@"%@NotificationHandle:", name]);

    if (![self respondsToSelector:_sel]) {
        return;
    }
    
    [self notificationWithName:name target:self selector:_sel];
}

//注册通知
- (void)registerNotification:(NSString *)name block:(ZTNotification_block)block {
    [self notificationWihtName:name block:block];
}

//注销通知
- (void)unregisterNotification:(NSString *)name {
    NSString *key = [NSString stringWithFormat:@"%@", name];
    [self.notifications removeObjectForKey:key];
}

//注销所有通知
- (void)unregisterAllNotification {
    [self.notifications removeAllObjects];
}

//发送通知
- (void)postNotification:(NSString *)name userInfo:(id)userInfo {
    
    ZTLogD(@"notification post name ===> %@", name);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:self userInfo:userInfo];
}

#pragma mark - Private

- (void)notificationWithName:(NSString *)name target:(id)target selector:(SEL)selector {
    ZTNotification *ztNotification = [[ZTNotification alloc] initWithName:name sender:nil target:target selector:selector];
    NSString *key = [NSString stringWithFormat:@"%@", name];
    
    ZTLogD(@"notification register key ===> %@", key);
    
    [self.notifications setObject:ztNotification forKey:key];
}

-(void) notificationWihtName:(NSString *)name block:(ZTNotification_block)block{
    ZTNotification *notification = [[ZTNotification alloc] initWithName:name sender:nil block:block];
    
    NSString *key = [NSString stringWithFormat:@"%@", name];
    
    ZTLogD(@"notification register key ===> %@", key);
    
    [self.notifications setObject:notification forKey:key];
}

@end