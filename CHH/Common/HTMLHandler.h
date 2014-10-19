//
//  HTMLHandler.h
//  ltaaa
//
//  Created by 刘 明 on 13-11-19.
//  Copyright (c) 2013年 刘 明. All rights reserved.
//
//	HTML处理：
//			1、去掉修饰性标签，比如<strong>；
//			2、替换保留字符

#import <Foundation/Foundation.h>

@interface HTMLHandler : NSObject

+ (NSString *)unnecessaryTagHandler:(NSString *)htmlContent;    // 多余标签处理
+ (NSString *)specialCharHandler:(NSString *)htmlContent;       // 特殊字符处理
+ (NSString *)htmlHandler:(NSString *)htmlContent;

+ (BOOL)isValidURL:(NSString *)urlString;   // 判断URL有效性
+ (NSString *)urlConvertWithNeedChangeURL:(NSString *)needChangeURL andCurrentURL:(NSString *)currentURL;   // url转换

@end
