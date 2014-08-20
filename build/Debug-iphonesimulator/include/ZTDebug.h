/*
 ============================================================================
 Name           : ZTDebug.h
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTDebug declaration
 ============================================================================
 */

/** 仅在DEBUG下显示NSLOG */
#if (1 == __ZTDEBUG__)
    #undef      ZTLog
    #undef      ZTLogD
    #undef      NSLog
    #define     ZTLog(fmt, ...)         ZTLogD((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
    #define     ZTLogD(FORMAT, ...)     fprintf(stderr,"\nfunction:%s line:%d content:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
    #define     ZTLogSelf               ZTLogD(@"Class: %@", NSStringFromClass([self class]));
    #define     NSLog(fmt, ...)         ZTLogD(fmt, ##__VA_ARGS__);
#else
    #define     ZTLog(fmt, ...)
    #define     ZTLogD(FORMAT, ...)
    #define     ZTLogSelf
    #define     NSLog(fmt, ...)
#endif

#pragma mark - ZTDebug

/**
 *ZTDebug:调试文件
 *Author:Fighting
 **/
@interface ZTDebug : NSObject
@end


/**
 *UIWindow+ZTDebug:Debug监听window
 *Author:Fighting
 **/
@interface UIWindow (ZTDebug)
@end

/**
 *ZTDebugBorder:点击边框
 *Author:Fighting
 **/
@interface ZTDebugBorder : UIView

/** 启动动画 */
- (void)startAnimation;

@end
