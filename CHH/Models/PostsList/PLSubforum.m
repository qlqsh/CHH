//
//  PLSubforum.m
//  CHH
//
//  Created by 刘明 on 14-9-1.
//  Copyright (c) 2014年 刘明. All rights reserved.
//

#import "PLSubforum.h"

#import "TFHpple.h"

#import "GetURLContent.h"

#import "PLPosts.h"

@implementation PLSubforum
/**
 *  指定网页解析。
 *
 *  @param data 网页地址
 *
 *  @return 解析后的对象
 */
- (id)initWithURL:(NSString *)urlString {
    NSData *htmlData = [GetURLContent contentWithURL:urlString];
    TFHpple *doc = [[TFHpple alloc] initWithHTMLData:htmlData];
    
    NSMutableArray *posts = [NSMutableArray new];
    NSString *href;
    
    // 提取需要解析的网页的主体
    NSArray *elements = [doc searchWithXPathQuery:@"//div[@class='bm']"];
    if (1 > [elements count])
    {
        return nil;
    }
    NSString *content = [[elements objectAtIndex:0] raw];

    // 提取帖子列表
    htmlData = [content dataUsingEncoding:NSUTF8StringEncoding];
    doc = [[TFHpple alloc] initWithHTMLData:htmlData];

    elements = [doc searchWithXPathQuery:@"//div//div"];
    if (1 > [elements count])
    {
        return nil;
    }
    
    for (TFHppleElement *element in elements)
    {
        PLPosts *post = [[PLPosts alloc] initWithContent:[element raw]];
        if (post)
        {
            [posts addObject:post];
        }
    }

    if (1 > [posts count])
    {
        return nil;
    }
    
    if (self = [super init]) {
        _postsList = posts;
        _href      = href;
    }
    
    return self;
}

#pragma mark - 方法覆写
- (BOOL)isEqual:(id)object {
    PLSubforum *subforum = (PLSubforum *) object;

    if ([_postsList count] == [subforum.postsList count]) {
        for (NSUInteger i = 0; i < [_postsList count]; i++) {
            if (![_postsList[i] isEqual:(subforum.postsList)[i]]) {
                return NO;
            }
        }
        return YES;
    }

    return NO;
}

- (NSString *)description {
    NSString *description = [NSString stringWithFormat:@"\n{\n\t标题：%@ \n\t帖子列表：%@ \n\t下一页链接：%@ \n}", _title, _postsList, _href];

    return [description copy];
}

#pragma mark - NSCoding
/**
*  对属性进行编码。
*/
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_title forKey:@"title"];
    [aCoder encodeObject:_postsList forKey:@"postsList"];
    [aCoder encodeObject:_href forKey:@"href"];
}

/**
*  解码，建立对象。
*/
- (id)initWithCoder:(NSCoder *)aDecoder {
    NSString *title = [aDecoder decodeObjectForKey:@"title"];
    NSArray *postsList = [aDecoder decodeObjectForKey:@"postsList"];
    NSString *href = [aDecoder decodeObjectForKey:@"href"];

    if (self = [super init]) {
        _title = title;
        _postsList = postsList;
        _href = href;
    }

    return self;
}

@end
