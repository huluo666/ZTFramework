/*
 ============================================================================
 Name           : ZTImageView.h
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTImageView declaration
 ============================================================================
 */

#import "ZTKit.h"

/**
 *ZTImageView:网络图片加载
 *Author:Fighting
 **/
@interface ZTImageView : UIImageView

/**
 *  设置网络图片
 *
 *  @param url              URL
 *  @param placeholderImage 未显示图片
 */
- (void)setImageWithURL:(NSString *)url placeholderImage:(NSString *)placeholderImage;

@end
