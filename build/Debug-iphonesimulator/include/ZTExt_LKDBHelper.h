/*
 ============================================================================
 Name           : ZTExt_LKDBHelper.h
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTExt_LKDBHelper declaration
 ============================================================================
 */

#import <Foundation/Foundation.h>

#pragma mark - ZTExt_LKDBHelper

@interface ZTExt_LKDBHelper : NSObject

@end

#pragma mark - NSArray+ZTExt_LKDBHelper
@interface NSArray (ZTExt_LKDBHelper)

/**
 *  保存所有数据到sqlite db中
 */
- (void)saveAllToDB;

/**
 *  加载数据DB到ModelClass中
 *
 *  @param modelClass 模型类
 *
 *  @return id
 */
+ (id)loadFromDBWithClass:(Class)modelClass;

@end

#pragma mark - NSObject+ZTExt_LKDBHelper
@interface NSObject (ZTExt_LKDBHelper)

/**
 *  加载到DB中
 */
- (void)loadFromDB;

/**
 *  关键字Key Desc
 *
 *  @return 名称
 */
+ (NSString *)primaryKeyAndDESC;

@end
