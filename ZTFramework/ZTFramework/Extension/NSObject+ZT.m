/*
 ============================================================================
 Name           : NSObject+ZT.m
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : NSObject+ZT declaration
 ============================================================================
 */

#import "NSObject+ZT.h"
#import "ZTPrecompile.h"

@implementation NSObject (ZT)

//转换NSInteger
- (NSInteger)asNSInteger {
    return [[self asNSNumber] integerValue];
}

//转换CGFloat
- (CGFloat)asFloat {
    return [[self asNSNumber] floatValue];
}

//转换为NSNumber
- (NSNumber *)asNSNumber {
    if ([self isKindOfClass:[NSNumber class]]) {
        return (NSNumber *)self;
    } else if ([self isKindOfClass:[NSString class]]) {
        return [NSNumber numberWithInteger:[(NSString *)self integerValue]];
    } else if ([self isKindOfClass:[NSDate class]]) {
		return [NSNumber numberWithDouble:[(NSDate *)self timeIntervalSince1970]];
    } else if ([self isKindOfClass:[NSNumber class]]) {
		return [NSNumber numberWithInteger:0];
    }
    
    return nil;
}

//转换为Data
- (NSData *)asNSData {
    
    NSData * data = nil;
    
    if ([self isKindOfClass:[NSString class]]) {
        data = [(NSString *)self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    } else if ([self isKindOfClass:[NSData class]]) {
        data = (NSData *)self;
    }
    
    return data;
}

//转换为NSString
- (NSString *)asNSString {
    
    NSString * string = nil;
    
    if ([self isKindOfClass:[NSNull class]]) {
        return string;
    }
    
    if ([self isKindOfClass:[NSString class]]) {
        string = (NSString *)self;
    } else if ([self isKindOfClass:[NSData class]]) {
        NSData * data = (NSData *)self;
        string = [[NSString alloc] initWithBytes:data.bytes length:data.length encoding:NSUTF8StringEncoding];
    } else {
        string = [NSString stringWithFormat:@"%@", self];
    }
    
    return string;
}


//属性列表
- (NSArray *)attributeList {
    unsigned int propertyCount = 0;
    objc_property_t * properties = class_copyPropertyList([self class], &propertyCount);
    NSMutableArray * array = [[NSMutableArray alloc] init];
    for (NSUInteger i = 0; i < propertyCount; i++) {
        const char *name = property_getName(properties[i]);
        NSString *propertyName = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
        [array addObject:propertyName];

#if (1 == __ZTDEBUG__)
        const char *attr = property_getAttributes(properties[i]);
        ZTLogD(@"NSArray+ZT %@, %s", propertyName, attr);
#endif
    }
    
    free(properties);
    return array;
}

@end
