/*
 ============================================================================
 Name           : ZTSandbox.m
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTSandbox declaration
 ============================================================================
 */

#import "ZTSandbox.h"
#import "ZTFoundation.h"
#import <sys/stat.h>

@interface ZTSandbox() {
    NSString *_appPath;
    NSString *_docPath;
    NSString *_libPrefPath;
    NSString *_libCachePath;
    NSString *_tmpPath;
}

@end

@implementation ZTSandbox

ZT_SINGLETON_DEF(ZTSandbox);

#pragma mark - Public

//程序目录，不能存任何东西
+ (NSString *)appPath {
    return [[ZTSandbox sharedInstance] appPath];
}

- (NSString *)appPath {
    if (ZT_M_IsNull(_appPath)) {
		NSError * error = nil;
		NSArray * paths = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:NSHomeDirectory() error:&error];
        
		for ( NSString * path in paths ) {
			if ( [path hasSuffix:@".app"] ) {
				_appPath = [NSString stringWithFormat:@"%@/%@", NSHomeDirectory(), path];
				break;
			}
		}
	}
    
	return _appPath;
}

//文档目录，需要ITUNES同步备份的数据存这里
+ (NSString *)docPath {
	return [[ZTSandbox sharedInstance] docPath];
}

- (NSString *)docPath {
	if (ZT_M_IsNull(_docPath)) {
		NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		_docPath = [paths objectAtIndex:0];
	}
	
	return _docPath;
}

//配置目录，配置文件存这里
+ (NSString *)libPrefPath {
	return [[ZTSandbox sharedInstance] libPrefPath];
}

- (NSString *)libPrefPath {
	if (ZT_M_IsNull(_libPrefPath)) {
		NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
		NSString * path = [[paths objectAtIndex:0] stringByAppendingFormat:@"/Preference"];
		
		[self touch:path];
        
		_libPrefPath = path;
	}
    
	return _libPrefPath;
}

//缓存目录，系统在磁盘空间不足的情况下会删除里面的文件，ITUNES会删除
+ (NSString *)libCachePath {
    return [[ZTSandbox sharedInstance] libCachePath];
}

- (NSString *)libCachePath {
	if (ZT_M_IsNull(_libCachePath)) {
		NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
		NSString * path = [[paths objectAtIndex:0] stringByAppendingFormat:@"/Caches"];
        
		[self touch:path];
		
		_libCachePath = path;
	}
	
	return _libCachePath;
}

//缓存目录，APP退出后，系统可能会删除这里的内容
+ (NSString *)tmpPath {
	return [[ZTSandbox sharedInstance] tmpPath];
}

- (NSString *)tmpPath {
	if (ZT_M_IsNull(_tmpPath)) {
		NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
		NSString * path = [[paths objectAtIndex:0] stringByAppendingFormat:@"/tmp"];
		
		[self touch:path];
        
		_tmpPath = path;
	}
    
	return _tmpPath;
}

//资源目录
+ (NSString *)resPath:(NSString *)file {
    return [[ZTSandbox sharedInstance] resPath:file];
}

- (NSString *)resPath:(NSString *)file {
    NSString *str =[file stringByDeletingPathExtension];
    NSString *str2 = [file pathExtension];
    return [[NSBundle mainBundle] pathForResource:str ofType:str2];
}

//---------------------- 文件操作

//文件是否存在，不存在创建目录
+ (BOOL)touch:(NSString *)path {
	return [[ZTSandbox sharedInstance] touch:path];
}

- (BOOL)touch:(NSString *)path {
	if ( NO == [[NSFileManager defaultManager] fileExistsAtPath:path] ) {
		return [[NSFileManager defaultManager] createDirectoryAtPath:path
										 withIntermediateDirectories:YES
														  attributes:nil
															   error:NULL];
	}
	
	return YES;
}

//文件是否存在，不存在创建文件
+ (BOOL)touchFile:(NSString *)file {
	return [[ZTSandbox sharedInstance] touchFile:file];
}

- (BOOL)touchFile:(NSString *)file {
	if ( NO == [[NSFileManager defaultManager] fileExistsAtPath:file] ) {
		return [[NSFileManager defaultManager] createFileAtPath:file
													   contents:[NSData data]
													 attributes:nil];
	}
	
	return YES;
}

//创建目录
+ (void)createDirectoryAtPath:(NSString *)Path {
    if ( NO == [[NSFileManager defaultManager] fileExistsAtPath:Path isDirectory:NULL] ) {
        BOOL ret = [[NSFileManager defaultManager] createDirectoryAtPath:Path
                                             withIntermediateDirectories:YES
                                                              attributes:nil
                                                                   error:nil];
        if ( NO == ret ) {
            ZTLogD(@"%s, create %@ failed", __PRETTY_FUNCTION__, Path);
            return;
        }
    }
}

//返回目下所有给定后缀的文件的方法
+(NSArray *) allFilesAtPath:(NSString *)direString type:(NSString*)fileType operation:(int)operatio{
    NSMutableArray *pathArray = [NSMutableArray array];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *tempArray = [fileManager contentsOfDirectoryAtPath:direString error:nil];
    
    if (ZT_M_IsNull(tempArray)) {
        return nil;
    }
    
    NSString* type = [NSString stringWithFormat:@".%@",fileType];
    for (NSString *fileName in tempArray) {
        BOOL isDir = YES;
        NSString *fullPath = [direString stringByAppendingPathComponent:fileName];
        
        if ([fileManager fileExistsAtPath:fullPath isDirectory:&isDir]){
            if (!isDir && [fileName hasSuffix:type]) {
                [pathArray addObject:fullPath];
            }
        }
    }
    
    return pathArray;
}

//返回目录文件的size,单位字节
+ (uint64_t)sizeAtPath:(NSString *)filePath diskMode:(BOOL)diskMode{
    uint64_t totalSize = 0;
    NSMutableArray *searchPaths = [NSMutableArray arrayWithObject:filePath];
    while ([searchPaths count] > 0) {
        @autoreleasepool {
            NSString *fullPath = [NSString stringWithString:[searchPaths objectAtIndex:0]];
            [searchPaths removeObjectAtIndex:0];
            
            struct stat fileStat;
            if (lstat([fullPath fileSystemRepresentation], &fileStat) == 0) {
                if (fileStat.st_mode & S_IFDIR) {
                    NSArray *childSubPaths = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:fullPath error:nil];
                    for (NSString *childItem in childSubPaths) {
                        NSString *childPath = [fullPath stringByAppendingPathComponent:childItem];
                        [searchPaths insertObject:childPath atIndex:0];
                    }
                } else {
                    if (diskMode) {
                        totalSize += fileStat.st_blocks * 512;
                    } else {
                        totalSize += fileStat.st_size;
                    }
                }
            }
        }
    }
    
    return totalSize;
}

#pragma mark - Private

@end
