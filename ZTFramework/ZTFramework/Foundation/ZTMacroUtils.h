/*
 ============================================================================
 Name           : ZTMacroUtils.h
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTMacroUtils declaration
 ============================================================================
 */

#ifndef ZTFramework_ZTMacroUtils_h
#define ZTFramework_ZTMacroUtils_h

/******************************************************************/

//单例模式宏
#undef  ZTSingleton
#define ZTSingleton(classname) \
\
static classname *shared##classname = nil; \
\
+ (classname *)shared##Instance \
{ \
@synchronized(self) \
{ \
if (shared##classname == nil) \
{ \
shared##classname = [[self alloc] init]; \
} \
} \
\
return shared##classname; \
} \
\
+ (instancetype)allocWithZone:(NSZone *)zone \
{ \
@synchronized(self) \
{ \
if (shared##classname == nil) \
{ \
shared##classname = [super allocWithZone:zone]; \
return shared##classname; \
} \
} \
\
return nil; \
} \
\
- (instancetype)copyWithZone:(NSZone *)zone \
{ \
return self; \
} \
\







/******************************************************************/

// 宏定义字符串 转NSString, __TEXT( __x )
#undef __TEXT
#undef __TEXT_intermediary
#define __TEXT( __x ) __TEXT_intermediary( __x )
#define __TEXT_intermediary(x) @#x








/******************************************************************/

// block 安全self
#if __has_feature(objc_arc)
// arc
#define DEF_WEAKSELF    __weak __typeof(self) wself = self;
#define DEF_WEAKSELF_( __CLASSNAME__ )      __weak typeof( __CLASSNAME__ *) wself = self;
#else
// mrc
#define DEF_WEAKSELF     __block typeof(id) wself = self;
#define DEF_WEAKSELF_( __CLASSNAME__ )     __block typeof( __CLASSNAME__ *) wself = self;
#endif





/******************************************************************/

// 执行一次
#undef	ZT_ONCE_BEGIN
#define ZT_ONCE_BEGIN( __name ) \
static dispatch_once_t once_##__name; \
dispatch_once( &once_##__name , ^{

#undef	ZT_ONCE_END
#define ZT_ONCE_END		});
















/******************************************************************/

// arc mrc 兼容
#if __has_feature(objc_arc)
#define ZT_AUTORELEASE(exp) exp
#define ZT_RELEASE(exp)     exp
#define ZT_RETAIN(exp)      exp
#define ZT_STRONG           strong
#else
#define ZT_AUTORELEASE(exp) [exp autorelease]
#define ZT_RELEASE(exp)     [exp release]
#define ZT_RETAIN(exp)      [exp retain]
#define ZT_STRONG           retain
#endif

#if __has_feature(objc_arc_weak)
#define ZT_WEAK             weak
#elif __has_feature(objc_arc)
#define ZT_WEAK             unsafe_unretained
#else
#define ZT_WEAK             assign
#endif






/******************************************************************/

//颜色
#define mRGBColor(r, g, b)          [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(1)]
#define mRGBAColor(r, g, b, a)      [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]








/******************************************************************/

/** appDelegate */
#define mAppDelegate                (AppDelegate *)[[UIApplication sharedApplication] delegate]

/** Window */
#define mWindow                     [[[UIApplication sharedApplication] windows] lastObject]

/** KeyWindow */
#define mKeyWindow                  [[UIApplication sharedApplication] keyWindow]

/** NSUserDefaults */
#define mUserDefaults               [NSUserDefaults standardUserDefaults]

/** NotificationCenter */
#define mNotificationCenter         [NSNotificationCenter defaultCenter]

/** 文字排版兼容处理 */
#ifdef __IPHONE_OS_VERSION_MIN_REQUIRED
#define ZTTextAlignmentLeft             NSTextAlignmentLeft
#define ZTTextAlignmentCenter           NSTextAlignmentCenter
#define ZTTextAlignmentRight            NSTextAlignmentRight
#define ZTLineBreakModeCharaterWrap     NSLineBreakByCharWrapping
#define ZTLineBreakModeWordWrap         NSLineBreakByWordWrapping
#define ZTLineBreakModeClip             NSLineBreakByClipping
#define ZTLineBreakModeTruncatingHead   NSLineBreakByTruncatingHead
#define ZTLineBreakModeTruncatingMiddle NSLineBreakByTruncatingMiddle
#define ZTLineBreakModeTruncatingTail   NSLineBreakByTruncatingTail
#else
#define ZTTextAlignmentLeft             UITextAlignmentLeft
#define ZTTextAlignmentCenter           UITextAlignmentCenter
#define ZTTextAlignmentRight            UITextAlignmentRight
#define ZTLineBreakModeCharaterWrap     UILineBreakModeCharacterWrap
#define ZTLineBreakModeWordWrap         UILineBreakModeWordWrap
#define ZTLineBreakModeClip             UILineBreakModeClip
#define ZTLineBreakModeTruncatingHead   UILineBreakModeHeadTruncation
#define ZTLineBreakModeTruncatingMiddle UILineBreakModeMiddleTruncation
#define ZTLineBreakModeTruncatingTail   UILineBreakModeTailTruncation
#endif

//判断是否为null
UIKIT_STATIC_INLINE const BOOL mIsNull(id str) {
    if (str == nil || (NSNull *)str == [NSNull null]) {
        return YES;
    }
    
    return NO;
}

/** 加载图片 */
UIKIT_STATIC_INLINE UIImage * mImageByPath(NSString *name, NSString *ext) {
    
    if (mIsNull(name)) {
        return nil;
    }
    
    return [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:name ofType:ext]];
}

/** 加载图片 */
UIKIT_STATIC_INLINE UIImage * mImageByName(NSString *img) {
    
    if (mIsNull(img)) {
        return nil;
    }
    
    return mImageByPath(img, @"png");
}






























#endif
