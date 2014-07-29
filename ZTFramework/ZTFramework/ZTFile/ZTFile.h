/*
 ============================================================================
 Name           : ZTFile.h
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTFile declaration
 ============================================================================
 */

#import "ZTKit.h"

/**
 *ZTFile:文件/文件夹相关操作
 *Author:Fighting
 **/
@interface ZTFile : NSObject

/**
 *  文件写入
 *
 *  @param fileFullPath 文件全路径
 *  @param content      内容
 */
+ (void)write:(NSString *)fileFullPath content:(NSString *)content;

/**
 *  文件夹是否存在
 *
 *  @param dir 文件夹路径
 *
 *  @return BOOL
 */
+ (BOOL)dirExists:(NSString *)dir;

/**
 *  文件是否存在
 *
 *  @param fileFullPath 文件全路径
 *
 *  @return BOOL
 */
+ (BOOL)fileExists:(NSString *)fileFullPath;

@end
