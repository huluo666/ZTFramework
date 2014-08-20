/*
 ============================================================================
 Name           : ZTSandbox.h
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTSandbox declaration
 ============================================================================
 */

#import "ZTPrecompile.h"

/**
 *ZTSandbox:沙盒机制
 *Author:Fighting
 **/
@interface ZTSandbox : NSObject

/** 单例模式 */
ZT_SINGLETON_AS(ZTSandbox);

/**
 *  程序目录，不能存任何东西
 *
 *  @return NSString
 */
+ (NSString *)appPath;

/**
 *  文档目录，需要ITUNES同步备份的数据存这里
 *
 *  @return NSString
 */
+ (NSString *)docPath;

/**
 *  配置目录，配置文件存这里
 *
 *  @return NSString
 */
+ (NSString *)libPrefPath;

/**
 *  缓存目录，系统在磁盘空间不足的情况下会删除里面的文件，ITUNES会删除
 *
 *  @return NSString
 */
+ (NSString *)libCachePath;

/**
 *  缓存目录，APP退出后，系统可能会删除这里的内容
 *
 *  @return NSString
 */
+ (NSString *)tmpPath;

/**
 *  资源目录
 *
 *  @param file 文件名
 *
 *  @return NSString
 */
+ (NSString *)resPath:(NSString *)file;

//----------------- 文件操作

/**
 *  文件是否存在，不存在创建目录
 *
 *  @param path 目录路径
 *
 *  @return NSString
 */
+ (BOOL)touch:(NSString *)path;

/**
 *  文件是否存在，不存在创建文件
 *
 *  @param file 文件路径
 *
 *  @return NSString
 */
+ (BOOL)touchFile:(NSString *)file;

/**
 *  创建目录
 *
 *  @param Path 目录路径
 */
+ (void)createDirectoryAtPath:(NSString *)Path;

/**
 *  返回目下所有给定后缀的文件的方法
 *
 *  @param direString 目录绝对路径
 *  @param fileType   文件后缀名
 *  @param operation  (预留,暂时没用)
 *
 *  @return NSArray
 */
+ (NSArray *)allFilesAtPath:(NSString *)direString type:(NSString*)fileType operation:(int)operation;

/**
 *  返回目录文件的size,单位字节
 *
 *  @param filePath 目录路径
 *  @param diskMode 是否是磁盘占用的size
 *
 *  @return uint64_t
 */
+ (uint64_t)sizeAtPath:(NSString *)filePath diskMode:(BOOL)diskMode;

@end
