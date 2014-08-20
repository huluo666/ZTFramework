/*
 ============================================================================
 Name           : ZTQRCode.h
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTQRCode declaration
 ============================================================================
 */

#import "ZTKit.h"

/** 二维码类型 */
typedef NS_ENUM(NSInteger, QRcodeType) {
    QRcodeType_RQCode,            /** 二维码 */
    QRcodeType_BarCode            /** 条形码 */
};

/** 回调 */
typedef void(^ ZTQRCode_BLOCK)(NSString *val);

/**
 *ZTQRCode:二维码/条形码扫描视图，生成二维码图片
 *Author:Fighting
 **/
@interface ZTQRCode : NSObject

/** 扫描结束，回调 */
@property (nonatomic, ZT_ARC_STRONG) ZTQRCode_BLOCK QRcodeDidEndScan;

/**
 *  二维码扫描，条形码扫描
 *
 *  @param view 主视图
 *  @param type 类型
 */
- (void)QRcodeScan:(UIView *)view type:(QRcodeType)type;

/**
 *  停止扫描
 */
- (void)QRcodeDidStopScan;

/**
 *  启动扫描
 */
- (void)QRcodeDidStartScan;

/**
 *  二维码生成
 *
 *  @param str  值
 *  @param size 大小
 *
 *  @return UIImage
 */
- (UIImage *)QRcodeDidBuilder:(NSString *)str size:(CGFloat)size;

@end
