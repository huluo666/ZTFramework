/*
 ============================================================================
 Name           : ZTImageBrow.m
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTImageBrow declaration
 ============================================================================
 */

#import "ZTImageBrow.h"
#import "ZTImageBrowModel.h"
#import "ZTImageView.h"
#import "ZTImageBrowZoomView.h"
#import "ZTImageBrowOverlayView.h"
#import "ZTNavigation.h"

static NSString * const cellIdentifier = @"Cell";

@interface ZTImageBrow ()<UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate, ZTNavigationDelegate>

/** 数据 */
@property (nonatomic, strong) NSArray *datas;

/** tableView */
@property (nonatomic, strong) UITableView *photoTableView;;

/** 说明 */
@property (nonatomic, strong) ZTImageBrowOverlayView *overlayView;

/** navigation */
@property (nonatomic, strong) ZTNavigation *navigation;

@property (nonatomic, assign, getter = isDisplayingDetailedView) BOOL displayingDetailedView;

@end

@implementation ZTImageBrow

- (instancetype)initConfigWith:(NSArray *)datasAry {
    if (self = [super init]) {
        datas = datasAry;
        self.view.autoresizingMask = YES;
    }
    
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //加载数据
    [self loadData];
}

- (void)dealloc {
    navigation.delegate = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //初始化UI
    [self iniUI];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private

//初始化UI
- (void)iniUI {
    
    current = 1;
    
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    //nav
    navigation = [[ZTNavigation alloc] initConfigWith:self];
    navigation.delegate = self;
    navigation.navLeftImage = mImageByPath([NSString stringWithFormat:@"%@/nav_Icon_02", ZTFrameworkBundle_Image_Path], @"png");
    navigation.navTitle = [NSString stringWithFormat:@"%d/%d", current, (int)[datas count]];
    
    //变量
    self.view.userInteractionEnabled = NO;

    //tableView
    [self.view addSubview:self.photoTableView];
    
    //添加说明
    [self.view addSubview:self.overlayView];
}

//显示
- (void)show {
    
    self.displayingDetailedView = YES;
    self.view.userInteractionEnabled = YES;
    self.photoTableView.alpha = 1.0f;
    [photoTableView reloadData];
}

#pragma mark - Delegate

//加载数据
- (void)loadData {
    
    if (current <= [datas count]) {
        [self.photoTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:current - 1 inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    }
    
	[self show];
}

//-------------------tableView Delegate

//tableSection
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

//tableSectionCount
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSInteger number = [datas count];
    
    if (number > 0 && current == 1) {
        [self setupPhotoForIndex:1];
    }
    
    return number;
}

//显示cell
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
	cell.backgroundColor = [UIColor clearColor];
}

//cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
    
    return cell;
}

//配置cell
- (void)configureCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    typeof(self) __weak bself = self;
    
    ZTImageBrowZoomView *imageView = (ZTImageBrowZoomView *)[cell.contentView viewWithTag:1];
	if (!imageView) {
		imageView = [[ZTImageBrowZoomView alloc] initWithFrame:self.view.bounds];
		imageView.userInteractionEnabled = YES;
        imageView.didTapZoom = ^(ZTImageBrowZoomView * zoomView) {
            bself.displayingDetailedView = !bself.isDisplayingDetailedView;
        };
		
		UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(p_imageViewPanned:)];
		panGesture.delegate = self;
		panGesture.maximumNumberOfTouches = 1;
		panGesture.minimumNumberOfTouches = 1;
		[imageView addGestureRecognizer:panGesture];
		imageView.tag = 1;
        
		CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI_2);
		CGPoint origin = imageView.frame.origin;
		imageView.transform = transform;
        CGRect frame = imageView.frame;
        frame.origin = origin;
        imageView.frame = frame;
		
		[cell.contentView addSubview:imageView];
	} else {
        [imageView setZoomScale:1.0f];
    }
    
    ZTImageBrowModel *model = (ZTImageBrowModel *)[datas objectAtIndex:indexPath.row];
	
    if (model.img != nil) {
        [imageView setImage:model.img];
    } else {
        [imageView setURLImage:model.imgURL placeholderImage:model.imgURLplaceholderImage];
    }    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.displayingDetailedView = !self.isDisplayingDetailedView;
}

