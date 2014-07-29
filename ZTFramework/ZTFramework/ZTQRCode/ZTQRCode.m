/*
 ============================================================================
 Name           : ZTQRCode.m
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTQRCode declaration
 ============================================================================
 */

#import "ZTQRCode.h"
#import "ZBarSDK.h"
#import "QRCodeGenerator.h"

@interface ZTQRCode()<ZBarReaderViewDelegate>

/** 扫描回调方法 */
@property (nonatomic, copy)                 ZTBLOCK_1       QRcodeDidEndScanBlock;

/** 扫描区域视图 */
@property (nonatomic, strong)               ZBarReaderView  *readerView;

@end


@implementation ZTQRCode

- (void)dealloc {
    [readerView stop];
    QRcodeDidEndScanBlock = nil;
    readerView.readerDelegate = nil;
}

#pragma mark - Private

//扫描区域坐标转换
-(CGRect)scanCropDraw:(CGRect)rect readerViewBounds:(CGRect)readerViewBounds {
    CGFloat x,y,width,height;
    
    x = rect.origin.x / readerViewBounds.size.width;
    y = rect.origin.y / readerViewBounds.size.height;
    width = rect.size.width / readerViewBounds.size.width;
    height = rect.size.height / readerViewBounds.size.height;
    
    return CGRectMake(x, y, width, height);
}

//扫描后回调
- (void)readerView:(ZBarReaderView *)zbar didReadSymbols:(ZBarSymbolSet *)symbols fromImage:(UIImage *)image {
    ZBarSymbol *symbol = nil;
    for (symbol in symbols) {
        break;
    }
    
    NSLog(@"scanning===>%@", symbol.data);
    
    [zbar stop];
    
    if (QRcodeDidEndScanBlock) {
        QRcodeDidEndScanBlock(symbol.data);
    }
}

#pragma mark - Delegate

#pragma mark - Public

//二维码扫描
- (void)QRcodeScan:(UIView *)view type:(QRcodeType)type {
    
    if (readerView == nil) {
        readerView = [[ZBarReaderView alloc]init];
        readerView.frame = CGRectMake(0, 0, CGRectGetWidth(view.bounds), CGRectGetHeight(view.bounds));
        readerView.readerDelegate = self;
        [view addSubview:readerView];
        [view sendSubviewToBack:readerView];
        
        //扫描区域
        CGRect scanMaskRect = CGRectMake(0, 0, CGRectGetWidth(view.bounds), CGRectGetHeight(view.bounds));
        
        //扫描区域计算
        readerView.scanCrop = [self scanCropDraw:scanMaskRect readerViewBounds:readerView.bounds];
    }
    
    ZBarImageScanner * scanner = readerView.scanner;
    
    switch (type) {
            //二维码扫描
        case QRcodeType_RQCode:
            [scanner setSymbology:ZBAR_QRCODE config:ZBAR_CFG_ENABLE to:1];
            break;
            
            //条形码扫描
        case QRcodeType_BarCode:
            [scanner setSymbology:ZBAR_I25 config:ZBAR_CFG_ENABLE to:0];
            break;
            
        default:
            break;
    }
}

//启动扫描
- (void)QRcodeDidStartScan {
    
    if (readerView == nil) {
        return;
    }
    
    [readerView start];
}

//停止扫描
- (void)QRcodeDidStopScan {
    
    if (readerView == nil) {
        return;
    }
    
    [readerView stop];
}

//二维码生成
- (UIImage *)QRcodeDidBuilder:(NSString *)str size:(CGFloat)size {
    
    UIImage *img = nil;
    
    if (str == nil || [str isEqual:[NSNull null]] || [str length] < 1) {
        return img;
    }
    
    return [QRCodeGenerator qrImageForString:str imageSize:size];
}

#pragma mark - GET/SET

//扫描回调
- (void)setQRcodeDidEndScan:(ZTBLOCK_1)block {
    QRcodeDidEndScanBlock = [block copy];
}




@synthesize QRcodeDidEndScanBlock;
@synthesize readerView;

@end
