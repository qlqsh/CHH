//
//  PLPosts.m
//  CHH
//
//  Created by 刘明 on 14-9-1.
//  Copyright (c) 2014年 刘明. All rights reserved.
//

#import "PLPosts.h"
#import "TFHpple.h"

@implementation PLPosts

/**
*  使用网页的内容片段，提取必要数据，初始化一个帖子对象。
*
*  @param content 需要解析的网页片段。格式：<tbody>...</tbody>，tbody 里面的内容就是需要解析的内容。
*
*  @return 初始化后的帖子对象。
*/
- (id)initWithContent:(NSString *)content {
    NSData *htmlData = [content dataUsingEncoding:NSUTF8StringEncoding];
    TFHpple *doc = [[TFHpple alloc] initWithHTMLData:htmlData];

    // 解析题目 //tr//th//a[@class='s xst']
    NSString *title;
    NSArray *elements = [doc searchWithXPathQuery:@"//tr//th//a[@class='s xst']"];
    // > 1 或 < 1 都是错误情况
    if ([elements count] != 1) {
        return nil;
    } else {
        title = [elements[0] text];
    }

    // 解析帖子地址
    NSString *href = [elements[0] objectForKey:@"href"];

    // 解析回帖数量 //tr//td[@class='num']//a
    NSString *replaySum = @"";
    elements = [doc searchWithXPathQuery:@"//tr//td[@class='num']//a"];
    // 有特殊情况，可以是空。
    if ([elements count] >= 1) {
        replaySum = [elements[0] text];
    }

    // 有2个：一个是帖子作者，一个是最后回帖的作者，只取第一个。
    // 解析作者 //tr//td[@class='by']//cite//a
    NSString *author = @"";
    elements = [doc searchWithXPathQuery:@"//tr//td[@class='by']//cite//a"];
    if ([elements count] >= 1) {
        author = [elements[0] text];
    }

    // 解析发表时间 //tr//td[@class='by']//em//span
    NSString *releaseDate = @"";
    elements = [doc searchWithXPathQuery:@"//tr//td[@class='by']//em//span"];
    if ([elements count] >= 1) {
        releaseDate = [elements[0] text];
    }

    if (nil == title || [@"" isEqualToString:title]) {
        return nil;
    }

    if (nil == href || [@"" isEqualToString:href]) {
        return nil;
    }

    if (self = [super init]) {
        _title       = title;
        _href        = href;
        _replySum    = replaySum;
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
    NSString *description = [NSString stringWithFormat:@"\n{\n\t标题：%@ \n\t地址：%@ \n\t回复数量：%@ \n\t作者：%@ \n\t发表时间：%@ \n}", _title, _href, _replySum, _author, _releaseDate];

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
