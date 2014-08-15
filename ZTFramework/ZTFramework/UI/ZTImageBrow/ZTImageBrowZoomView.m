/*
 ============================================================================
 Name           : ZTImageBrowZoomView.m
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTImageBrowZoomView declaration
 ============================================================================
 */

#import "ZTImageBrowZoomView.h"
#import "ZTImageView.h"

static const float minZoom = 1.0f;
static const float maxZoom = 5.0f;

@interface ZTImageBrowZoomView()<UIScrollViewDelegate>

/** 图片 */
@property (ZT_ARC_STRONG, nonatomic) ZTImageView *imageView;

@end

@implementation ZTImageBrowZoomView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.frame = frame;
        
        //初始化UI
        [self iniUI];
    }
    return self;
}

#pragma mark - Private

//初始化UI
- (void)iniUI {
    self.delegate = self;
    self.minimumZoomScale = minZoom;
    self.maximumZoomScale = maxZoom;

    //图片
    imageView = [[ZTImageView alloc] initWithFrame:self.frame];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapped:)];
    doubleTap.numberOfTapsRequired = 2;
    [self addGestureRecognizer:doubleTap];
    [self addSubview:self.imageView];
}

#pragma mark - Public

//设置图片
- (void)setImage:(UIImage *)image {
    imageView.image = image;
}

//根据URL获取图片
- (void)setURLImage:(NSString *)url placeholderImage:(NSString *)placeholderImage {
    [imageView setImageWithURL:url placeholderImage:placeholderImage];
}

#pragma mark - Delegate
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!self.dragging && didTapZoom) {
        didTapZoom(self);        
    }
}

//双击
- (void)doubleTapped:(UITapGestureRecognizer *)recognizer {
    if (self.zoomScale > 1.0f) {
        [UIView animateWithDuration:0.4f animations:^{
            self.zoomScale = 1.0f;
        }];
        
        return;
    }
    
    [UIView animateWithDuration:0.4f animations:^{
        CGPoint point = [recognizer locationInView:self];
        [self zoomToRect:CGRectMake(point.x, point.y, 0, 0) animated:YES];
    }];
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return imageView;
}


@synthesize didTapZoom;
@synthesize imageView;
@end
