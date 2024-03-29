/*
 ============================================================================
 Name           : ZTImageScrollViewModel.h
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTImageScrollViewModel declaration
 ============================================================================
 */

#import "ZTKit.h"

/**
 *ZTImageScrollViewModel:图片滚动器，数据模型
 *Author:Fighting
 **/
@interface ZTImageScrollViewModel : NSObject

/** 图片 */
@property (nonatomic, strong) UIImage *img;

/** 图片src */
@property (nonatomic, strong) NSString *imgSrc;

@end
