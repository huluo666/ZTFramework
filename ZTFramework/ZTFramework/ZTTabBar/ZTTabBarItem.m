/*
 ============================================================================
 Name           : ZTTabBarItem.m
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTTabBarItem declaration
 ============================================================================
 */


#import "ZTTabBarItem.h"
#import "ZTTabBarItemBadge.h"
#import "ZTTabBarModel.h"
#import "ZTTabBar.h"
#import "ZTTabBarConfigs.h"

const ZTTabBarConfigs *tabBarConfig;

@interface ZTTabBarItem()

/** 图标 */
@property (nonatomic, strong) UIImageView *icon;

/** 标题 */
@property (nonatomic, strong) UILabel *title;

/** 气泡 */
@property (nonatomic, strong) ZTTabBarItemBadge *badge;

@end

@implementation ZTTabBarItem

- (instancetype)initConfigWith:(ZTTabBarModel *)Model frame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        //拷贝数据
        data = Model;
        
        //初始化UI
        [self initUI];
    }
    
    return self;
}

//初始化
- (void)initUI {
    
    self.backgroundColor = [UIColor clearColor];
    
    //添加事件
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionBtn)];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tapGestureRecognizer];        
    
    //图片
    icon = [[UIImageView alloc] init];
    icon.image = mImageByName(data.image);
    icon.highlightedImage = mImageByName(data.imageSel);
    [self addSubview:icon];
    
    //文字
    title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    title.text = data.title;
    title.font = [UIFont systemFontOfSize:tabBarConfig.tabBarItemTextSize];
    title.backgroundColor = [UIColor clearColor];
    title.textAlignment = ZTTextAlignmentCenter;
    title.textColor = [UIColor colorWithCGColor:tabBarConfig.tabBarItemTextColor];
    title.highlightedTextColor = [UIColor colorWithCGColor:tabBarConfig.tabBarItemTextHighlightedColor];
    [self addSubview:title];
    
    //气泡
    badge = [[ZTTabBarItemBadge alloc] init];
    badge.badgeColor = [UIColor redColor];
    badge.delegate = self;
    [self addSubview:badge];
}

//布局移动
- (void)layoutSubviews {
    badge.frame = CGRectMake(self.bounds.size.width/2.0f, 0, 50.0f, 20.0f);
    icon.frame = CGRectMake(self.frame.size.width/2.0f - 30.0f / 2.0f, 3.0f, 30.0f, 30.0f);
    title.frame = CGRectMake(0, icon.frame.size.height, self.frame.size.width, 20.0f);
}

#pragma mark - Private

//点击
- (void)actionBtn {
    if (delegate && [delegate respondsToSelector:@selector(ZTTabBarItemClick:)]) {
        [delegate ZTTabBarItemClick:self];
    }
}

#pragma mark - Public

//设置选中
- (void)setSelected:(BOOL)selected {
    title.highlighted = selected;
    icon.highlighted = selected;
}

//气泡数
- (void)setBadgeNumber:(int)number {
    badge.badgeString = [NSString stringWithFormat:@"%d", number];
}




@synthesize badgeNumber;
@synthesize badge;
@synthesize delegate;
@synthesize title;
@synthesize icon;
@synthesize data;
@end