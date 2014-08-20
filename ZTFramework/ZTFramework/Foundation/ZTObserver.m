/*
 ============================================================================
 Name           : ZTObserver.m
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTObserver declaration
 ============================================================================
 */

#import "ZTObserver.h"

void (* ZTObserver_action)(id, SEL, ...) = (void (*)(id, SEL, ...))objc_msgSend;

#undef  ZT_OBSERVER_NSOBJECT
#define ZT_OBSERVER_NSOBJECT "NSObject.ZTObserver.observer"

typedef NS_ENUM(NSInteger, ZT_OBSERVER_TYPE) {
    
    /** 参数只有new */
    ZT_OBSERVER_TYPE_NEW = 1,
    
    /** 参数只有new,old */
    ZT_OBSERVER_TYPE_NEW_OLD,
    
    /** 参数只有self,new */
    ZT_OBSERVER_TYPE_SELF_NEW,
    
    /** 参数只有self,new,old */
    ZT_OBSERVER_TYPE_SELF_NEW_OLD,
};

#pragma mark - ZTObserver

@interface ZTObserver()

/** 类别 */
@property (nonatomic, unsafe_unretained)    ZT_OBSERVER_TYPE    type;

/** 被观察的对象的值改变时后的响应方法所在的对象 */
@property (nonatomic, weak)                 id                  target;

/** 被观察的对象的值改变时后的响应方法所在的对象 */
@property (nonatomic, unsafe_unretained)    SEL                 selector;

/** 值改变时执行的block */
@property (nonatomic, copy)                 ZTObserver_block_sourceObject_new_old   block;

/** 被观察的对象 */
@property (nonatomic, unsafe_unretained)    id                  sourceObject;

/** 被观察的对象的keyPath */
@property (nonatomic, copy)                 NSString            *keyPath;

@end

@implementation ZTObserver

- (instancetype)initWithSourceObject:(id)sourceObject keyPath:(NSString *)keyPath target:(id)target selector:(SEL)selector type:(ZT_OBSERVER_TYPE)type {
    self = [super init];
    
    if (self) {
        _sourceObject = sourceObject;
        _keyPath = keyPath;
        _target = target;
        _selector = selector;
        _type = type;
        
        [_sourceObject addObserver:self forKeyPath:keyPath options:ZT_KVO_newANDold context:nil];
    }
    
    return self;
}

- (instancetype)initWithSourceObject:(id)sourceObject keyPath:(NSString*)keyPath block:(ZTObserver_block_sourceObject_new_old)block {
    self = [super init];
    
    if (self) {
        _sourceObject = sourceObject;
        _keyPath = keyPath;
        _block = block;
        
        [_sourceObject addObserver:self forKeyPath:keyPath options:ZT_KVO_newANDold context:nil];
    }
    
    return self;
}

- (void)dealloc {
    if (_sourceObject) {
        [_sourceObject removeObserver:self forKeyPath:_keyPath];
    }
}

//NSKeyValueObserver
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    ZT_WEAKSELF_DEF
    
    if (_block) {
        _block(wself, change[NSKeyValueChangeNewKey], change[NSKeyValueChangeOldKey]);
        return;
    }
    
    switch (_type) {
        case ZT_OBSERVER_TYPE_NEW: {
            ZTObserver_action(_target, _selector, change[NSKeyValueChangeNewKey]);
            break;
        }
        case ZT_OBSERVER_TYPE_NEW_OLD: {
            ZTObserver_action(_target, _selector, change[NSKeyValueChangeNewKey], change[NSKeyValueChangeOldKey]);
            break;
        }
        case ZT_OBSERVER_TYPE_SELF_NEW: {
            ZTObserver_action(_target, _selector, _sourceObject, change[NSKeyValueChangeNewKey]);
            break;
        }
        case ZT_OBSERVER_TYPE_SELF_NEW_OLD: {
            ZTObserver_action(_target, _selector, _sourceObject, change[NSKeyValueChangeNewKey], change[NSKeyValueChangeOldKey]);
            break;
        }
        default:
            break;
    }
}

@end

#pragma mark - NSObject+ZTObserver

