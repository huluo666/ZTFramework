/*
 ============================================================================
 Name           : ZTCommon.m
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTCommon declaration
 ============================================================================
 */

#import "ZTCommon.h"

/** ZTFrameworkBundle */
static const char ZTFrameworkBundle[32] = "ZTFrameworkBundle.bundle/Images";

@implementation ZTCommon

//判断是否为null
+ (BOOL)isNull:(id)sender {
    if (sender == nil || (NSNull *)sender == [NSNull null]) {
        return YES;
    }
    
    return NO;
}

//加载图片
+ (UIImage *)imageByPath:(NSString *)name ext:(NSString *)ext {
    if ([self isNull:name]) {
        return nil;
    }
    
    return [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:name ofType:ext]];
}

//加载图片
+ (UIImage *)imageByName:(NSString *)img {
    
    if ([self isNull:img]) {
        return nil;
    }
    
    return [self imageByPath:img ext:@"png"];
}

//获取Bundle图片
+ (UIImage *)imageByZTBundle:(NSString *)name {
    NSString *path = [NSString stringWithFormat:@"%s/%@", ZTFrameworkBundle, name];
    return [self imageByPath:path ext:@"png"];
}

@end
