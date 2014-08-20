/*
 ============================================================================
 Name           : ZTAnimation.h
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTAnimation declaration
 ============================================================================
 */



#import "ZTKit.h"

/**
 *ZTAnimation:动画效果
 *Author:Fighting
 **/
@interface ZTAnimation : NSObject

/**
 *  移动动画
 *
 *  @param fromPoint 起始点
 *  @param toPoint   到达点
 *
 *  @return CAKeyframeAnimation
 */
+ (CAKeyframeAnimation *)move:(CGPoint)fromPoint toPoint:(CGPoint)toPoint;

/**
 *  淡入淡出动画
 *
 *  @param fromVal 起始值
 *  @param toVal   到达值
 *
 *  @return CABasicAnimation
 */
+ (CABasicAnimation *)opacity:(CGFloat)fromVal toVal:(CGFloat)toVal;

/**
 *  缩放动画
 *
 *  @param fromVal 起始值
 *  @param toVal   到达值
 *
 *  @return CABasicAnimation
 */
+ (CABasicAnimation *)scale:(CGFloat)fromVal toVal:(CGFloat)toVal;



@end
