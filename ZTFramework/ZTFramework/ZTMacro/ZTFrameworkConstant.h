/*
 ============================================================================
 Name           : ZTFrameworkConstant.h
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTFrameworkConstant declaration
 ============================================================================
 */

#ifndef ZTFramework_ZTFrameworkConstant_h
#define ZTFramework_ZTFrameworkConstant_h

#import <UIKit/UIKit.h>

//----------------------ZTFrameworkBundle相关----------------------

/** ZTFrameworkBundle名称 */
static NSString * const ZTFrameworkBundle = @"ZTFrameworkBundle.bundle";

/** ZTFrameworkBundle图片地址 */
static NSString * const ZTFrameworkBundle_Image_Path = @"ZTFrameworkBundle.bundle/Images";

/** tableview状态 */
typedef NS_ENUM(NSInteger, ZTTableViewState) {
    ZTTableViewState_None,          /** 默认状态 */
    ZTTableViewState_Loading,       /** 加载中... */
    ZTTableViewState_PullEnd        /** 加载完成 */
};










//----------------------Block相关----------------------

/** 回调 */
typedef void(^ ZTBLOCK_1)(NSString *val);

























//----------------------设备相关----------------------

/** 设备所有者的名称 */
#define DEVICE_NAME                     [[UIDevice currentDevice] name]

/** 设备识别码 */
#define DEVICE_UUID                     [[[UIDevice currentDevice] identifierForVendor] UUIDString]

/** 设备的类别 */
#define DEVICE_MODEL                    [[UIDevice currentDevice] model]

/** 设备系统的版本号 */
#define DEVICE_IOS_SYSTEM_VERSION       ([[UIDevice currentDevice] systemVersion])

/** 是否ipad */
#define DEVICE_IPAD                     (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

/** 是否iphone */
#define DEVICE_IPHONE                   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

/** IOS版本 */
#define DEVICE_IOS                      ([[[UIDevice currentDevice] systemVersion] intValue])

/** IOS6 */
#define DEVICE_IOS_6                    ([[[UIDevice currentDevice] systemVersion] intValue] == 6)

/** IOS7 */
#define DEVICE_IOS_7                    ([[[UIDevice currentDevice] systemVersion] intValue] == 7)

/** App 版本信息 */
#define DEVICE_APP_VERSION              [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

/** App Bundle版本信息 */
#define DEVICE_APP_BUNDLE_VERSION       [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]

/** App Bundle Identifier */
#define DEVICE_APP_BUNDLE_IDENTIFIER    [[NSBundle mainBundle] bundleIdentifier]

/** Iphone5 */
#define DEVICE_IPHONE_5                 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

/** Iphone4S */
#define DEVICE_IPHONE_4S                ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

/** Iphone4 */
#define DEVICE_IPHONE_4                 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(320, 480), [[UIScreen mainScreen] currentMode].size) : NO)




















//----------------------页面相关----------------------

/** nav高度 */
static const CGFloat NAVIGATION_BAR_HEIGHT = 64.0f;

/** nav toolbar高度 */
static const CGFloat TAB_BAR_HEIGHT = 49.0f;

/** 键盘高度 */
static const CGFloat KEYBOARD_HEIGHT = 216.0f;

/** 屏幕宽度 */
#define SCREEN_WIDTH            ([UIScreen mainScreen].bounds.size.width)           

/** 屏幕高度 */
#define SCREEN_HEIGHT           ([UIScreen mainScreen].bounds.size.height)

#endif
