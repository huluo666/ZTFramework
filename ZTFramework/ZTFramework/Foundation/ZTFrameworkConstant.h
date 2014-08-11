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








#endif