- (void)ZTNavigationActionLeft:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

//-------------------------- scrollView Delegate
//scrollView滑动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	
    [overlayView resetOverlayView];
    
	CGPoint targetContentOffset = scrollView.contentOffset;
    
	UITableView *tv = (UITableView*)scrollView;
	NSIndexPath *indexPathOfTopRowAfterScrolling = [tv indexPathForRowAtPoint:
													targetContentOffset
													];
	CGRect rectForTopRowAfterScrolling = [tv rectForRowAtIndexPath:
										  indexPathOfTopRowAfterScrolling
										  ];
	targetContentOffset.y = rectForTopRowAfterScrolling.origin.y;
	
	int index = floor(targetContentOffset.y / CGRectGetWidth(self.view.frame)) + 1;
	
	[self setupPhotoForIndex:index];
}

//设置位置
- (void)setupPhotoForIndex:(int)index {
    current = index;
    
    ZTImageBrowModel *model = [datas objectAtIndex:current - 1];
    
    if (!mIsNull(model.title)) {
		self.overlayView.title = model.title;
	} else {
        self.overlayView.title = @"";
    }
	
	if (!mIsNull(model.desc)) {
		self.overlayView.description = model.desc;
	} else {
        self.overlayView.description = @"";
    }
    
    //nav
    navigation.navTitle = [NSString stringWithFormat:@"%d/%d", current, (int)[datas count]];
}

//------------------------- Recognizers
- (void)p_imageViewPanned:(UIPanGestureRecognizer *)recognizer {
	
	if (recognizer.state == UIGestureRecognizerStateBegan) {
		self.photoTableView.scrollEnabled = NO;
		return;
	}
	
	if (recognizer.state == UIGestureRecognizerStateEnded) {
		self.photoTableView.scrollEnabled = YES;
	}
}

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    UIView *imageView = [gestureRecognizer view];
    CGPoint translation = [gestureRecognizer translationInView:[imageView superview]];
	
    // -- Check for horizontal gesture/
    if (fabsf(translation.x) > fabsf(translation.y)) {
        return YES;
	}
	
    return NO;
}

#pragma mark - GET/SET

//tableView
- (UITableView *)photoTableView {
	if (!photoTableView) {
        CGRect screenBounds = self.view.bounds;
		photoTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT, CGRectGetWidth(screenBounds))];
        photoTableView.dataSource = self;
        photoTableView.delegate = self;
        photoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        photoTableView.backgroundColor = [UIColor clearColor];
        photoTableView.rowHeight = screenBounds.size.width;
        photoTableView.pagingEnabled = YES;
        photoTableView.showsVerticalScrollIndicator = NO;
        photoTableView.showsHorizontalScrollIndicator = NO;
        photoTableView.alpha = 0.0f;
        
        // -- Rotate table horizontally
        CGAffineTransform rotateTable = CGAffineTransformMakeRotation(-M_PI_2);
        CGPoint origin = photoTableView.frame.origin;
        photoTableView.transform = rotateTable;
        CGRect frame = photoTableView.frame;
        frame.origin = origin;
        photoTableView.frame = frame;
	}
	
	return photoTableView;
}

//说明
- (ZTImageBrowOverlayView *)overlayView {
	if (!overlayView) {
        
        int y = 0;
        if (DEVICE_IOS_6) {
            y = 20;
        }
        
        overlayView = [[ZTImageBrowOverlayView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - NAVIGATION_BAR_HEIGHT - 120.0f + y, CGRectGetWidth(self.view.frame), 120.0f)];
	}
	
	return overlayView;
}

//是否显示说明
- (void)setDisplayingDetailedView:(BOOL)val {
    
    displayingDetailedView = val;
    
    if (displayingDetailedView) {
        [self.overlayView showOverlayAnimated:YES];
    } else {
        [self.overlayView hideOverlayAnimated:YES];
    }
}




@synthesize navigation;
@synthesize displayingDetailedView;
@synthesize overlayView;
@synthesize photoTableView;
@synthesize current;
@synthesize datas;
@end
