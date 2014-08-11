/*
 ============================================================================
 Name           : ZTReachability.m
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTReachability declaration
 ============================================================================
 */

#import "ZTReachability.h"
#import "Reachability.h"

@implementation ZTReachability

ZTSingleton(ZTReachability);

//获取网络类型
- (NetworkStatus) NetworkReachabilityType {
    return [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
}

//是否有网络
- (BOOL)isEnableNet {
    
#if (1 == __ZTDEBUG__)
    return YES;
#else
    
    BOOL result = YES;
    
    if ([self NetworkReachabilityType] == NotReachable) {
        result = NO;
    }
    
    return result;
#endif
}

//是否wifi
- (BOOL)isEnableWIFI {
    return [self NetworkReachabilityType] == ReachableViaWiFi ? YES : NO;
}

//是否3G
- (BOOL)isEnable3G {
    return [self NetworkReachabilityType] == ReachableViaWWAN ? YES : NO;
}

//返回当前网络类型字符串
- (NSString *)NetworkString {
    if (![self isEnableNet]) {
        return @"Not Network";
    }
    
    if ([self isEnableWIFI]) {
        return @"WIFI";
    }
    
    if ([self isEnable3G]) {
        return @"3G";
    }
    
    return @"Other";
}


@end