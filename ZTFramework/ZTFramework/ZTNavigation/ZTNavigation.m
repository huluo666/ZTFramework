/*
 ============================================================================
 Name           : ZTNavigation.m
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTNavigation declaration
 ============================================================================
 */

#import "ZTNavigation.h"

@interface ZTNavigation()

/** 标题按钮 */
@property (nonatomic, strong)   UIButton                *navTitleBtn;

/** ViewController */
@property (nonatomic, weak)     UIViewController        *vc;

@end

@implementation ZTNavigation

- (instancetype)initConfigWith:(id)sender {
    if (self = [super init]) {
        vc = (UIViewController *)sender;
        
        //初始化UI
        [self initUI];
    }
    
    return self;
}

#pragma mark - Private

//初始化UI
- (void)initUI {
    
    //默认背景图片
    [self setNavBackGroudImage:mImageByPath([NSString stringWithFormat:@"%@/nav_Icon_01", ZTFrameworkBundle_Image_Path], @"png")];
    
    //标题颜色
    [self setNavTitleColor:[UIColor colorWithRed:1.000 green:0.600 blue:0.000 alpha:1.000]];
    
    //标题按钮
    navTitleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    navTitleBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    [self setNavTitleView:navTitleBtn];
    
    //左侧按钮
    navLeftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [navLeftBtn.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [navLeftBtn addTarget:self action:@selector(actionNavLeft:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:navLeftBtn];
    
    //右侧按钮
    navRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [navRightBtn.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [navRightBtn addTarget:self action:@selector(actionNavRight:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:navRightBtn];
    
    
    NSMutableArray *leftAry = [[NSMutableArray alloc] init];
    NSMutableArray *rightAry = [[NSMutableArray alloc] init];
    
    if (DEVICE_IOS_6) {
        UIBarButtonItem *flexSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        [leftAry addObject:flexSpacer];
        [leftAry addObject:left];
        
        [rightAry addObject:flexSpacer];
        [rightAry addObject:right];
        
        [vc.navigationItem setLeftBarButtonItems:leftAry];
        [vc.navigationItem setRightBarButtonItems:rightAry];
    } else {
        vc.navigationItem.leftBarButtonItem = left;
        vc.navigationItem.rightBarButtonItem = right;
    }
}

//左按钮事件
- (void)actionNavLeft:(id)sender {
    if (delegate && [delegate respondsToSelector:@selector(ZTNavigationActionLeft:)]) {
        [delegate ZTNavigationActionLeft:sender];
        return;
    }
}

//右按钮事件
- (void)actionNavRight:(id)sender {
    if (delegate && [delegate respondsToSelector:@selector(ZTNavigationActionRight:)]) {
        [delegate ZTNavigationActionRight:sender];
    }
}


#pragma mark - Public

//左侧按钮图片
- (void)setNavLeftImage:(UIImage *)image {
    if (image == nil) {
        [navLeftBtn setImage:image forState:UIControlStateNormal];
        return;
    }
    
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    //
    //    if (DEVICE_IOS_6) {
    //        [navLeftBtn setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -20)];
    //    }
    
    navLeftBtn.bounds = rect;
    [navLeftBtn setImage:image forState:UIControlStateNormal];
}

//左侧按钮文字
- (void)setNavLeftText:(NSString *)text {
    [navLeftBtn setTitle:text forState:UIControlStateNormal];
}

//标题
- (void)setNavTitle:(NSString *)title {
    [navTitleBtn setTitle:title forState:UIControlStateNormal];
}

//标题view
- (void)setNavTitleView:(UIView *)view {
    vc.navigationItem.titleView = view;
}

//右侧按钮图片
- (void)setNavRightImage:(UIImage *)image {
    
    if (image == nil) {
        [navRightBtn setImage:image forState:UIControlStateNormal];
        return;
    }
    
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    navRightBtn.bounds = rect;
    [navRightBtn setImage:image forState:UIControlStateNormal];
}

//右侧按钮文字
- (void)setNavRightText:(NSString *)text {
    
    if (CGRectGetWidth(navRightBtn.bounds) < 1) {
        navRightBtn.bounds = CGRectMake(0, 0, 40, 44);
    }
    
    [navRightBtn setTitle:text forState:UIControlStateNormal];
}

//设置文字色
- (void)setNavTitleColor:(UIColor *)color {
    [vc.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:color, UITextAttributeTextColor, nil]];
}

//设置背景图片
- (void)setNavBackGroudImage:(UIImage *)image {
    
    [vc.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
    if (DEVICE_IOS_6) {
        //去掉多余的背景
        [vc.navigationController.navigationBar.layer setMasksToBounds:YES];
    }
}





@synthesize delegate;
@synthesize navTitle;
@synthesize navLeftText;
@synthesize navLeftBtn;
@synthesize navLeftImage;
@synthesize navRightText;
@synthesize navRightBtn;
@synthesize navRightImage;
@synthesize navTitleBtn;
@synthesize navTitleColor;
@synthesize navBackGroudImage;
@synthesize vc;
@end
