/*
 ============================================================================
 Name           : ZTWebView.m
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTWebView declaration
 ============================================================================
 */

#import "ZTWebView.h"

@interface ZTWebView()<UIWebViewDelegate>

/** webview */
@property (nonatomic, ZT_ARC_STRONG) UIWebView *webview;

@end

@implementation ZTWebView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self webViewHiddenBackgroud];
        
        webview.backgroundColor = [UIColor clearColor];
        webview.opaque = NO;
        webview.delegate = self;
        webview.dataDetectorTypes = 0;
        webview.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
        [self addSubview:webview];
    }
    return self;
}

- (void)dealloc {
    [webview loadHTMLString:@"" baseURL:nil];
    webview.delegate = nil;
    [self removeFromSuperview];
}

//隐藏webView
-(void)webViewHiddenBackgroud {
    for (UIView *view in [[webview.subviews objectAtIndex:0] subviews]) {
        if ([[[view class] description] isEqualToString:@"UIImageView"]) {
            [view setHidden:YES];
        }
    }
}

//加载远程URL
-(void)loadURL:(NSString *)url {
    NSString *tmpURL = [NSString stringWithFormat:@"%@", url];
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:tmpURL]]];
}

//加载本地URL
-(void)loadLocationURL:(NSString *)url {
    
    //解析分离参数和路径
    NSMutableArray *tmpArray = [NSMutableArray arrayWithArray:[url componentsSeparatedByString:@"?"]];
    
    //临时URL
    NSString *tmpURL = [tmpArray objectAtIndex:0];
    
    //查找根目录
    NSRange urlBaseRange = [tmpURL rangeOfString:@"/"];
    NSString *urlBasePath = [tmpURL substringToIndex:urlBaseRange.location];
    tmpURL = [tmpURL substringFromIndex:urlBaseRange.location];
    
    //文件格式
    NSRange urlExtendsRange = [tmpURL rangeOfString:@"."];
    NSString *urlExtends = [tmpURL substringFromIndex:urlExtendsRange.location+1];
    tmpURL = [tmpURL substringToIndex:urlExtendsRange.location];
    
    //文件路径
    NSString *urlPath = [tmpURL substringFromIndex:1];
    
    ZTLogD(@"urlBasePath===>%@, urlExtends===>%@, urlPath===>%@", urlBasePath, urlExtends, urlPath);
    
    //获取文件
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:urlPath ofType:urlExtends inDirectory:urlBasePath];
    
    NSString *encodedPath = [NSString stringWithFormat:@"file://%@", [htmlFile stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]];
    
    //组合参数
    if ([tmpArray count] > 1) {
        encodedPath = [NSString stringWithFormat:@"%@?%@", encodedPath, [tmpArray objectAtIndex:1]];
    }
    
    NSURL *urlStr = [NSURL URLWithString:encodedPath];
    NSURLRequest *request = [NSURLRequest requestWithURL:urlStr];
    [webview loadRequest:request];
}

#pragma mark
#pragma mark ------------------webview delegate----------------------

//加载结束
-(void)webViewDidFinishLoad:(UIWebView *)webView {
    
    //禁止用户选择
    [webview stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    
    //禁用长按弹出框
    [webview stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
    
    [webview setHidden:NO];
    
    if (loadSuccess) {
        loadSuccess();
    }
}

//解析WEBVIEW
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    ZTLogD(@"scheme===>%@", request.URL.scheme);
    
    // 处理事件
    NSString *requestString = [[request URL] absoluteString];
    
    ZTLogD(@"request===>%@", requestString);
    
    if ([[requestString substringToIndex:5] isEqualToString:@"tc://"]) {
        NSMutableArray *tmpArray = [NSMutableArray arrayWithArray:[requestString componentsSeparatedByString:@"::"]];
        
        NSString *fun = [[tmpArray objectAtIndex:0] substringFromIndex:5];
        [tmpArray removeObjectAtIndex:0];
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        
        for (int i = 0, c = (int) [tmpArray count]/2; i < c; i++) {
            //key 0 2 4  i*2
            //value 1 3 5 i*2 + 1
            
            [dic setValue:[tmpArray objectAtIndex:(i*2) + 1] forKey:[tmpArray objectAtIndex:(i*2)]];
        }
        
        if (webViewClick) {
            webViewClick(fun, dic);
        }
        
        return NO;
    }
    
    return YES;
}

//正在加载
-(void)webViewDidStartLoad:(UIWebView *)webView {
    
    if (loading) {
        loading();
    }
    
    [webview setHidden:YES];
}

//加载失败
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    if (loadFail) {
        loadFail();
    }
}

#pragma mark - Public

- (void)setContentFitFlag:(BOOL)flag {
    if (flag) {
        [webview setScalesPageToFit:YES];
    }
}




@synthesize webViewClick;
@synthesize loading;
@synthesize loadFail;
@synthesize loadSuccess;
@synthesize webview;
@end
