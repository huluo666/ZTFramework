/*
 ============================================================================
 Name           : ZTAnimation.m
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTAnimation declaration
 ============================================================================
 */

#import "ZTAnimation.h"

@implementation ZTAnimation

//移动动画
+ (CAKeyframeAnimation *)move:(CGPoint)fromPoint toPoint:(CGPoint)toPoint {
    
    UIBezierPath *movePath = [UIBezierPath bezierPath];
    [movePath moveToPoint:fromPoint];
    [movePath addLineToPoint:toPoint];
    
    //移动动画
    CAKeyframeAnimation *moveAnimaction = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    moveAnimaction.path = movePath.CGPath;

    return moveAnimaction;
}

//淡入淡出动画
+ (CABasicAnimation *)opacity:(CGFloat)fromVal toVal:(CGFloat)toVal {
    CABasicAnimation *opacityAnim = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnim.toValue = [NSNumber numberWithFloat:toVal];
    opacityAnim.fromValue = [NSNumber numberWithFloat:fromVal];
    
    return opacityAnim;
}

//缩放动画
+ (CABasicAnimation *)scale:(CGFloat)fromVal toVal:(CGFloat)toVal {
    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scale.fromValue=[NSNumber numberWithFloat:fromVal];
    scale.toValue = [NSNumber numberWithFloat:toVal];
    
    return scale;
}

@end
