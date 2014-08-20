/*
 ============================================================================
 Name           : NSObject+ZT.h
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : NSObject+ZT declaration
 ============================================================================
 */

#import <Foundation/Foundation.h>

/**
 *NSObject+ZT:NSObject扩展
 *Author:Fighting
 **/
@interface NSObject (ZT)

/** 属性列表 */
@property (nonatomic, readonly, strong) NSArray * attributeList;

/**
 *  转换NSInteger
 *
 *  @return NSInteger
 */
- (NSInteger)asNSInteger;

/**
 *  转换CGFloat
 *
 *  @return CGFloat
 */
- (CGFloat)asFloat;

/**
 *  转换为NSNumber
 *
 *  @return NSNumber
 */
- (NSNumber *)asNSNumber;

/**
 *  转换为NSData
 *
 *  @return NSData
 */
- (NSData *)asNSData;

/**
 *  转换为NSString
 *
 *  @return NSString
 */
- (NSString *)asNSString;

@end
