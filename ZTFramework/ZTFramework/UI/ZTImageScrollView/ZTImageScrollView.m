/*
 ============================================================================
 Name           : ZTImageScrollView.m
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTImageScrollView declaration
 ============================================================================
 */

#import "ZTImageScrollView.h"
#import "ZTImageView.h"

@interface ZTImageScrollView()<UIScrollViewDelegate>

/** 滚动条 */
@property (nonatomic, ZT_ARC_STRONG)                   UIScrollView                    *scrollView;

/** 翻页 */
@property (nonatomic, ZT_ARC_STRONG)                   UIPageControl                   *pageControl;

/** 菊花 */
@property (nonatomic, ZT_ARC_STRONG)                   UIActivityIndicatorView         *actionIndicator;

/** 总记录 */
@property (nonatomic, unsafe_unretained)        int                             rowCount;

/** 当前页 */
@property (nonatomic, unsafe_unretained)        int                             page;

/** 计数器 */
@property (nonatomic, ZT_ARC_STRONG)                   NSTimer                         *timer;

@end

@implementation ZTImageScrollView

- (instancetype)initConfigWith:(CGRect)frame {
    if (self = [super init]) {
        self.view.frame = frame;
        self.view.autoresizingMask = YES;
        
        //初始化UI
        [self initUI];
    }
    
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //计数器，自动滚动
    if (isAutoScroll) {
        timer =  [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(adAutoMove) userInfo:nil repeats:YES];
    }
    
    scrollView.delegate = self;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    //停止计数器
    if (isAutoScroll) {
        [timer invalidate];
        timer = nil;
    }
    
    scrollView.delegate = nil;
}

#pragma mark - Private

//初始化UI
- (void)initUI {
    
    //scrollView
    scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    
    //pageControl
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 20, self.view.bounds.size.width, 20)];
    pageControl.userInteractionEnabled = NO;
    [self.view addSubview:pageControl];
    
    //菊花
    actionIndicator = [[UIActivityIndicatorView alloc] initWithFrame:self.view.bounds];
    actionIndicator.center = self.view.center;
    actionIndicator.hidesWhenStopped = YES;
    actionIndicator.color = [UIColor colorWithWhite:0.200 alpha:1.000];
    [self.view addSubview:actionIndicator];
    [actionIndicator startAnimating];
}

//自动滚动
- (void)adAutoMove {
    
    page++;
    
    if (page >= rowCount) {
        page = 0;
    }
    
    pageControl.currentPage = page;
    [scrollView setContentOffset:CGPointMake(self.view.bounds.size.width * page, 0) animated:YES];
}

//图片点击
- (void)actionClickEvent:(UITapGestureRecognizer *)tapGesture {

    int tag = (int)tapGesture.view.tag;
    
    if (ZTImageScrollViewClickBlock) {
        ZTImageScrollViewClickBlock([datas objectAtIndex:tag], tag);
    }
}

#pragma mark - Delegate

//滑动结束
- (void)scrollViewDidEndDecelerating:(UIScrollView *)view {
    CGFloat pageWidth = scrollView.bounds.size.width;
    page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) +1;
    pageControl.currentPage = page;
}

#pragma mark - Public

- (void)setDatas:(NSArray *)ary {
    
    [actionIndicator stopAnimating];
    
    //清除所有图片
    [scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    //创建图片
    int x = 0;
    int w = self.view.bounds.size.width;
    int h = self.view.bounds.size.height;
    ZTImageView *imgView = nil;
    UITapGestureRecognizer *tapGesture = nil;
    
    for (int i = 0, c = (int)[ary count]; i < c; i++) {
        
        ZTImageScrollViewModel *item = [ary objectAtIndex:i];
        
        imgView = [[ZTImageView alloc] init];
        imgView.userInteractionEnabled = YES;
        imgView.frame = CGRectMake(x, 0, w, h);
        
        if (!ZT_M_IsNull(item.imgSrc)) {
            [imgView setImageWithURL:item.imgSrc placeholderImage:placeholderImage];
        } else {
            imgView.image = item.img;
        }        
        
        [scrollView addSubview:imgView];
        x += w;
        
        tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionClickEvent:)];
        [imgView addGestureRecognizer:tapGesture];
        tapGesture.view.tag = i;
    }
    
    [scrollView setContentSize:CGSizeMake(x, h)];
    
    //翻页控件
    if (isPageController) {
        rowCount = (int)[ary count];
        pageControl.numberOfPages = rowCount;
        pageControl.currentPage = 0;
    }
    
    datas = ary;
}



@synthesize datas;
@synthesize ZTImageScrollViewClickBlock;
@synthesize isAutoScroll;
@synthesize timer;
@synthesize page;
@synthesize actionIndicator;
@synthesize placeholderImage;
@synthesize isPageController;
@synthesize rowCount;
@synthesize pageControl;
@synthesize scrollView;
@end
