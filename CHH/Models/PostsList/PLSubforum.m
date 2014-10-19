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

- (id)initWithURL:(NSString *)urlString {
    

    //TODO: 由于不登录就没有访问权限，所以必须登录后才能获取数据。可以先用本地html进行测试，以后加入cookie后再联网测试。还有需要登录后才能获取数据的页面，在app端需要跳到登录视图。
    // 网页解析
    NSData *htmlData = [GetURLContent contentWithURL:urlString];
    
    return [self initWithContent:htmlData];
}
/**
 *  网页内容解析
 *
 *  @param data 网页内容数据
 *
 *  @return 解析后的对象
 */
- (id)initWithContent:(NSData *)data {
    NSMutableArray *posts = [NSMutableArray new];
    NSString *title;
    NSString *href;
    
    TFHpple *doc = [[TFHpple alloc] initWithHTMLData:data];
    
    // 提取获取更多帖子的url
    NSArray *elements = [doc searchWithXPathQuery:@"//a[@class='nxt']"];
    if (0 < [elements count]) {
        href = [[elements objectAtIndex:0] objectForKey:@"href"];
    }
    
    // 提取需要解析的网页的主体
    elements = [doc searchWithXPathQuery:@"//div[@class='bm_c']"];
    if (1 > [elements count])
    {
        return nil;
    }
    NSString *content = [[elements objectAtIndex:0] raw];

    // 提取帖子列表
    NSData *htmlData = [content dataUsingEncoding:NSUTF8StringEncoding];
    doc = [[TFHpple alloc] initWithHTMLData:htmlData];

    elements = [doc searchWithXPathQuery:@"//tbody"];
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
        _title     = title;
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
