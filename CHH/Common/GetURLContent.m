//
//  LTGetURLContent.m
//  ltaaa
//
//  Created by 刘 明 on 13-11-18.
//  Copyright (c) 2013年 刘 明. All rights reserved.
//

#import "GetURLContent.h"
#import "HTMLHandler.h"

#pragma mark - 

@implementation GetURLContent

#pragma mark - 通过指定URL获取内容
/**
 * 通过指定URL获取网页内容
 * 
 * 需要编码转换，Hpple只认utf8格式的网页
 */
+ (NSData *)contentWithURL:(NSString *)urlString
{
	// 判断url的有效性
	if (![HTMLHandler isValidURL:urlString])
	{
		return nil;
	}
	
	NSURL *url = [NSURL URLWithString:urlString];
	
    // 1、编码转换，// TODO: 由于chh用的就是utf8编码，所以没有编码转换的必要。编码转换应该做到一个方法里去。
    //	NSStringEncoding encode = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
	NSError *error = NULL;
	NSString *content = [NSString stringWithContentsOfURL:url
												 encoding:NSUTF8StringEncoding
													error:&error];

	if (error)
	{
		return nil;
	}

    // 通过GetURLContent统一网络管理
    // 1、网络无法访问；
    // 2、内容无法访问（404、空白页面、没有权限）；
	
	// 2、内容替换，gbk -> utf8
    //	NSString *gbkFormatString = @"<meta http-equiv=\"Content-Type\" content=\"text/html; charset=gbk\" />";
    //	NSString *utf8FormatString = @"<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf8\" />";
    //	NSString *utf8HtmlString = [content stringByReplacingOccurrencesOfString:gbkFormatString
    //																  withString:utf8FormatString];
	NSString *trimString = [HTMLHandler specialCharHandler:content];
	NSData *htmlData = [trimString dataUsingEncoding:NSUTF8StringEncoding];
	
	return htmlData;
}

@end
