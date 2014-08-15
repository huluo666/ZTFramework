/*
 ============================================================================
 Name           : ZTImageBrowOverlayView.m
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTImageBrowOverlayView declaration
 ============================================================================
 */

#import "ZTImageBrowOverlayView.h"

@interface ZTImageBrowOverlayView()

@property (nonatomic, ZT_ARC_STRONG) CAGradientLayer *gradientLayer;

/** 动画 */
@property (nonatomic, unsafe_unretained) BOOL animated;

@property (nonatomic, assign, readwrite, getter = isVisible) BOOL visible;

/** mainView */
@property (nonatomic, ZT_ARC_STRONG) UIView *sharingView;

/** 标题 */
@property (nonatomic, ZT_ARC_STRONG, readwrite) UILabel *titleLabel;

/** 描述 */
@property (nonatomic, ZT_ARC_STRONG, readwrite) UITextView *descriptionLabel;

/** 分割 */
@property (nonatomic, ZT_ARC_STRONG) UIView *separatorView;

@end

@implementation ZTImageBrowOverlayView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.autoresizingMask = YES;
        
        //初始化UI
        [self initUI];
    }
    return self;
}

- (void)layoutSubviews {
	[super layoutSubviews];
    
    gradientLayer.frame = self.bounds;
	
	self.titleLabel.frame = CGRectMake(20, 35, CGRectGetWidth(self.frame) - 40, 20);
	self.separatorView.frame = CGRectMake(20, CGRectGetMinY(self.titleLabel.frame) + CGRectGetHeight(self.titleLabel.frame) + 5, CGRectGetWidth(self.titleLabel.frame), 1);
    
    self.descriptionLabel.frame = CGRectMake(20, CGRectGetMinY(self.separatorView.frame), 280, CGRectGetHeight(gradientLayer.frame) - (CGRectGetMinY(self.separatorView.frame) + CGRectGetHeight(self.separatorView.frame)));
    
	if ([self.descriptionLabel.text length]) {
        self.descriptionLabel.hidden = NO;
    } else {
        self.descriptionLabel.hidden = YES;
    }
	
    if ([title length]) {
		self.titleLabel.hidden = NO;
		self.separatorView.hidden = NO;
	} else {
		self.titleLabel.hidden = YES;
		self.separatorView.hidden = YES;
	}
}

#pragma mark - Private

//初始化UI
- (void)initUI {
	self.alpha = 0;
	self.userInteractionEnabled = YES;
    
	[self.sharingView addSubview:self.titleLabel];
	[self.sharingView addSubview:self.separatorView];
	[self.sharingView addSubview:self.descriptionLabel];
	
	[self addSubview:self.sharingView];
}

#pragma mark - Public

//还原视图
- (void)resetOverlayView {
    
    if (floor(CGRectGetHeight(self.frame)) == 120.f) {
        return;
    }
    
	__block CGRect initialSharingFrame = self.frame;
    initialSharingFrame.origin.y = round(CGRectGetHeight([UIScreen mainScreen].bounds) - 120.f);
    
    [UIView animateWithDuration:0.15
                     animations:^(){
                         self.frame = initialSharingFrame;
                     } completion:^(BOOL finished){
                         initialSharingFrame.size.height = 120.f;
                         [self setNeedsLayout];
                         [UIView animateWithDuration:0.25f
                                          animations:^(){
                                              self.frame = initialSharingFrame;
                                          }];
                     }];
}

//显示
- (void)showOverlayAnimated:(BOOL)val {
    if ([self.title length] > 0) {
        animated = val;
        self.visible = YES;
    }
}

//隐藏
- (void)hideOverlayAnimated:(BOOL)val {
    if ([self.title length] > 0) {
        animated = val;
        self.visible = NO;
    }
}

#pragma mark - GET/SET

- (void)setTitle:(NSString *)val
{
	title = val;
	
    if (title) {
        self.titleLabel.text = title;
    }
    
    [self setNeedsLayout];
}

- (void)setDescription:(NSString *)val
{
	description = val;
	
	if ([description length]) {
		self.descriptionLabel.text = description;
	} else {
		self.descriptionLabel.text = @"";
	}
    
    [self setNeedsLayout];
}

//sharingView
- (UIView *)sharingView {
	if (!sharingView) {
		sharingView = [[UIView alloc] initWithFrame:self.bounds];
		gradientLayer = [CAGradientLayer layer];
		gradientLayer.frame = self.bounds;
		gradientLayer.colors = [NSArray arrayWithObjects:(id)[[UIColor clearColor] CGColor], (id)[[UIColor blackColor] CGColor], nil];
		[sharingView.layer insertSublayer:gradientLayer atIndex:0];
	}
	
	return sharingView;
}

//titleLabel
- (UILabel *)titleLabel {
	if (!titleLabel) {
		titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, CGRectGetWidth(self.frame) - 40, 20)];
		titleLabel.textColor = [UIColor colorWithWhite:0.9 alpha:0.9];
		titleLabel.font = [UIFont boldSystemFontOfSize:14];
		titleLabel.backgroundColor = [UIColor clearColor];
	}
	
	return titleLabel;
}

//separatorView
- (UIView *)separatorView {
	if (!separatorView) {
        separatorView = [[UIView alloc] initWithFrame:CGRectMake(20, CGRectGetMinY(self.titleLabel.frame) + CGRectGetHeight(self.titleLabel.frame), 280, 1)];
		separatorView.backgroundColor = [UIColor lightGrayColor];
        separatorView.hidden = YES;
	}
	
	return separatorView;
}

//descriptionLabel
- (UITextView *)descriptionLabel {
	if (!descriptionLabel) {
        descriptionLabel = [[UITextView alloc] initWithFrame:CGRectMake(20, CGRectGetHeight(self.frame) - 10 - 23, 160, 20)];
		descriptionLabel.textColor = [UIColor colorWithWhite:0.9 alpha:0.9];
		descriptionLabel.font = [UIFont systemFontOfSize:13];
		descriptionLabel.backgroundColor = [UIColor clearColor];
        descriptionLabel.contentMode = UIViewContentModeTop;
        [descriptionLabel setEditable:NO];
	}
	
	return descriptionLabel;
}

//Visible
- (void)setVisible:(BOOL)visible {
	_visible = visible;
	
	CGFloat newAlpha = _visible ? 1. : 0.;
	
	NSTimeInterval animationDuration = animated ? 0.25f : 0;
	
	[UIView animateWithDuration:animationDuration
					 animations:^(){
						 self.alpha = newAlpha;
					 }];
}


@synthesize animated;
@synthesize title;
@synthesize description;
@synthesize gradientLayer;
@synthesize descriptionLabel;
@synthesize separatorView;
@synthesize titleLabel;
@synthesize sharingView;
@end
