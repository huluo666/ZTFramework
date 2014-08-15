/*
 ============================================================================
 Name           : ZTTableConstant.h
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTTableConstant.h declaration
 ============================================================================
 */

#ifndef ZTFramework_ZTTableConstant_h
#define ZTFramework_ZTTableConstant_h

/** cell默认高度 */
static const CGFloat cellDefH = 44.0f;

/** 加载更多 */
static NSString * const cellMoreIdentifier = @"CellMore";

/** tableview状态 */
typedef NS_ENUM(NSInteger, ZTTableViewState) {
    ZTTableViewState_None,          /** 默认状态 */
    ZTTableViewState_Loading,       /** 加载中... */
    ZTTableViewState_PullEnd        /** 加载完成 */
};

#endif
