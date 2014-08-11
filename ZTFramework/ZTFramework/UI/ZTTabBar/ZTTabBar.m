/*
 ============================================================================
 Name           : ZTTabBar.m
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTTabBar declaration
 ============================================================================
 */

#import "ZTTabBar.h"
#import "ZTTabBarItemGroup.h"
#import "ZTTabBarItem.h"
#import "ZTTabBarConfigs.h"
#import "ZTTabBarModel.h"

const ZTTabBarConfigs *tabBarConfig;

@interface ZTTabBar ()<ZTTabBarItemGroupDelegate>

/** 显示View */
@property (nonatomic, strong)               UIView                *transitionView;

/** tabBar分组 */
@property (nonatomic, strong)               ZTTabBarItemGroup     *tabBarGroup;

@end

@implementation ZTTabBar

ZTSingleton(ZTTabBar)

//释放
- (void)dealloc {
    tabBarGroup.delegate = nil;
}

//初始化UI
- (void)initUI {
    int y = 0;
    
    //显示状态栏
    if (IOS6_OR_EARLIER) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
        y = -20;
    } else {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    }

    //设置主屏幕大小
    self.view.frame = [[UIScreen mainScreen] bounds];

    //transitionView
    transitionView = [[UIView alloc] init];
    transitionView.frame = CGRectMake(0, y, SCREEN_WIDTH, SCREEN_HEIGHT);
    transitionView.backgroundColor = [UIColor colorWithCGColor:tabBarConfig.transitionBackgroudColor];
    [self.view addSubview:transitionView];

    //tabBarGroup
    tabBarGroup = [[ZTTabBarItemGroup alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(transitionView.frame) - TAB_BAR_HEIGHT + y, SCREEN_WIDTH, TAB_BAR_HEIGHT)];
    tabBarGroup.delegate = self;
    tabBarGroup.backGroudImage = [UIImage imageWithCGImage:tabBarConfig.tabBarBackgroudImage];
    [self.view addSubview:tabBarGroup];
}

#pragma mark - Delegate

//group点击
- (void)ZTTabBarItemGroup_Click:(ZTTabBarModel *)selectModel {
    //添加view
    [[transitionView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview) withObject:nil];
    selectModel.nav.view.frame = transitionView.bounds;
    [transitionView addSubview:selectModel.nav.view];
}

#pragma mark - Public

//初始化配置
- (void)initWithConfig:(ZTTabBarConfigs *)config {
    
    //已经初始化过了
    if (transitionView != nil) {
        return;
    }
    
    tabBarConfig = config;
    
    //初始化UI
    [self initUI];
}

//追加一个TabBar
- (void)appendTabBar:(ZTTabBarModel *)model {
    [tabBarGroup appTabBarItem:model];
}

//获取model
- (ZTTabBarModel *)getTabBarModel:(int)current {
    
    ZTTabBarModel *model = nil;
    
    if (current > [tabBarGroup.tabBarItemAry count]) {
        return model;
    }
    
    ZTTabBarItem *item = [tabBarGroup.tabBarItemAry objectAtIndex:current - 1];
    return item.data;
}

//选中某一个
- (void)setSelectedIndex:(int)index {
    
    if (index < 1) {
        return;
    }
    
    tabBarGroup.selectIndex = index;
}

//隐藏,显示
- (void)hiddenTabBar:(BOOL)yesORno animated:(BOOL)animated {
    
    //隐藏
    if (yesORno && tabBarGroup.frame.origin.y == self.view.frame.size.height) {
        return;
    }
    
    //显示
    if (!yesORno && tabBarGroup.frame.origin.y == self.view.frame.size.height - TAB_BAR_HEIGHT) {
        return;
    }
    
    CGRect rect = tabBarGroup.frame;
    rect.origin.y = yesORno ? rect.origin.y + TAB_BAR_HEIGHT : rect.origin.y - TAB_BAR_HEIGHT;
    
    if (animated) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3f];
        tabBarGroup.frame = rect;
        [UIView commitAnimations];
        return;
    }
    
    tabBarGroup.frame = rect;
}

//总tabBarItem数
- (NSInteger)tabBarItemCount {
    return tabBarGroup.tabBarItemCount;
}




@synthesize tabBarItemCount;
@synthesize transitionView;
@synthesize tabBarGroup;
@end
