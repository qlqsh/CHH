//
//  PLSubforum.h
//  CHH
//
//  Created by 刘明 on 14-9-1.
//  Copyright (c) 2014年 刘明. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
*  子板块对象。包括：标题、帖子列表、下一页地址
*/
@interface PLSubforum : NSObject

@property(nonatomic, copy) NSString *title;        // 这个应该通过 segue 进行传递进来
@property(nonatomic, strong) NSArray *postsList;   // 通过网页解析出来
@property(nonatomic, copy) NSString *href;          // 获取更多帖子数据，加入到本地帖子列表里

// 利用提供的url地址，获取网页内容，进行解析。通过 segue 传递。
- (id)initWithURL:(NSString *)urlString;

@end
