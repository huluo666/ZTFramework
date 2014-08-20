/*
 ============================================================================
 Name           : ZTImageBrow.h
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTImageBrow declaration
 ============================================================================
 */

#import "ZTKit.h"

/**
 *ZTImageBrow:图片预览器
 *Author:Fighting
 **/
@interface ZTImageBrow : UIViewController

/** 位置 */
@property (nonatomic, unsafe_unretained) int current;

/**
*  初始化
*
*  @param datasAry NSArray
*  @param current  int
*
*  @return id
*/
- (instancetype)initConfigWith:(NSArray *)datasAry;

@end
