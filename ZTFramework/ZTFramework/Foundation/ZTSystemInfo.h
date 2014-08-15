/*
 ============================================================================
 Name           : ZTSystemInfo.h
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTSystemInfo declaration
 ============================================================================
 */

#pragma mark - 页面相关

/** 屏幕宽度 */
#undef ZT_M_SCREEN_WIDTH
#define ZT_M_SCREEN_WIDTH            ([UIScreen mainScreen].bounds.size.width)

/** 屏幕高度 */
#undef ZT_M_SCREEN_HEIGHT
#define ZT_M_SCREEN_HEIGHT           ([UIScreen mainScreen].bounds.size.height)

/** nav高度 */
#undef ZT_M_NAVIGATION_BAR_HEIGHT
#define ZT_M_NAVIGATION_BAR_HEIGHT   ([ZTSystemInfo NavigationHeight])

/** tabBar高度 */
#undef ZT_M_TAB_BAR_HEIGHT
#define ZT_M_TAB_BAR_HEIGHT          ([ZTSystemInfo TabBarHeight])

/** 键盘高度 */
#undef ZT_M_KEY_BOARD_HEIGHT
#define ZT_M_KEY_BOARD_HEIGHT        ([ZTSystemInfo KeyboardHeight])





#pragma mark - 设备相关

#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)

#define ZT_IOS8_OR_LATER		([[[UIDevice currentDevice] systemVersion] compare:@"8.0"] != NSOrderedAscending)
#define ZT_IOS7_OR_LATER		([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending)
#define ZT_IOS6_OR_LATER		([[[UIDevice currentDevice] systemVersion] compare:@"6.0"] != NSOrderedAscending)
#define ZT_IOS5_OR_LATER		([[[UIDevice currentDevice] systemVersion] compare:@"5.0"] != NSOrderedAscending)
#define ZT_IOS4_OR_LATER		([[[UIDevice currentDevice] systemVersion] compare:@"4.0"] != NSOrderedAscending)
#define ZT_IOS3_OR_LATER		([[[UIDevice currentDevice] systemVersion] compare:@"3.0"] != NSOrderedAscending)

#define ZT_IOS7_OR_EARLIER		(!ZT_IOS8_OR_LATER)
#define ZT_IOS6_OR_EARLIER		(!ZT_IOS7_OR_LATER)
#define ZT_IOS5_OR_EARLIER		(!ZT_IOS6_OR_LATER)
#define ZT_IOS4_OR_EARLIER		(!ZT_IOS5_OR_LATER)
#define ZT_IOS3_OR_EARLIER		(!ZT_IOS4_OR_LATER)

/** 4寸屏幕 */
#define ZT_DEVICE_IS_SCREEN_4_INCH	([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

/** 3.5寸屏 */
#define ZT_DEVICE_IS_SCREEN_35_INCH	([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#else

#define ZT_IOS7_OR_LATER		(NO)
#define ZT_IOS6_OR_LATER		(NO)
#define ZT_IOS5_OR_LATER		(NO)
#define ZT_IOS4_OR_LATER		(NO)
#define ZT_IOS3_OR_LATER		(NO)

/** 4寸屏幕 */
#define ZT_DEVICE_IS_SCREEN_4_INCH	(NO)

/** 3.5寸屏 */
#define ZT_DEVICE_IS_SCREEN_35_INCH	(NO)

#endif








/**
 *ZTSystemInfo:系统信息
 *Author:Fighting
 **/
@interface ZTSystemInfo : NSObject

/** OS版本 */
+ (NSString *)osVersion;

/** App版本 */
+ (NSString *)appVersion;

/** AppIdentifier */
+ (NSString *)appIdentifier;

/** appSchema */
+ (NSString *)appSchema;
+ (NSString *)appSchema:(NSString *)name;

//------------------设备相关

/** UDID */
+ (NSString *)deviceUDID;

/** 设备的类别 */
+ (NSString *)deviceModel;

/** 设备识别码 */
+ (NSString *)deviceUUID;

/** 设备名称 */
+ (NSString *)deviceName;

/** 设备是否retina屏 */
+ (BOOL)deviceIsRetina;

/** 设备是否越狱 */
+ (BOOL)deviceIsJailBroken              NS_AVAILABLE_IOS(4_0);
+ (NSString *)devicejailBreaker         NS_AVAILABLE_IOS(4_0);

/** 是否是Iphone设备 */
+ (BOOL)deviceIsPhone;

/** 是否是iPad设备 */
+ (BOOL)deviceIsPad;

/** 是否Iphone */
+ (BOOL)isPhone;

/** 是否3.5寸iphone */
+ (BOOL)isPhone35;

/** 是否3.5寸iphone retina */
+ (BOOL)isPhoneRetina35;

/** 是否4寸iphone retina */
+ (BOOL)isPhoneRetina4;

/** 是否Ipad */
+ (BOOL)isPad;

/** 是否Ipad Retina */
+ (BOOL)isPadRetina;

//------------------页面相关

/** nav高度 */
+ (CGFloat)NavigationHeight;

/** tabBar高度 */
+ (CGFloat)TabBarHeight;

/** 键盘高度 */
+ (CGFloat)KeyboardHeight;

@end
