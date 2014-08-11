/*
 ============================================================================
 Name           : ZTTableSectionModel.h
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTTableSectionModel declaration
 ============================================================================
 */

#import "ZTKit.h"

/**
 *ZTTableSectionModel:表格分组数据模型
 *Author:Fighting
 **/
@interface ZTTableSectionModel : NSObject

/** section标题 */
@property (readonly, nonatomic, strong) NSString *title;

/** sectionKey */
@property (readonly, nonatomic, strong) NSString *key;

/**
 *  配置
 *
 *  @param title 标题
 *  @param key   键
 *
 *  @return instancetype
 */
- (instancetype)initConfigWith:(NSString *)title key:(NSString *)key;

@end
