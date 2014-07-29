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
@property (nonatomic, strong) UINavigationController *nav;

/** viewController */
@property (nonatomic, strong) UIViewController *viewController;

/** 标题 */
@property (nonatomic, strong) NSString *title;

/** 图标 */
@property (nonatomic, strong) NSString *image;

/** 选中后图标 */
@property (nonatomic, strong) NSString *imageSel;

@end
