//
//  PLPosts.m
//  CHH
//
//  Created by 刘明 on 14-9-1.
//  Copyright (c) 2014年 刘明. All rights reserved.
//

#import "PLPosts.h"
#import "TFHpple.h"
#import "HTMLHandler.h"

@implementation PLPosts

/**
*  使用网页的内容片段，提取必要数据，初始化一个帖子对象。
*
*  @param content 需要解析的网页片段。格式：<div class="bm_c">...</div>，div 里面的内容就是需要解析的内容。
*
*  @return 初始化后的帖子对象。
*/
- (id)initWithContent:(NSString *)content {
    NSData *htmlData = [content dataUsingEncoding:NSUTF8StringEncoding];
    TFHpple *doc = [[TFHpple alloc] initWithHTMLData:htmlData];
    
    /*
        TODO：由于 Hpple 本身的局限性，当标签与内容交杂在一起的时候，text 方法返回空内容。这里只能进行后期加工，不是正确的方法。
        以后OCGumbo可能是一个选择，要不就自己开发html解析器。
     */
    // 解析标题、帖子地址
    NSString *title;
	NSString *href;
    NSArray *elements = [doc searchWithXPathQuery:@"//div//a"];
    if ([elements count] >= 1) {
        title = [HTMLHandler htmlHandler:[elements[0] raw]];
		href = [elements[0] objectForKey:@"href"];
    }

	// 解析作者
	NSString *author;
	elements = [doc searchWithXPathQuery:@"//div//span//a"];
	if ([elements count] >= 1) {
		author = [elements[0] text];
	}

	// 解析时间＋回帖数量
	NSString *combinationContent;
	elements = [doc searchWithXPathQuery:@"//div//span"];
	// 有特殊情况，可以是空。
	if ([elements count] >= 1) {
        NSString *content = [elements[0] raw];
        NSString *re = @"20(.*)</span>";
        NSRange range = [content rangeOfString:re options:NSRegularExpressionSearch];
        if (range.location != NSNotFound) {
            combinationContent = [HTMLHandler htmlHandler:[content substringWithRange:range]];
        }
	}

	// 解析回帖数量
	NSString *replySum;
	NSString *releaseDate;
	NSArray *combinationArray = [combinationContent componentsSeparatedByString:@" "];
	if ([combinationArray count] < 1) {
		replySum = @"";
		releaseDate = @"";
	} else if ([combinationArray count] == 1) {
		releaseDate = combinationArray[0];
	} else if ([combinationArray count] == 2) {
		releaseDate = [NSString stringWithFormat:@"%@ %@", combinationArray[0], combinationArray[1]];
	} else {
		releaseDate = [NSString stringWithFormat:@"%@ %@", combinationArray[0], combinationArray[1]];
		replySum = combinationArray[[combinationArray count]-1];
	}

    if (nil == title || [@"" isEqualToString:title]) {
        return nil;
    }

    if (nil == href || [@"" isEqualToString:href]) {
        return nil;
    }
    
    if (nil == author || [@"" isEqualToString:author]) {
        return nil;
    }

    if (self = [super init]) {
        _title       = [title stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        _href        = href;
        _replySum    = replySum;
        _author      = author;
        _releaseDate = releaseDate;
    }

    return self;
}

#pragma mark - 方法覆写

/**
*  判断2个帖子对象是否相同。标题、地址、回复数量相同，对象就是相同的。作者、发表时间是固定的，不做比较。
*
*  @param object 需要比较的对象，需要类型转换。
*
*  @return YES：相同。NO：不相同。
*/
- (BOOL)isEqual:(id)object {
    PLPosts *posts = (PLPosts *) object;
    return [_title isEqualToString:posts.title] && [_href isEqualToString:posts.href] && [_replySum isEqualToString:posts.replySum];

}

/**
*  帖子对象的描述。
*
*  @return 描述字符串。
*/
- (NSString *)description {
    NSString *description = [NSString stringWithFormat:@"\n{\n\t标题：%@ \n\t地址：%@ \n\t回复数量：%@ \n\t作者：%@ \n\t发表时间：%@ \n}",
                             _title, _href, _replySum, _author, _releaseDate];

    return [description copy];
}

#pragma mark - NSCoding

/**
*  对属性进行编码。
*/
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_title forKey:@"title"];
    [aCoder encodeObject:_href forKey:@"href"];
    [aCoder encodeObject:_replySum forKey:@"replySum"];
    [aCoder encodeObject:_author forKey:@"author"];
    [aCoder encodeObject:_releaseDate forKey:@"releaseDate"];
}

/**
*  解码，建立对象。
*/
- (id)initWithCoder:(NSCoder *)aDecoder {
    NSString *title = [aDecoder decodeObjectForKey:@"title"];
    NSString *href = [aDecoder decodeObjectForKey:@"href"];
    NSString *replySum = [aDecoder decodeObjectForKey:@"replySum"];
    NSString *author = [aDecoder decodeObjectForKey:@"author"];
    NSString *releaseDate = [aDecoder decodeObjectForKey:@"releaseDate"];

    if (self = [super init]) {
        _title = title;
        _href = href;
        _replySum = replySum;
        _author = author;
        _releaseDate = releaseDate;
    }

    return self;
}

@end
