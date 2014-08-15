/*
 ============================================================================
 Name           : ZTDebug.m
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTDebug declaration
 ============================================================================
 */

#import "ZTDebug.h"
#import "ZTPrecompile.h"
#import "ZTFoundation.h"

/****************************************************************/

#pragma mark - ZTDebug

@implementation ZTDebug

@end

/****************************************************************/

static void (*__sendEvent)( id, SEL, UIEvent * );

@implementation UIWindow (ZTDebug)

//加载
+ (void)load {
#if (1 == __ZTDEBUG__SHOWBORDER__ && TARGET_IPHONE_SIMULATOR)
    [UIWindow hookSendEvent];
#endif
}

//钩子发送事件
+ (void)hookSendEvent {
#if (1 == __ZTDEBUG__SHOWBORDER__ && TARGET_IPHONE_SIMULATOR)
    static BOOL falg = NO;
    
    if (YES == falg) {
        return;
    }
    
    Method method = ZT_COMMON_SwizzleInstanceMethod([UIWindow class], @selector(sendEvent:), @selector(mySendEvent:));
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



