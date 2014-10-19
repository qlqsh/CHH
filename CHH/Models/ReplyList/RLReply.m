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


    NSString *author;
    NSString *replyDate;
    NSString *content;
    NSString *href;

    // <div id="postlist" class="pl bm">...</div>是主体片段，不是在这里使用的。
    // 这里通过解析html片段提取有用数据。这里的片段应该是<tr>...</tr>
    // 这里麻烦的地方有几点：
    //      1、主题内容：复杂、内容众多（文字、视频、img、链接）、还有多余标签处理问题（比如：<br>、<br/>、<br />、<br></br>转"\n"）。
    //      2、回帖内容：稍微简单，但可能会有针对回复问题需要处理。

    // 作者 //tr//td[@class="pls"]//div//div//div[@class="authi"]//a

    // 作者头像 //tr//td[@class="pls"]//div//div//div[@class="avatar"]//img
    // TODO：还有需要处理的地方，是没有的时候系统提供默认头像，这个可以做到本地。

    // 发表时间 //tr//td[@class="plc"]//div//div//div[@class="authi"]//em

    // 楼层 //tr//td[@class="plc"]//div[@class="pi"]//strong//a//em

    // 内容 //tr//td[@class="plc"]//div[@class="pct"]//div//div//table//tbody//tr//td

    if (self = [super init]) {
        _author = author;
        _replyDate = replyDate;
        _content = content;
        _href = href;
    }

    return self;
}


@end
