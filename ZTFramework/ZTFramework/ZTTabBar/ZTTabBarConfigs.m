/*
 ============================================================================
 Name           : ZTTabBarConfigs.m
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTTabBarConfigs declaration
 ============================================================================
 */

#import "ZTTabBarConfigs.h"

@implementation ZTTabBarConfigs

//transition背景色
- (CGColorRef)transitionBackgroudColor {
    if (transitionBackgroudColor == nil) {
        return [[UIColor colorWithWhite:0.941 alpha:1.000] CGColor];
    }
    
    return transitionBackgroudColor;
}

//tabBarItem文字颜色
- (CGColorRef)tabBarItemTextColor {
    if (tabBarItemTextColor == nil) {
        return [[UIColor colorWithWhite:0.600 alpha:1.000] CGColor];
    }
    
    return tabBarItemTextColor;
}

//tabBarItem高亮文字颜色
- (CGColorRef)tabBarItemTextHighlightedColor {
    if (tabBarItemTextHighlightedColor == nil) {
        return [[UIColor colorWithRed:1.000 green:0.600 blue:0.000 alpha:1.000] CGColor];
    }
    
    return tabBarItemTextHighlightedColor;
}

//tabBarItem文字大小
- (CGFloat)tabBarItemTextSize {
    
    if (tabBarItemTextSize < 1) {
        return 12.0f;
    }
    
    return tabBarItemTextSize;
}

//背景图
- (CGImageRef)tabBarBackgroudImage {
    if (tabBarBackgroudImage == nil) {
        return [mImageByPath([NSString stringWithFormat:@"%@/tabBar_Icon_01", ZTFrameworkBundle_Image_Path], @"png") CGImage];
    }
    
    return tabBarBackgroudImage;
}



@synthesize tabBarItemTextHighlightedColor;
@synthesize tabBarItemTextColor;
@synthesize tabBarBackgroudImage;
@synthesize transitionBackgroudColor;
@synthesize tabBarItemTextSize;
@end
