/*
 ============================================================================
 Name           : ZTTabBarItemGroup.m
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTTabBarItemGroup declaration
 ============================================================================
 */

#import "ZTTabBarItemGroup.h"
#import "ZTTabBarModel.h"
#import "ZTTabBarItem.h"
#import "ZTTabBarNotificationModel.h"
#import "ZTTabBar.h"
#import "ZTTabBarConfigs.h"

const ZTTabBarConfigs *tabBarConfig;

@interface ZTTabBarItemGroup()<ZTTabBarItemDelegate>

/** 当前选中项 */
@property (nonatomic, unsafe_unretained)    NSInteger           cureentItem;

/** 背景图片View */
@property (nonatomic, strong)               UIImageView         *backgroudImageView;

@end

@implementation ZTTabBarItemGroup

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self initUI];
    }
    return self;
}

//初始化UI
- (void)initUI {
    
    //背景色
    self.backgroundColor = [UIColor colorWithCGColor:tabBarConfig.transitionBackgroudColor];
    
    //初始化变量
    tabBarItemAry = [[NSMutableArray alloc] init];
    
    //背景图片
    backgroudImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    
    [self addSubview:backgroudImageView];
    
    //注册广播接收器
    if (!mIsNull(tabBarConfig.tabBarBadgeNotificationName)) {
        [mNotificationCenter addObserver:self selector:@selector(bagedNotification:) name:tabBarConfig.tabBarBadgeNotificationName object:nil];
    }
}

//释放
- (void)dealloc {
    for (ZTTabBarItem *item in tabBarItemAry) {
        item.delegate = nil;
    }
    
    [mNotificationCenter removeObserver:self];
}

#pragma mark - Delegate

//tabBarItem点击
- (void)ZTTabBarItemClick:(id)sender {
    ((ZTTabBarItem *) [tabBarItemAry objectAtIndex:cureentItem]).selected = NO;
    
    ZTTabBarItem *item = sender;
    item.selected = YES;
    cureentItem = item.tag;

    if (delegate && [delegate respondsToSelector:@selector(ZTTabBarItemGroup_Click:)]) {
        [delegate ZTTabBarItemGroup_Click:item.data];
    }
}

//气泡广播
- (void)bagedNotification:(NSNotification *)sender {
    if (mIsNull([sender object])) {
        return;
    }
    
    ZTTabBarNotificationModel *model = (ZTTabBarNotificationModel *)[sender object];
    ZTTabBarItem *item = [tabBarItemAry objectAtIndex:model.tabBarItem - 1];
    item.badgeNumber = model.bagedNumber;
}

#pragma mark - Private

#pragma mark - Public

//追加一个tabBarItem
- (void)appTabBarItem:(ZTTabBarModel *)model {
    
    int width = self.frame.size.width / [self.subviews count];
    CGRect rect = {0, 0, width, self.frame.size.height};
    
    for (ZTTabBarItem *item in tabBarItemAry) {
        item.frame = rect;
        rect.origin.x += rect.size.width;
        [item setNeedsLayout];
    }
    
    ZTTabBarItem *tcTabBarItem = [[ZTTabBarItem alloc] initConfigWith:model frame:rect];
    tcTabBarItem.backgroundColor = [UIColor clearColor];
    tcTabBarItem.tag = [self.subviews count] - 1;
    tcTabBarItem.delegate = self;
    [self addSubview:tcTabBarItem];
    [tabBarItemAry addObject:tcTabBarItem];
}

//背景图片
- (void)setBackGroudImage:(UIImage *)img {
    
    if (img == nil || (NSNull *)img == [NSNull null] || !UIImagePNGRepresentation(img)) {
        return;
    }
    
    [backgroudImageView setImage:img];
}

//选中项
- (void)setSelectIndex:(int)index {
    //如不延迟0.1f会出现警告
    [self performSelector:@selector(ZTTabBarItemClick:) withObject:[tabBarItemAry objectAtIndex:index - 1] afterDelay:0.1f];
}

//总item数
- (NSInteger)tabBarItemCount {
    return [tabBarItemAry count];
}

//根据tabBarItem显示气泡
- (void)bagedForTabBarItem:(int)item num:(int)num {
    
}



@synthesize tabBarItemCount;
@synthesize delegate;
@synthesize cureentItem;
@synthesize tabBarItemAry;
@synthesize backgroudImageView;
@end
