/*
 ============================================================================
 Name           : ZTTabBarNotificationModel.m
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTTabBarNotificationModel declaration
 ============================================================================
 */

#import "ZTTabBarNotificationModel.h"
#import "ZTTabBar.h"

@implementation ZTTabBarNotificationModel

- (void)setTabBarItem:(NSInteger)item {
    
    if (item < 1) {
        item = 1;
    }
    
    if (item >= [[ZTTabBar sharedInstance] tabBarItemCount]) {
        item = [[ZTTabBar sharedInstance] tabBarItemCount];
    }
    
    tabBarItem = item;
}

- (void)setBagedNumber:(int)num {
    if (num < 0) {
        num = 0;
    }
    
    bagedNumber = num;
}

@synthesize tabBarItem;
@synthesize bagedNumber;
@end
