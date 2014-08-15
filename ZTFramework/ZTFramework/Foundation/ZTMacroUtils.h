/*
 ============================================================================
 Name           : ZTMacroUtils.h
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTMacroUtils declaration
 ============================================================================
 */

/**
 *ZTMacroUtils:工具宏
 *Author:Fighting
 **/

#ifndef ZTFramework_ZTMacroUtils_h
#define ZTFramework_ZTMacroUtils_h

/******************************************************************/
// 单例模式
#undef	ZT_SINGLETON_AS
#define ZT_SINGLETON_AS( __class ) \
+ (__class *)sharedInstance;
//+ (void) purgeSharedInstance;

#undef	ZT_SINGLETON_DEF
#define ZT_SINGLETON_DEF( __class ) \
+ (__class *)sharedInstance \
{ \
static dispatch_once_t once; \
static __class * __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[self alloc] init]; } ); \
return __singleton__; \
}





/**************************************************************/
// GCD 多线程
#define ZT_GCD_MainFun(aFun) dispatch_async( dispatch_get_main_queue(), ^(void){aFun;} );
#define ZT_GCD_MainBlock(block) dispatch_async( dispatch_get_main_queue(), block );

#define ZT_GCD_BackGroundBlock(block) dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block );
#define ZT_GCD_BackGroundFun(aFun) dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){aFun;} );







/******************************************************************/

// 宏定义字符串 转NSString, ZT_TEXT( __x )
#undef  ZT_TEXT
#undef  ZT_TEXT_intermediary
#define ZT_TEXT( __x ) ZT_TEXT_intermediary( __x )
#define ZT_TEXT_intermediary(x) @#x








/******************************************************************/

// block 安全self
#if __has_feature(objc_arc)
// arc
#define ZT_WEAKSELF_DEF    __weak __typeof(self) wself = self;
#define ZT_WEAKSELF_DEF_( __CLASSNAME__ )      __weak typeof( __CLASSNAME__ *) wself = self;
#else
// mrc
#define ZT_WEAKSELF_DEF     __block typeof(id) wself = self;
#define ZT_WEAKSELF_DEF_( __CLASSNAME__ )     __block typeof( __CLASSNAME__ *) wself = self;
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
#define ZT_ARC_AUTORELEASE(exp) exp
#define ZT_ARC_RELEASE(exp)     exp
#define ZT_ARC_RETAIN(exp)      exp
#define ZT_ARC_STRONG           strong
#else
#define ZT_ARC_AUTORELEASE(exp) [exp autorelease]
#define ZT_ARC_RELEASE(exp)     [exp release]
#define ZT_ARC_RETAIN(exp)      [exp retain]
#define ZT_ARC_STRONG           retain
#endif

#if __has_feature(objc_arc_weak)
#define ZT_ARC_WEAK             weak
#elif __has_feature(objc_arc)
#define ZT_ARC_WEAK             unsafe_unretained
#else
#define ZT_ARC_WEAK             assign
#endif






/******************************************************************/

//颜色
#define ZT_M_RGBColor(r, g, b)          [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.000f]
#define ZT_M_RGBAColor(r, g, b, a)      [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]






/******************************************************************/

//NSUserDefaults
#define ZT_M_UserDefaults               [NSUserDefaults standardUserDefaults]










/******************************************************************/

//appDelegate
#define ZT_M_AppDelegate                (AppDelegate *)[[UIApplication sharedApplication] delegate]

//Window
#define ZT_M_Window                     [[[UIApplication sharedApplication] windows] lastObject]

//KeyWindow
#define ZT_M_KeyWindow                  [[UIApplication sharedApplication] keyWindow]








/******************************************************************/

/** 文字排版兼容处理 */
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 60000
#define ZT_Text_AlignmentLeft             NSTextAlignmentLeft
#define ZT_Text_AlignmentCenter           NSTextAlignmentCenter
#define ZT_Text_AlignmentRight            NSTextAlignmentRight
#define ZT_Line_BreakModeCharaterWrap     NSLineBreakByCharWrapping
#define ZT_Line_BreakModeWordWrap         NSLineBreakByWordWrapping
#define ZT_Line_BreakModeClip             NSLineBreakByClipping
#define ZT_Line_BreakModeTruncatingHead   NSLineBreakByTruncatingHead
#define ZT_Line_BreakModeTruncatingMiddle NSLineBreakByTruncatingMiddle
#define ZT_Line_BreakModeTruncatingTail   NSLineBreakByTruncatingTail
#else
#define ZT_Text_AlignmentLeft             UITextAlignmentLeft
#define ZT_Text_AlignmentCenter           UITextAlignmentCenter
#define ZT_Text_AlignmentRight            UITextAlignmentRight
#define ZT_Line_BreakModeCharaterWrap     UILineBreakModeCharacterWrap
#define ZT_Line_BreakModeWordWrap         UILineBreakModeWordWrap
#define ZT_Line_BreakModeClip             UILineBreakModeClip
#define ZT_Line_BreakModeTruncatingHead   UILineBreakModeHeadTruncation
#define ZT_Line_BreakModeTruncatingMiddle UILineBreakModeMiddleTruncation
#define ZT_Line_BreakModeTruncatingTail   UILineBreakModeTailTruncation
#endif




#endif
