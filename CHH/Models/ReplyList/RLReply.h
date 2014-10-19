//
//  RLReply.h
//  CHH
//
//  Created by 刘明 on 14-10-8.
//  Copyright (c) 2014年 刘明. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  一个回复对象。用于回复列表，包括属性：作者、回复时间、回复内容（还可能包含回复的对象内容）。
 */
@interface RLReply : NSObject

@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *replyDate;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *href;

// 使用内容片段，提取必要数据，初始化一个回复对象。
- (id)initWithContent:(NSString *)htmlContent;


@end
