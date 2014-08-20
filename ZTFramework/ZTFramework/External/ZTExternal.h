/*
 ============================================================================
 Name           : ZTExternal.h
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTExternal declaration
 ============================================================================
 */

#ifndef ZTFramework_ZTExternal_h
#define ZTFramework_ZTExternal_h

#import "ZTExternalPrecompile.h"

//FMDB-sqlite 数据库
#if (1 == ZT_EXTERNAL_FMDB)
#import "FMDatabase.h"
#endif

// sqlite 数据库全自动操作
#if (1 == ZT_EXTERNAL_LKDBHELPER)
#import "LKDBHelper.h"
#endif

//第三方扩展
#import "ZTExternalExtension.h"

#endif
