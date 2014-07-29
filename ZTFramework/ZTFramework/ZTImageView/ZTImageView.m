/*
 ============================================================================
 Name           : ZTImageView.m
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTImageView declaration
 ============================================================================
 */

#import "ZTImageView.h"
#import "UIImageView+WebCache.h"

@interface ZTImageView()

/** 菊花 */
@property (nonatomic, strong) UIActivityIndicatorView *actionIndicator;     

@end

@implementation ZTImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setImageWithURL:(NSString *)url placeholderImage:(NSString *)placeholder {
    
    //菊花
    if (actionIndicator == nil) {
        actionIndicator = [[UIActivityIndicatorView alloc] init];
        actionIndicator.frame = self.bounds;
        actionIndicator.color = [UIColor colorWithWhite:0.200 alpha:1.000];
        actionIndicator.hidesWhenStopped = YES;
        [self addSubview:actionIndicator];
    }
    
    [actionIndicator startAnimating];
    
    typeof(self) __weak bself = self;
    
    [self sd_setImageWithURL:[NSURL URLWithString:url]
            placeholderImage:mImageByName(placeholder)
                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                       [[bself actionIndicator] stopAnimating];
                   }];
}

@synthesize actionIndicator;
@end
