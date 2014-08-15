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
@property (nonatomic, ZT_ARC_STRONG)               UIColor                     *navTitleColor;

/** nav背景图片 */
@property (nonatomic, ZT_ARC_STRONG)               UIImage                     *navBackGroudImage;

/** 左按钮 */
@property (nonatomic, ZT_ARC_STRONG)               UIButton                    *navLeftBtn;

/** 左按钮图片 */
@property (nonatomic, ZT_ARC_STRONG)               UIImage                     *navLeftImage;

/** 左按钮文字 */
@property (nonatomic, ZT_ARC_WEAK)                 NSString                    *navLeftText;

/** 右按钮 */
@property (nonatomic, ZT_ARC_STRONG)               UIButton                    *navRightBtn;

/** 右按钮图片 */
@property (nonatomic, ZT_ARC_STRONG)               UIImage                     *navRightImage;

/** 右按钮文字 */
@property (nonatomic, ZT_ARC_WEAK)                 NSString                    *navRightText;

/** 标题 */
@property (nonatomic, ZT_ARC_WEAK)                 NSString                    *navTitle;

/** 标题View */
@property (nonatomic, ZT_ARC_STRONG)               UIView                      *navTitleView;

/**
 *  初始化
 *
 *  @param sender id
 *
 *  @return id
 */
- (instancetype)initConfigWith:(id)sender;

@end
