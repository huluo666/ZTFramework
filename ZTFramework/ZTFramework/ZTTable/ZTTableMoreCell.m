/*
 ============================================================================
 Name           : ZTTableMoreCell.m
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTTableMoreCell declaration
 ============================================================================
 */

#import "ZTTableMoreCell.h"

@interface ZTTableMoreCell()

/** 菊花 */
@property (nonatomic, strong) UIActivityIndicatorView   *actionIndicator;

/** 标题 */
@property (nonatomic, strong) UILabel                   *titleLabel;

@end

@implementation ZTTableMoreCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        
        //初始化UI
        [self initUI];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)layoutSubviews {
    self.backgroundColor = [UIColor colorWithWhite:0.941 alpha:1.000];
}

//状态视图
- (void)stateView:(ZTTableViewState)state {
    
    switch (state) {
        case ZTTableViewState_None:
        case ZTTableViewState_PullEnd:
            titleLabel.frame = CGRectMake(self.bounds.origin.x, self.bounds.origin.y/2.0f, self.bounds.size.width, self.bounds.size.height);
            titleLabel.text = @"加载更多";
            titleLabel.backgroundColor = [UIColor clearColor];
            [actionIndicator stopAnimating];
            break;
        case ZTTableViewState_Loading:
            titleLabel.text = @"正在加载...";
            titleLabel.frame = CGRectMake(self.bounds.origin.x, self.bounds.origin.y/2.0f, self.bounds.size.width, self.bounds.size.height);
            titleLabel.backgroundColor = [UIColor clearColor];
            actionIndicator.frame = CGRectMake(70, self.bounds.origin.y/2.0f, 44, 44);
            [actionIndicator startAnimating];
            break;
        default:
            break;
    }
}

//初始化UI
- (void)initUI {
    
    //标题label
    titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(self.bounds.origin.x, self.bounds.origin.y/2.0f, self.bounds.size.width, self.bounds.size.height);
    titleLabel.font = [UIFont systemFontOfSize:12.0f];
    titleLabel.textColor = [UIColor colorWithWhite:0.200 alpha:1.000];
    titleLabel.textAlignment = ZTTextAlignmentCenter;
    titleLabel.text = @"加载更多";
    titleLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:titleLabel];
    
    //菊花
    actionIndicator = [[UIActivityIndicatorView alloc] init];
    actionIndicator.color = [UIColor colorWithWhite:0.200 alpha:1.000];
    [self addSubview:actionIndicator];
}



@synthesize actionIndicator;
@synthesize titleLabel;
@end
