//
//  PLPosts.h
//  CHH
//
//  Created by 刘明 on 14-9-1.
//  Copyright (c) 2014年 刘明. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
*  一个帖子对象，用于帖子列表，包含属性：题目、地址、回复数量、作者、发帖时间
*/
@interface PLPosts : NSObject

@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *href;
@property(nonatomic, copy) NSString *replySum;     // 非必要属性
@property(nonatomic, copy) NSString *author;
@property(nonatomic, copy) NSString *releaseDate;

// 使用网页片断提取数据，建立帖子对象。
- (id)initWithContent:(NSString *)content;

@end
