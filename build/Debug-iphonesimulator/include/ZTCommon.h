/*
 ============================================================================
 Name           : ZTCommon.h
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTCommon declaration
 ============================================================================
 */

#import "ZTPrecompile.h"

/**
 *  劫持类方法
 *
 *  @param c           类
 *  @param original    原方法
 *  @param replacement 劫持后的方法
 *
 *  @return 返回劫持前的方法original
 */
static Method ZT_COMMON_SwizzleInstanceMethod(Class c, SEL original, SEL replacement) {
    Method a = class_getInstanceMethod(c, original);
    Method b = class_getInstanceMethod(c, replacement);
    
    // class_addMethod 为该类增加一个新方法
    if (class_addMethod(c, original, method_getImplementation(b), method_getTypeEncoding(b))) {
        // 替换类方法的定义
        class_replaceMethod(c, replacement, method_getImplementation(a), method_getTypeEncoding(a));
        return b;   // 返回劫持前的方法
    }
    
    // 交换2个方法的实现
    method_exchangeImplementations(a, b);
    return b;   // 返回劫持前的方法
}

/** 是否为null */
#define ZT_M_IsNull(x)              ([ZTCommon isNull:x])

/** 加载图片 */
#define ZT_M_ImageByName(x)         ([ZTCommon imageByName:x])

/** 加载图片 */
#define ZT_M_ImageByPath(x, e)      ([ZTCommon imageByPath:(x) ext:(e)])






/**
 *ZTCommon:公共
 *Author:Fighting
 **/
@interface ZTCommon : NSObject

/**
 *  是否null
 *
 *  @param sender id
 *
 *  @return BOOL
 */
+ (BOOL)isNull:(id)sender;

/**
 *  加载图片
 *
 *  @param name 图片名称
 *  @param ext  猴子
 *
 *  @return UIImage
 */
+ (UIImage *)imageByPath:(NSString *)name ext:(NSString *)ext;

/**
 *  加载图片
 *
 *  @param img 图片名称
 *
 *  @return UIImage
 */
+ (UIImage *)imageByName:(NSString *)img;

/**
 *  获取Bundle图片
 *
 *  @param name 图片名
 *
 *  @return UIImage
 */
+ (UIImage *)imageByZTBundle:(NSString *)name;

@end
