//
//  RLReply.m
//  CHH
//
//  Created by 刘明 on 14-10-8.
//  Copyright (c) 2014年 刘明. All rights reserved.
//

#import "RLReply.h"
#import "TFHpple.h"

@implementation RLReply

/**
*  提供一个 html 的内容片段。通过初始化方法提取需要的数据。
*
*  @param content html 片段。
*
*  @return 回复对象。
*/
- (id)initWithContent:(NSString *)htmlContent {
	NSData *htmlData = [htmlContent dataUsingEncoding:NSUTF8StringEncoding];
	TFHpple *doc = [[TFHpple alloc] initWithHTMLData:htmlData];

	NSArray *elements;
	NSString *author;
	NSString *replyDate;
	NSString *content;
	NSString *imgHref;

	// <div id="postlist" class="pl bm">...</div>是主体片段，不是在这里使用的。
	// 这里通过解析html片段提取有用数据。这里的片段应该是<div id="post_dddddddd">...</div>
	// 这里麻烦的地方有几点：
	//      1、主题内容：复杂、内容众多（文字、视频、img、链接）、还有多余标签处理问题（比如：<br>、<br/>、<br />、<br></br>转"\n"）。
	//      2、回帖内容：稍微简单，但可能会有针对回复问题需要处理。

	// 作者
	elements = [doc searchWithXPathQuery:@"//div[@class=\"authi\"]//a"];
	if ([elements count] >= 1) {
		author = [elements[0] text];
	}

	// 作者头像
	// TODO：还有需要处理的地方，是没有的时候系统提供默认头像，这个可以做到本地。
//	elements = [doc searchWithXPathQuery:@"//tr//td[@class='pls']//div//div//div[@class='avatar']//img"];
//	if ([elements count] == 1) {
//        
//	}

	// 发表时间
	elements = [doc searchWithXPathQuery:@"//div[@class=\"authi\"]//em"];
	if ([elements count] >= 1) {
		replyDate = [elements[0] text];
	}
    NSLog(@"发表时间：%@", replyDate);

	// 楼层

	// 内容
	elements = [doc searchWithXPathQuery:@"//td[@class=\"t_f\"]"];
	if ([elements count] >= 1) {
		content = [elements[0] text];
	}

	if (self = [super init]) {
        _author    = author;
        _replyDate = replyDate;
        _content   = content;
        _imgHref   = imgHref;
	}

	return self;
}

#pragma mark - 方法覆写

/**
*  内容描述。
*
*  @return RLReply 对象内容描述。
*/
- (NSString *)description {
	NSMutableString *description = [NSMutableString stringWithFormat:@"\n{\n\t作者：%@ \n\t发表时间：%@ \n\t头像链接：%@ \n\t内容：%@ \n}", _author, _replyDate, _imgHref, _content];

	return [description copy];
}

/**
 *  两个RLReply相等比较。
 *
 *  @param object 要比较的对象。
 *
 *  @return 是否相等。
 */
- (BOOL)isEqual:(id)object {

	return NO;
}


@end