@implementation NSObject (ZTObserver)

@dynamic observers;

- (id)observers {
    id object = objc_getAssociatedObject(self, ZT_OBSERVER_NSOBJECT);
    
    if (nil == object) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:8];
        
        //设置对象关联
        objc_setAssociatedObject(self, ZT_OBSERVER_NSOBJECT, dic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return dic;
    }
    
    return object;
}

//KVO观察者
- (void)observerWithObject:(id)sender property:(NSString *)property {
    SEL aSel = NSSelectorFromString([NSString stringWithFormat:@"%@New:", property]);
    
    if ([self respondsToSelector:aSel]) {
        [self observeWithObject:sender
                        keyPath:property
                         target:self
                       selector:aSel
                           type:ZT_OBSERVER_TYPE_NEW];
        return;
    }
    
    aSel = NSSelectorFromString([NSString stringWithFormat:@"%@New:old:", property]);
    
    if ([self respondsToSelector:aSel]) {
        [self observeWithObject:sender
                        keyPath:property
                         target:self
                       selector:aSel
                           type:ZT_OBSERVER_TYPE_NEW_OLD];
        return;
    }
    
    aSel = NSSelectorFromString([NSString stringWithFormat:@"%@In:new:", property]);
    
    if ([self respondsToSelector:aSel]) {
        [self observeWithObject:sender
                        keyPath:property
                         target:self
                       selector:aSel
                           type:ZT_OBSERVER_TYPE_SELF_NEW];
        return;
    }
    
    aSel = NSSelectorFromString([NSString stringWithFormat:@"%@In:new:old:", property]);
    
    if ([self respondsToSelector:aSel]) {
        [self observeWithObject:sender
                        keyPath:property
                         target:self
                       selector:aSel
                           type:ZT_OBSERVER_TYPE_SELF_NEW_OLD];
        return;
    }
}

- (void)observerWithObject:(id)sender property:(NSString *)property block:(ZTObserver_block_sourceObject_new_old)block {
    [self observeWithObject:sender keyPath:property block:block];
}

//KVO删除
- (void)removeObserverWithObject:(id)sender property:(NSString *)property {
    NSString *key = [NSString stringWithFormat:@"%@_%@", sender, property];
    
    ZTLogD(@"kvo remove key ===> %@", key);
    
    [self.observers removeObjectForKey:key];
}

- (void)removeObserverWithObject:(id)sender {
    NSString *prefix = [NSString stringWithFormat:@"%@", sender];
    
    [self.observers enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([key hasPrefix:prefix]) {
            [self.observers removeObjectForKey:key];
            ZTLogD(@"kvo remove key ===> %@", key);
        }
    }];
}

- (void)removeAllObserver {
    [self.observers removeAllObjects];
    
    ZTLogD(@"kvo remove Allkey");
}

#pragma mark - Private

- (void)observeWithObject:(id)object keyPath:(NSString *)keyPath target:(id)target selector:(SEL)selector type:(ZT_OBSERVER_TYPE)type {
    NSAssert([target respondsToSelector:selector], @"selector 必须存在");
    NSAssert(keyPath.length > 0, @"keyPath 必须存在");
    NSAssert(object, @"观察者对象 object 必须存在");
    
    ZTObserver *ob = [[ZTObserver alloc] initWithSourceObject:object
                                                              keyPath:keyPath
                                                               target:target
                                                             selector:selector
                                                                 type:type];
    
    NSString *key = [NSString stringWithFormat:@"%@_%@", object, keyPath];
    
    ZTLogD(@"observer key ===> %@", key);
    
    [self.observers setObject:ob forKey:key];
}

- (void)observeWithObject:(id)object keyPath:(NSString *)keyPath block:(ZTObserver_block_sourceObject_new_old)block {
    NSAssert(block, @"block 必须存在");
    
    ZTObserver *ob = [[ZTObserver alloc] initWithSourceObject:object keyPath:keyPath block:block];
    
    NSString *key = [NSString stringWithFormat:@"%@_%@", object, keyPath];
    
    ZTLogD(@"observer key ===> %@", key);
    
    [self.observers setObject:ob forKey:key];
}

@end