/*
 ============================================================================
 Name           : UIWindow+ZTDebug.h
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : UIWindow+ZTDebug declaration
 ============================================================================
 */

#import "UIWindow+ZTDebug.h"
#import "ZTPrecompile.h"

/****************************************************************/

#pragma mark - UIWindow+ZTDebug

/**
 *  劫持类方法
 *
 *  @param c           类
 *  @param original    原方法
 *  @param replacement 劫持后的方法
 *
 *  @return 返回劫持前的方法original
 */
static Method ZTSwizzleInstanceMethod(Class c, SEL original, SEL replacement) {
    Method a = class_getInstanceMethod(c, original);
    Method b = class_getInstanceMethod(c, replacement);
    
    // class_addMethod 为该类增加一个新方法
    if (class_addMethod(c, original, method_getImplementation(b), method_getTypeEncoding(b))) {
        // 替换类方法的定义
        class_replaceMethod(c, replacement, method_getImplementation(a), method_getTypeEncoding(a));
        return b;   // 返回劫持前的方法
    }
    
    // 交换2个方法的实现
    method_exchangeImplementations(a, b);
    return b;   // 返回劫持前的方法
}

static void (*__sendEvent)( id, SEL, UIEvent * );

@implementation UIWindow (ZTDebug)

//加载
+ (void)load {
#if (1 == __ZTDEBUG__SHOWBORDER__)
    [UIWindow hookSendEvent];
#endif
}

//钩子发送事件
+ (void)hookSendEvent {
#if (1 == __ZTDEBUG__SHOWBORDER__)
    static BOOL falg = NO;
    
    if (YES == falg) {
        return;
    }
    
    Method method = ZTSwizzleInstanceMethod([UIWindow class], @selector(sendEvent:), @selector(mySendEvent:));
    __sendEvent = (void *) method_getImplementation(method);
    falg = YES;
#endif
}

//截止后点击的方法
- (void)mySendEvent:(UIEvent *)event {
    UIWindow * keyWindow = [UIApplication sharedApplication].keyWindow;
    
    if (self == keyWindow && UIEventTypeTouches == event.type) {
        
        NSSet * allTouches = [event allTouches];
        
        if (1 == [allTouches count]) {
            UITouch * touch = [[allTouches allObjects] objectAtIndex:0];
            
            if (1 == [touch tapCount] && UITouchPhaseBegan == touch.phase) {
                ZTDebugBorder * border = [[ZTDebugBorder alloc] initWithFrame:touch.view.bounds];
                [touch.view addSubview:border];
                [border startAnimation];
            }
        }
    }
    
    if (__sendEvent) {
        __sendEvent(self, _cmd, event);
    }
}

@end

/****************************************************************/

#pragma mark - ZTDebugBorder

@implementation ZTDebugBorder

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor clearColor];
		self.userInteractionEnabled = NO;
		self.layer.borderWidth = 2.0f;
		self.layer.borderColor = [UIColor redColor].CGColor;
    }
    
    return self;
}

- (void)didMoveToSuperview {
	self.layer.cornerRadius = self.superview.layer.cornerRadius;
}

//启动动画
- (void)startAnimation {
    self.alpha = 1.0f;
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveLinear];
	[UIView setAnimationDuration:.75f];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(didAppearingAnimationStopped)];
	
	self.alpha = 0.0f;
    
	[UIView commitAnimations];
}

- (void)didAppearingAnimationStopped {
	[self removeFromSuperview];
}

@end
