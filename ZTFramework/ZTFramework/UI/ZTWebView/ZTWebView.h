/*
 ============================================================================
 Name           : ZTWebView.h
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTWebView declaration
 ============================================================================
 */

#import "ZTKit.h"

typedef void(^ ZTWebViewBlock)();

/**
 *  WebView点击回调块
 *
 *  @param fun 方法名
 *  @param dic 数据
 */
typedef void(^ ZTWebViewClickBlock)(NSString *fun, NSDictionary *dic);

/**
 *ZTWebView:WebView
 *Author:Fighting
 **/
@interface ZTWebView : UIView

/** 加载结束 */
@property (nonatomic, copy)                 ZTWebViewBlock          loadSuccess;

/** 加载失败 */
@property (nonatomic, copy)                 ZTWebViewBlock          loadFail;

/** 加载中 */
@property (nonatomic, copy)                 ZTWebViewBlock          loading;

/** 点击 */
@property (nonatomic, copy)                 ZTWebViewClickBlock     webViewClick;

/** 内容自适应 */
@property (nonatomic, unsafe_unretained)    BOOL                    contentFitFlag;


/**
 *  加载URL
 *
 *  @param url URL
 */
-(void)loadURL:(NSString *)url;

/**
 *  加载本地URL
 *
 *  @param url URL
 */
-(void)loadLocationURL:(NSString *)url;

@end
