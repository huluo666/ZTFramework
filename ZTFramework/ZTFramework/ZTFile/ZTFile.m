/*
 ============================================================================
 Name           : ZTFile.m
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTFile declaration
 ============================================================================
 */

#import "ZTFile.h"

/** 文件分割线 */
static const char fileSep = '/';

@implementation ZTFile

//写文件
+ (void)write:(NSString *)fileFullPath content:(NSString *)content {
    
    NSMutableArray *tmpAry = [NSMutableArray arrayWithArray:[fileFullPath componentsSeparatedByString:[NSString stringWithFormat:@"%c", fileSep]]];
    [tmpAry removeObject:[tmpAry lastObject]];
    
    //路径
    NSString *filePath = [tmpAry componentsJoinedByString:[NSString stringWithFormat:@"%c", fileSep]];
    
    //创建目录和文件
    NSFileManager *fm = [NSFileManager defaultManager];
    
    //目录是否存在
    if (![self dirExists:filePath]) {
        [fm createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    //文件是否存在
    if (![self fileExists:fileFullPath]) {
        [fm createFileAtPath:fileFullPath contents:nil attributes:nil];
    }
    
    //写入内容
    NSError *error = nil;
    [content writeToFile:fileFullPath atomically:YES encoding:NSUTF8StringEncoding error:&error];
}

//文件夹是否存在
+ (BOOL)dirExists:(NSString *)dir {
    
    NSFileManager *fm = [NSFileManager defaultManager];
    
    BOOL isDir = NO;
    BOOL existed = [fm fileExistsAtPath:dir isDirectory:&isDir];
    if (!(isDir == YES && existed == YES)) {
        return NO;
    }
    
    return YES;
}

//文件是否存在
+ (BOOL)fileExists:(NSString *)fileFullPath {
    NSFileManager *fm = [NSFileManager defaultManager];
    
    if (![fm fileExistsAtPath:fileFullPath]) {
        return NO;
    }
    
    return YES;
}

@end
