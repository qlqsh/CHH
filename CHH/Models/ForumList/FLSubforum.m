//
//  FLSubforum.m
//  CHH
//
//  Created by 刘明 on 14-7-7.
//  Copyright (c) 2014年 刘明. All rights reserved.
//

#import "FLSubforum.h"
#import "TFHpple.h"

@interface FLSubforum ()

@end

@implementation FLSubforum

/**
*  初始化一个子板块对象。
*
*  @param content 需要提取的网页片断。格式<div class="bm_c xxx">...</div>
*
*  @return 子板块对象
*/
- (id)initWithContent:(NSString *)content {
	NSData *htmlData = [content dataUsingEncoding:NSUTF8StringEncoding];
	TFHpple *doc = [[TFHpple alloc] initWithHTMLData:htmlData];

	NSString *subforumName;
	NSString *subforumNumber;
	NSString *subforumHref;

	// 获取子板块名称、url地址
	NSArray *elements = [doc searchWithXPathQuery:@"//div//a"];
	if ([elements count] != 1) {
		return nil;
	} else {
		subforumName = [elements[0] text];
		subforumHref = [elements[0] objectForKey:@"href"];
	}

	// 获取子板块今日回帖数量，有可能不存在。
	elements = [doc searchWithXPathQuery:@"//div//font"];
	if ([elements count] != 1) {
		subforumNumber = @"";
	} else {
		subforumNumber = [elements[0] text];
	}

	if (subforumName == nil || [subforumName isEqualToString:@""]) {
		return nil;
	}
	if (subforumHref == nil || [subforumHref isEqualToString:@""]) {
		return nil;
	}
	if (subforumNumber == nil) {
		subforumNumber = @"";
	}

	if (self = [super init]) {
        _name   = subforumName;
        _number = subforumNumber;
        _href   = subforumHref;
	}

	return self;
}

#pragma mark - 方法覆写

/**
*  判断2个子板块对象是否相等。只要name、url一致，就判断为相等。
*
*  @param id 要比较的对象，需要类型转换
*
*  @return YES：相等。NO：不相等。
*/
- (BOOL)isEqual:(id)object {
	FLSubforum *subforum = (FLSubforum *) object;
	// 2个子板块对象name、url相等，则说明2个对象相等。
	return [_name isEqual:subforum.name] && [_href isEqual:subforum.href];
}

/**
*  内容描述。
*
*  @return FLSubforum 对象内容的描述。
*/
- (NSString *)description {
	NSString *description = [NSString stringWithFormat:@"\n{\n\t名称：%@ \n\t数量：%@ \n\t链接：%@ \n}",
													   _name, _number, _href];

	return [description copy];
}

@end
