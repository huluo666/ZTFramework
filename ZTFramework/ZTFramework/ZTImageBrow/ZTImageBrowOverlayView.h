/*
 ============================================================================
 Name           : ZTImageBrowOverlayView.h
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTImageBrowOverlayView declaration
 ============================================================================
 */

#import "ZTKit.h"

/**
 *ZTImageBrowOverlayView:图片预览，单项视图
 *Author:Fighting
 **/
@interface ZTImageBrowOverlayView : UIView

/** 标题 */
@property (nonatomic, copy) NSString *title;

/** 描述 */
@property (nonatomic, copy) NSString *description;

/**
 *  还原视图
 */
- (void)resetOverlayView;

/**
 *  显示
 *
 *  @param animated 动画
 */
- (void)showOverlayAnimated:(BOOL)animated;

/**
 *  隐藏
 *
 *  @param animated 动画
 */
- (void)hideOverlayAnimated:(BOOL)animated;

@end
