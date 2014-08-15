/*
 ============================================================================
 Name           : ZTButton.m
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTButton declaration
 ============================================================================
 */

#import "ZTButton.h"
#import "UIButton+WebCache.h"

@interface ZTButton()

/** 菊花 */
@property (nonatomic, ZT_ARC_STRONG) UIActivityIndicatorView *actionIndicator;

@end

@implementation ZTButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

//设置网络图片
- (void)setImageWithURL:(NSString *)url placeholderImage:(NSString *)placeholder forState:(UIControlState)forState {
    [self setImageWithURL:url placeholderImage:placeholder forState:forState size:CGSizeZero];
}

//设置网络图片
- (void)setImageWithURL:(NSString *)url placeholderImage:(NSString *)placeholder forState:(UIControlState)forState size:(CGSize)size {
    
    //菊花
    if (actionIndicator == nil) {
        actionIndicator = [[UIActivityIndicatorView alloc] init];
        actionIndicator.frame = self.bounds;
        actionIndicator.color = [UIColor colorWithWhite:0.200 alpha:1.000];
        actionIndicator.hidesWhenStopped = YES;
        [self addSubview:actionIndicator];
    }
    
    [actionIndicator startAnimating];
    
    ZT_WEAKSELF_DEF
    
    [self sd_setImageWithURL:[NSURL URLWithString:url]
                    forState:forState
                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                       [wself.actionIndicator stopAnimating];
                       
                       if (!error & (size.width > 0 && size.height > 0)) {
                           [wself setImage:[wself scaleToSize:image size:size] forState:forState];
                       }
                   }];
}

-(UIImage*)scaleToSize:(UIImage*)img size:(CGSize)size {

    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}

@synthesize actionIndicator;
@end
