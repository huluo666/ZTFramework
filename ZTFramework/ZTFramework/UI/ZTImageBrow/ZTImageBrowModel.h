/*
 ============================================================================
 Name           : ZTImageBrowModel.h
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTImageBrowModel declaration
 ============================================================================
 */

#import "ZTKit.h"

/**
 *ZTImageBrowModel:图片预览数据模型
 *Author:Fighting
 **/
@interface ZTImageBrowModel : NSObject

/** 图片 */
@property (nonatomic, ZT_ARC_STRONG) UIImage *img;

/** 图片URL */
@property (nonatomic, ZT_ARC_STRONG) NSString *imgURL;

/** 图片URL未读到显示 */
@property (nonatomic, ZT_ARC_STRONG) NSString *imgURLplaceholderImage;

/** 标题 */
@property (nonatomic, ZT_ARC_STRONG) NSString *title;

/** 描述 */
@property (nonatomic, ZT_ARC_STRONG) NSString *desc;

@end
