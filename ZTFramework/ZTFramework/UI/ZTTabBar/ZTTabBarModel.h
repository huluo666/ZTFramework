/*
 ============================================================================
 Name           : ZTTabBarModel.h
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTTabBarModel declaration
 ============================================================================
 */

#import "ZTKit.h"

/**
 *ZTTabBarModel:tabBar数据模型
 *Author:Fighting
 **/
@interface ZTTabBarModel : NSObject

/** nav */
@property (nonatomic, ZT_ARC_STRONG) UINavigationController *nav;

/** viewController */
@property (nonatomic, ZT_ARC_STRONG) UIViewController *viewController;

/** 标题 */
@property (nonatomic, ZT_ARC_STRONG) NSString *title;

/** 图标 */
@property (nonatomic, ZT_ARC_STRONG) NSString *image;

/** 选中后图标 */
@property (nonatomic, ZT_ARC_STRONG) NSString *imageSel;

@end
