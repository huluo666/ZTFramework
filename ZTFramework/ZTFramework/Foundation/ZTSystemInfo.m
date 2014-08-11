/*
 ============================================================================
 Name           : ZTSystemInfo.m
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTSystemInfo declaration
 ============================================================================
 */

#import "ZTSystemInfo.h"

@implementation ZTSystemInfo

#pragma mark - Public

//OS版本
+ (NSString *)osVersion {
#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
	return [NSString stringWithFormat:@"%@ %@", [UIDevice currentDevice].systemName, [UIDevice currentDevice].systemVersion];
#else
	return nil;
#endif
}

//App版本
+ (NSString *)appVersion {
#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR || TARGET_OS_MAC)
	NSString * value = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
	if (nil == value || 0 == value.length ) {
		value = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersion"];
	}
	return value;
#else
	return nil;
#endif
}

//AppIdentifier
+ (NSString *)appIdentifier {
#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
	static NSString * __identifier = nil;
	if (nil == __identifier) {
		__identifier = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
	}
	return __identifier;
#else
	return @"";
#endif
}

//appSchema
+ (NSString *)appSchema {
	return [self appSchema:nil];
}

//appSchema
+ (NSString *)appSchema:(NSString *)name {
#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
	NSArray * array = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleURLTypes"];
	for ( NSDictionary * dict in array ) {
		if ( name ) {
			NSString * URLName = [dict objectForKey:@"CFBundleURLName"];
			if ( nil == URLName ) {
				continue;
			}
            
			if ( NO == [URLName isEqualToString:name] ) {
				continue;
			}
		}
        
		NSArray * URLSchemes = [dict objectForKey:@"CFBundleURLSchemes"];
		if ( nil == URLSchemes || 0 == URLSchemes.count ) {
			continue;
		}
        
		NSString * schema = [URLSchemes objectAtIndex:0];
		if ( schema && schema.length ) {
			return schema;
		}
	}
    
	return nil;
#else
	return nil;
#endif
}

//设备的类别
+ (NSString *)deviceModel {
#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
	return [UIDevice currentDevice].model;
#else
	return nil;
#endif
}

//设备识别码
+ (NSString *)deviceUUID {
#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
#else
    return nil;
#endif
}

//设备名称
+ (NSString *)deviceName {
#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
    return [[UIDevice currentDevice] name];
#else
    return nil;
#endif
}

//是否retina屏
+ (BOOL)deviceIsRetina {
    return [UIScreen mainScreen].scale == 2;
}

//是否越狱
#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
static const char * __jb_app = NULL;
#endif

+ (BOOL)deviceIsJailBroken NS_AVAILABLE_IOS(4_0) {
#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
	static const char * __jb_apps[] = {
		"/Application/Cydia.app",
		"/Application/limera1n.app",
		"/Application/greenpois0n.app",
		"/Application/blackra1n.app",
		"/Application/blacksn0w.app",
		"/Application/redsn0w.app",
		NULL
	};
    
    __jb_app = NULL;
    
	// method 1
    for ( int i = 0; __jb_apps[i]; ++i ) {
        if ( [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithUTF8String:__jb_apps[i]]] ) {
			__jb_app = __jb_apps[i];
			return YES;
        }
    }
	
    // method 2
	if ( [[NSFileManager defaultManager] fileExistsAtPath:@"/private/var/lib/apt/"] ) {
		return YES;
	}
	
	// method 3
	if ( 0 == system("ls") ) {
		return YES;
	}
#endif
	
    return NO;
}

+ (NSString *)devicejailBreaker NS_AVAILABLE_IOS(4_0) {
#if (TARGET_OS_IPHONE)
	if ( __jb_app ) {
		return [NSString stringWithUTF8String:__jb_app];
	}
#endif
    
	return @"";
}

//是否是Iphone设备
+ (BOOL)deviceIsPhone {
#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
	NSString * deviceType = [UIDevice currentDevice].model;
	
	if ([deviceType rangeOfString:@"iPhone" options:NSCaseInsensitiveSearch].length > 0 ||
		[deviceType rangeOfString:@"iPod" options:NSCaseInsensitiveSearch].length > 0 ||
		[deviceType rangeOfString:@"iTouch" options:NSCaseInsensitiveSearch].length > 0 ) {
		return YES;
	}
#endif
	
	return NO;
}

//是否是iPad设备
+ (BOOL)deviceIsPad {
#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
	NSString * deviceType = [UIDevice currentDevice].model;
	
	if ( [deviceType rangeOfString:@"iPad" options:NSCaseInsensitiveSearch].length > 0 ) {
		return YES;
	}
#endif
	
	return NO;
}

//是否Iphone
+ (BOOL)isPhone {
	if ( [self isPhone35] || [self isPhoneRetina35] || [self isPhoneRetina4] ) {
		return YES;
	}
	
	return NO;
}

//是否3.5寸iphone
+ (BOOL)isPhone35 {
#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
	if ([self deviceIsPad]) {
		if ([self requiresPhoneOS] && [self isPad] ) {
			return YES;
		}
        
		return NO;
	} else {
		return [ZTSystemInfo isScreenSize:CGSizeMake(320, 480)];
	}
#else
	return NO;
#endif
}

//是否3.5寸iphone retina
+ (BOOL)isPhoneRetina35 {
#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
	if ( [self deviceIsPad] ) {
		if ( [self requiresPhoneOS] && [self isPadRetina] ) {
			return YES;
		}
        
		return NO;
	}
	else {
		return [ZTSystemInfo isScreenSize:CGSizeMake(640, 960)];
	}
#else
	return NO;
#endif
}

//是否4寸iphone retina
+ (BOOL)isPhoneRetina4 {
#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
	if ( [self deviceIsPad] ){
		return NO;
	} else {
		return [ZTSystemInfo isScreenSize:CGSizeMake(640, 1136)];
	}
#else
	return NO;
#endif
}

//是否Ipad
+ (BOOL)isPad {
#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
	return [ZTSystemInfo isScreenSize:CGSizeMake(768, 1024)];
#else
	return NO;
#endif
}

//是否Ipad Retina
+ (BOOL)isPadRetina {
#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
	return [ZTSystemInfo isScreenSize:CGSizeMake(1536, 2048)];
#else	// #if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
	return NO;
#endif	// #if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
}

//--------------------------页面相关

//nav高度
+ (CGFloat)NavigationHeight {        
    return 64.0f;
}

//tabBar高度
+ (CGFloat)TabBarHeight {
    return 49.0f;
}

//键盘高度
+ (CGFloat)KeyboardHeight {
    return 216.0f;
}

#pragma mark - Private

//是否指定屏幕大小
+ (BOOL)isScreenSize:(CGSize)size {
#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
	if ( [UIScreen instancesRespondToSelector:@selector(currentMode)] ) {
		CGSize size2 = CGSizeMake( size.height, size.width );
		CGSize screenSize = [UIScreen mainScreen].currentMode.size;
		
		if ( CGSizeEqualToSize(size, screenSize) || CGSizeEqualToSize(size2, screenSize) ) {
			return YES;
		}
	}
    
	return NO;
#else
	return NO;
#endif
}

//获取phoneOS系统
+ (BOOL)requiresPhoneOS {
#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
	return [[[NSBundle mainBundle].infoDictionary objectForKey:@"LSRequiresIPhoneOS"] boolValue];
#else
	return NO;
#endif
}

@end
