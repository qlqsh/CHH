//
//  FLPart.m
//  CHH
//
//  Created by 刘明 on 14-8-14.
//  Copyright (c) 2014年 刘明. All rights reserved.
//

#import "FLPart.h"
#import "FLSubforum.h"
#import "TFHpple.h"

@implementation FLPart

/**
*  用网页内容片断初始化分区对象。
*
*  @param content 需要提取的网页片断。样式：<div class="bm">...</div>
*/
- (id)initWithContent:(NSString *)content {
    NSData *htmlData = [content dataUsingEncoding:NSUTF8StringEncoding];
    TFHpple *doc = [[TFHpple alloc] initWithHTMLData:htmlData];

    // 获得分区名称
    NSString *partName;
    NSArray *elements = [doc searchWithXPathQuery:@"//div[@class='bm_h']"];
    // >1 或 <1 都是错误情况
    if ([elements count] != 1) {
        return nil;
    } else {
        partName = [elements[0] text];
    }

    // 获得分区下子板块
    NSMutableArray *subforums = [[NSMutableArray alloc] init];
    NSArray *subForumElements = [doc searchWithXPathQuery:@"//div"];

    for (TFHppleElement *element in subForumElements) {
        FLSubforum *subforum = [[FLSubforum alloc] initWithContent:[element raw]];
        if (subforum != nil) {
            [subforums addObject:subforum];
        }
    }

    if (partName == nil || [partName isEqualToString:@""]) {
        return nil;
    }
    if ([subforums count] < 1) {
        return nil;
    }

    if (self = [super init]) {
        _name = [partName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];;
        _subforumList = [subforums copy];
    }

    return self;
}

#pragma mark - 方法覆写

/**
*  内容描述。
*
*  @return FLPart 对象内容描述。
*/
- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithFormat:@"\n分区：%@ \n子板块列表：", _name];

    for (FLSubforum *subforum in _subforumList) {
        [description appendFormat:@"%@", [subforum description]];
    }

    return [description copy];
}

/**
*  判断2个 FLPart 对象是否相同。
*
*  @param object 一个对象，需要判断是否是 FLPart 对象。然后进行类型转换。
*
*  @return YES：相等。NO：不相等。
*/
- (BOOL)isEqual:(id)object {
    FLPart *part = (FLPart *) object;

    if ([_name isEqual:part.name] && [_subforumList count] == [part.subforumList count]) {
        for (NSUInteger i = 0; i < [_subforumList count]; i++) {
            if (![_subforumList[i] isEqual:(part.subforumList)[i]]) {
                return NO;
            }
        }
        return YES;
    }

    return NO;
}

@end
