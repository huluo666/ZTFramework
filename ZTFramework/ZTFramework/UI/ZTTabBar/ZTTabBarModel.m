/*
 ============================================================================
 Name           : ZTTabBarModel.m
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTTabBarModel declaration
 ============================================================================
 */

#import "ZTTabBarModel.h"

@implementation ZTTabBarModel

//设置ViewController
- (void)setViewController:(UIViewController *)view {
    viewController = view;
    nav = [[UINavigationController alloc] initWithRootViewController:viewController];
}




@synthesize title;
@synthesize image;
@synthesize imageSel;
@synthesize nav;
@synthesize viewController;
@end
