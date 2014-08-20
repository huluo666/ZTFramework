/*
 ============================================================================
 Name           : ZTExt_LKDBHelper.m
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTExt_LKDBHelper declaration
 ============================================================================
 */

#import "ZTExt_LKDBHelper.h"
#import "LKDBHelper.h"
#import "NSObject+ZT.h"

#pragma mark - ZTExt_LKDBHelper

@implementation ZTExt_LKDBHelper

@end

#pragma mark - NSArray+ZTExt_LKDBHelper

@implementation NSArray (ZTExt_LKDBHelper)

//保存所有数据到sqlite db中
- (void)saveAllToDB {
    if (1 > self.count) {
        return;
    }
    
    //数据库对象
    NSObject *obj = [self objectAtIndex:0];
    
    LKDBHelper * globalHelper = [LKDBHelper getUsingLKDBHelper];
    
    //创建表
    [globalHelper createTableWithModelClass:[obj class]];
    
    //异步 插入数据
    [globalHelper executeDB:^(FMDatabase *db) {
        [db beginTransaction];
        
        for (NSObject *anObject2 in self) {
            [globalHelper insertToDB:anObject2];
        }
        
        BOOL insertSuccess = YES;
        
        if (NO == insertSuccess) {        //插入失败,事务回滚,预留代码
            [db rollback];
        } else {        //执行成功
            [db commit];
        }
    }];
}

//加载数据DB到ModelClass中
+ (id)loadFromDBWithClass:(Class)modelClass {
    NSString *str = [modelClass primaryKeyAndDESC];
    NSMutableArray *arraySync = [modelClass searchWithWhere:nil orderBy:str offset:0 count:100];
    return arraySync;
}

@end


#pragma mark - NSObject+ZTExt_LKDBHelper

@implementation NSObject (ZTExt_LKDBHelper)

- (void)loadFromDB {
    id value = [self valueForKey:[self.class getPrimaryKey]];
    NSString * strValue = nil;
    NSString * str = nil;
    
    if (nil == value) {
        return;
    }
    
    if ([value isKindOfClass:[NSString class]]) {
        strValue = value;
        str = [NSString stringWithFormat:@"%@ = '%@'", [self.class getPrimaryKey], strValue];
    } else if ([value isKindOfClass:[NSNumber class]]) {
        strValue = [value stringValue];
        str = [NSString stringWithFormat:@"%@ = %@", [self.class getPrimaryKey], strValue];
    } else {
        strValue = @"";
    }
    
    NSMutableArray *arraySync = [self.class searchWithWhere:str orderBy:nil offset:0 count:1];
    
    if (0 >= arraySync.count) {
        return;
    }
    
    NSObject *temp = [arraySync objectAtIndex:0];
    
    for (NSString *attribute in self.attributeList) {
        [self setValue:[temp valueForKey:attribute] forKey:attribute];
    }
}

//关键字Key Desc
+ (NSString *)primaryKeyAndDESC {
    return [[self getPrimaryKey] stringByAppendingString:@" DESC"];
}

@end