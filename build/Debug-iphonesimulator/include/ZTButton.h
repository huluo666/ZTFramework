/*
 ============================================================================
 Name           : ZTButton.h
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTButton declaration
 ============================================================================
 */

#import "ZTKit.h"

/**
 *ZTButton:按钮图片加载
 *Author:Fighting
 **/
@interface ZTButton : UIButton

/**
*  设置网络图片
*
*  @param url              URL
*  @param placeholderImage 未显示图片
*  @param forState         显示状态
*/
- (void)setImageWithURL:(NSString *)url placeholderImage:(NSString *)placeholderImage forState:(UIControlState)forState;

/**
 *  设置网络图片
 *
 *  @param url              URL
 *  @param placeholderImage 未显示图片
 *  @param forState         显示状态
 *  @param size             图片大小
 */
- (void)setImageWithURL:(NSString *)url placeholderImage:(NSString *)placeholderImage forState:(UIControlState)forState size:(CGSize)size;

@end
