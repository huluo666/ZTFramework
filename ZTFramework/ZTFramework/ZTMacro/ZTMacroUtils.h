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






//----------------------简易方法----------------------

/** appDelegate */
#define mAppDelegate                (AppDelegate *)[[UIApplication sharedApplication] delegate]

/** Window */
#define mWindow                     [[[UIApplication sharedApplication] windows] lastObject]

/** KeyWindow */
#define mKeyWindow                  [[UIApplication sharedApplication] keyWindow]

/** UserDefaults */
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









//----------------------单例模式宏----------------------
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





//----------------------非ARC 宏----------------------
#ifndef PX_STRONG
#if __has_feature(objc_arc)
#define PX_STRONG strong
#else
#define PX_STRONG retain
#endif
#endif

#ifndef PX_WEAK
#if __has_feature(objc_arc_weak)
#define PX_WEAK weak
#elif __has_feature(objc_arc)
#define PX_WEAK unsafe_unretained
#else
#define PX_WEAK assign
#endif
#endif

#if __has_feature(objc_arc)
#define PX_AUTORELEASE(expression) expression
#define PX_RELEASE(expression) expression
#define PX_RETAIN(expression) expression
#else
#define PX_AUTORELEASE(expression) [expression autorelease]
#define PX_RELEASE(expression) [expression release]
#define PX_RETAIN(expression) [expression retain]
#endif





//----------------------DEBUG  模式下打印日志,当前行----------------------
#ifndef __OPTIMIZE__
#define TCLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#define NSLog(FORMAT, ...) fprintf(stderr,"\nfunction:%s line:%d content:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define TCLog(fmt, ...)
#define NSLog(FORMAT, ...) {}
#endif



#endif
