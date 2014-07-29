/*
 ============================================================================
 Name           : ZTImageScrollView.h
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTImageScrollView declaration
 ============================================================================
 */

#import "ZTImageScrollViewModel.h"

/** 图片点击 */
typedef void(^ ZTImageScrollViewClickEvent)(ZTImageScrollViewModel *model, int current);

/**
 *ZTImageScrollView:图片滚动器
 *Author:Fighting
 **/
@interface ZTImageScrollView : UIViewController

/** 数据 */
@property (nonatomic, strong)               NSArray                         *datas;

/** 是否翻页 */
@property (nonatomic, unsafe_unretained)    BOOL                            isPageController;

/** 未加载显示图片 */
@property (nonatomic, strong)               NSString                        *placeholderImage;

/** 自动滚动 */
@property (nonatomic, unsafe_unretained)    BOOL                            isAutoScroll;

/** 图片点击事件 */
@property (nonatomic, copy)                 ZTImageScrollViewClickEvent     ZTImageScrollViewClickBlock;

/**
 *  初始化配置
 *
 *  @param frame 尺寸
 *  @param datas 数据
 *
 *  @return instancetype
 */
- (instancetype)initConfigWith:(CGRect)frame;

@end
