//
//  HTMLHandler.m
//  ltaaa
//
//  Created by 刘 明 on 13-11-19.
//  Copyright (c) 2013年 刘 明. All rights reserved.
//

#import "HTMLHandler.h"

#pragma mark - 

@interface HTMLHandler ()

@end

@implementation HTMLHandler

#pragma mark - html内容处理
/**
 * 多余标签处理
 */
+ (NSString *)unnecessaryTagHandler:(NSString *)htmlContent
{
    if (!htmlContent)
    {
        return nil;
    }
    
    NSUInteger length = [htmlContent length];
    BOOL isText = TRUE;
    NSString *text;
    unichar charArray[length];
    
	NSUInteger j = 0;
    for (size_t i = 0; i < length; ++i)
    {
        unichar anChar = [htmlContent characterAtIndex:i];
		
		if (anChar == '<')
		{
			isText = FALSE;
		}
		
		if (isText == TRUE)
        {
            charArray[j] = anChar;
            j++;
        }

        if (anChar == '>')
        {
            isText = TRUE;
        }
    }
	
	text = [[NSString alloc] initWithCharacters:charArray length:j];
    
    return text;
}

/**
 * 特殊字符处理
 *
 * 空格  &nbsp;
 * <    &lt;
 * >    &gt;
 * &    &amp;
 * ¢    &cent;
 * £    &pound;
 * ¥    &yen;
 * €    &euro;
 * §    &sect;
 * ©    &copy;
 * ®    &reg;
 * ™    &trade;
 * 空	\t
 * 空	\n
 */
+ (NSString *)specialCharHandler:(NSString *)htmlContent
{
    if (!htmlContent)
    {
        return nil;
    }
    
    NSDictionary *charDict = @{
        @"&nbsp;"   : @" ",
        @"&lt;"     : @"<",
        @"&gt;"     : @">",
        @"&amp;"    : @"&",
        @"&cent;"   : @"¢",
        @"&pound;"  : @"£",
        @"&yen;"    : @"¥",
        @"&euro;"   : @"€",
        @"&sect;"   : @"§",
        @"&copy;"   : @"©",
        @"&reg;"    : @"®",
        @"&trade;"  : @"™",
		@"&#13;"	: @""		// Hpple查询后出现，我猜是回车（不可见）。
    };
    
    __block NSString *handlerContent = htmlContent;
    [charDict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSString *anKey = (NSString *)key;
        NSString *object = (NSString *)obj;
        
        handlerContent = [handlerContent stringByReplacingOccurrencesOfString:anKey withString:object];
    }];
    
    return handlerContent;
}

#pragma mark - URL处理
/**
 * 判断是否是有效URL
 */
+ (BOOL)isValidURL:(NSString *)urlString
{
	if (!urlString || [@"" isEqualToString:urlString])
	{
		return false;
	}
	
    NSString *urlRegexPart1 = @"^((https|http|ftp|rtsp|mms)?://)";  // 头
    NSString *urlRegexPart2 = @"?(([0-9a-z_!~*'().&=+$%-]+: )?[0-9a-z_!~*'().&=+$%-]+@)?";  //ftp的user@
    NSString *urlRegexPart3 = @"(([0-9]{1,3}\\.){3}[0-9]{1,3}"; // IP形式的URL- 199.194.52.184
    NSString *urlRegexPart4 = @"|"; // 允许IP和DOMAIN（域名）
    NSString *urlRegexPart5 = @"([0-9a-z_!~*'()-]+\\.)*"; // 域名- www.
    NSString *urlRegexPart6 = @"([0-9a-z][0-9a-z-]{0,61})?[0-9a-z]\\."; // 二级域名
    NSString *urlRegexPart7 = @"[a-z]{2,6})"; // first level domain- .com or .museum
    NSString *urlRegexPart8 = @"(:[0-9]{1,4})?"; // 端口- :80
    NSString *urlRegexPart9 = @"((/?)|"; // a slash isn't required if there is no file name
    NSString *urlRegexPart10 = @"(/[0-9a-z_!~*'().;?:@&=+$,%#-]+)+/?)$";
    
    NSString *urlRegex = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@", 
        urlRegexPart1, urlRegexPart2, urlRegexPart3, urlRegexPart4, urlRegexPart5, 
        urlRegexPart6, urlRegexPart7, urlRegexPart8, urlRegexPart9, urlRegexPart10];
	NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:urlRegex
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    NSAssert(regex, @"无法建立正则表达式");
    if (!error)
    {
        // 没有错误的情况下
        NSUInteger numberOfMatches = [regex numberOfMatchesInString:urlString
                                                            options:0
                                                              range:NSMakeRange(0, [urlString length])];
        if (numberOfMatches > 0)
        {
            return true;
        }        
    }
	
	return false;
}

/**
 * URL转换，把相对地址，转换为绝对地址
 */
+ (NSString *)urlConvertWithNeedChangeURL:(NSString *)needChangeURL andCurrentURL:(NSString *)currentURL
{
    // 首先判断，2个参量不能为nil或空字符串
    if (!needChangeURL || [@"" isEqualToString:needChangeURL])
    {
        return nil;
    }
    if (!currentURL || [@"" isEqualToString:currentURL])
    {
        return nil;
    }
    
    // 判断需要转换的URL是否是相对URL，如果不是，则不用转换。
    if ([needChangeURL hasPrefix:[@"http" lowercaseString]]) // 判断是否有"http"前缀（忽略大小写）
    {
        return needChangeURL;
    }
    
    // currentURL几种情况：
    // 1、http://www.ltaaa.com
    // 2、http://www.ltaaa.com/
    // 3、http://www.ltaaa.com/bbs
    // 4、http://www.ltaaa.com/bbs/
    // 5、http://www.ltaaa.com/bbs/xxxx.htm
    // 6、http://www.ltaaa.com/bbs/xxxx.html
	// 7、http://www.ltaaa.com/bbs/forum.php
	NSString *urlString;
    NSURL *url = [NSURL URLWithString:currentURL];
    NSString *lastPathComponent = [url lastPathComponent];
    if (([lastPathComponent rangeOfString:@".htm"].location != NSNotFound) ||
		([lastPathComponent rangeOfString:@".php"].location != NSNotFound))   // 情况5、6、7
    {
        NSRange lastRange = [currentURL rangeOfString:lastPathComponent];
        NSString *head = [currentURL substringToIndex:currentURL.length-lastRange.length];
        urlString = [NSString stringWithFormat:@"%@%@", head, needChangeURL];
    } else
    {
        unichar anChar = [currentURL characterAtIndex:currentURL.length-1];
        if (anChar == '/') // 情况2、4
        {
            urlString = [NSString stringWithFormat:@"%@%@", currentURL, needChangeURL];
        } else  // 情况1、3
        {
            urlString = [NSString stringWithFormat:@"%@%@%@", currentURL, @"/", needChangeURL];
        }
    }
	
	return [[[NSURL URLWithString:urlString] standardizedURL] absoluteString];
}

#pragma mark - 细节处理
/**
 * 多余标签、特殊字符
 */
+ (NSString *)htmlHandler:(NSString *)htmlContent
{
    if (!htmlContent)
    {
        return nil;
    }
	NSString *trimString = [HTMLHandler specialCharHandler:htmlContent];
	trimString = [HTMLHandler unnecessaryTagHandler:trimString];
	trimString = [trimString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	
    return trimString;
}

@end
