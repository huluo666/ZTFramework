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
    #undef      TCLog
    #undef      NSLog
    #define     TCLog(fmt, ...)     NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
    #define     NSLog(FORMAT, ...)  fprintf(stderr,"\nfunction:%s line:%d content:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
    #define     NSLogSelf           NSLog(@"Class: %@", NSStringFromClass([self class]));
#else
    #define     TCLog(fmt, ...)
    #define     NSLog(FORMAT, ...) {}
    #define     NSLogSelf
#endif

/**
 *ZTDebug:调试文件
 *Author:Fighting
 **/
@interface ZTDebug : NSObject
@end