/*
 ============================================================================
 Name           : ZTTableSectionModel.m
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTTableSectionModel declaration
 ============================================================================
 */

#import "ZTTableSectionModel.h"

@implementation ZTTableSectionModel

- (instancetype)initConfigWith:(NSString *)t key:(NSString *)k {
    if (self = [super init]) {
        title = t;
        key = k;
    }
    
    return self;
}

@synthesize title;
@synthesize key;
@end
