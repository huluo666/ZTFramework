/*
 ============================================================================
 Name           : ZTNavigation.h
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTNavigation declaration
 ============================================================================
 */

#import "ZTKit.h"

/** 导航点击 */
@protocol ZTNavigationDelegate <NSObject>

@optional

/**
 *  标题点击事件
 *
 *  @param sender id
 */
- (void)ZTNavigationActionTitle:(id)sender;

/**
 *  左按钮事件
 *
 *  @param sender id
 */
- (void)ZTNavigationActionLeft:(id)sender;

/**
 *  右按钮事件
 *
 *  @param sender id
 */
- (void)ZTNavigationActionRight:(id)sender;

@end








/**
 *ZTNavigation:导航
 *Author:Fighting
 **/
@interface ZTNavigation : NSObject

/** 委托 */
@property (nonatomic, unsafe_unretained)    id<ZTNavigationDelegate>    delegate;

/** nav标题颜色 */
@property (nonatomic, strong)               UIColor                     *navTitleColor;

/** nav背景图片 */
@property (nonatomic, strong)               UIImage                     *navBackGroudImage;

/** 左按钮 */
@property (nonatomic, strong)               UIButton                    *navLeftBtn;

/** 左按钮图片 */
@property (nonatomic, strong)               UIImage                     *navLeftImage;

/** 左按钮文字 */
@property (nonatomic, weak)                 NSString                    *navLeftText;

/** 右按钮 */
@property (nonatomic, strong)               UIButton                    *navRightBtn;

/** 右按钮图片 */
@property (nonatomic, strong)               UIImage                     *navRightImage;

/** 右按钮文字 */
@property (nonatomic, weak)                 NSString                    *navRightText;

/** 标题 */
@property (nonatomic, weak)                 NSString                    *navTitle;

/** 标题View */
@property (nonatomic, strong)               UIView                      *navTitleView;

/**
 *  初始化
 *
 *  @param sender id
 *
 *  @return id
 */
- (instancetype)initConfigWith:(id)sender;

@end
