/*
 ============================================================================
 Name           : ZTImageBrowZoomView.h
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTImageBrowZoomView declaration
 ============================================================================
 */

#import "ZTKit.h"

@class ZTImageBrowZoomView;

typedef void(^ didTapZoomViewBlock)(ZTImageBrowZoomView * zoomView);

/**
 *ZTImageBrowZoomView:图片单项，放大缩小
 *Author:Fighting
 **/
@interface ZTImageBrowZoomView : UIScrollView

/** 滑动结束 */
@property (nonatomic, copy) didTapZoomViewBlock didTapZoom;

/**
 *  设置图片
 *
 *  @param image UIImage
 */
- (void)setImage:(UIImage *)image;

/**
 *  根据URL获取图片
 *
 *  @param url URL
 *  @param placeholderImage 未读取到的图片显示
 */
- (void)setURLImage:(NSString *)url placeholderImage:(NSString *)placeholderImage;

@end
