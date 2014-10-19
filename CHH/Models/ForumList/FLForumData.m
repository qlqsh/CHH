//
//  FLForumData.m
//  CHH
//
//  Created by 刘明 on 14-8-14.
//  Copyright (c) 2014年 刘明. All rights reserved.
//

#import "FLForumData.h"

#import "GetURLContent.h"

#import "TFHpple.h"

#import "FLPart.h"
#import "TFHppleElement.h"

#ifndef SubforumURL
#define SubforumURL @"http://www.chiphell.com/forum.php"    // 板块列表网址
#endif

@interface FLForumData ()
- (id)init;
@end

@implementation FLForumData
/**
 *  初始化，提取网页数据，进行解析。
 *
 *  @return 解析完成后的 FLForumData 对象。
 */
- (id)init {
    // 获取数据，转换到解析需要的TFHpple模式。
    NSData *htmlData = [GetURLContent contentWithURL:SubforumURL];
    TFHpple *doc = [[TFHpple alloc] initWithHTMLData:htmlData];

    NSArray *elements = [doc searchWithXPathQuery:@"//div[@class='bm bmw  flg cl']"];
    NSMutableArray *parts = [[NSMutableArray alloc] init];
    if ([elements count] < 1) {
        // 获取本地数据
    } else {
        for (TFHppleElement *element in elements) {
            FLPart *part = [[FLPart alloc] initWithContent:[element raw]];
            if (part != nil) {
                [parts addObject:part];
            }
        }
    }

    if (self = [super init]) {
        _partList = [parts copy];
    }

    return self;
}

#pragma mark - 方法覆写
/**
 *  内容描述。
 *
 *  @return 板块列表的对象内容描述
 */
- (NSString *)description {
    NSMutableString *description = [[NSMutableString alloc] init];

    for (FLPart *part in _partList) {
        [description appendFormat:@"%@", part];
    }

    return [description copy];
}

/**
*  判断2个 FLForumData 是否相等。
*
*  @param object 一个 FLForumData 对象
*
*  @return 是：相等；否：不想等。
*/
- (BOOL)isEqual:(id)object {
    FLForumData *forumData = (FLForumData *) object;

    if ([_partList count] == [forumData.partList count]) {
        for (NSUInteger i = 0; i < [_partList count]; i++) {
            if (![_partList[i] isEqual:(forumData.partList)[i]]) {
                return NO;
            }
        }
        return YES;
    }

    return NO;
}

#pragma mark - NSCoding

/**
*  对属性进行编码。
*/
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_partList forKey:@"parts"];
}

/**
*  解码，建立对象。
*/
- (id)initWithCoder:(NSCoder *)aDecoder {
    NSArray *partList = [aDecoder decodeObjectForKey:@"parts"];

    if (self = [super init]) {
        _partList = partList;
    }

    return self;
}

@end
