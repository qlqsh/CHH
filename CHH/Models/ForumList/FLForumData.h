//
//  FLForumData.h
//  CHH
//
//  Created by 刘明 on 14-8-14.
//  Copyright (c) 2014年 刘明. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
*  板块列表数据。处理从特定网页（http://www.chiphell.com/forum.php）获取的所有板块信息，然后转换为特定类对象。是整个板块列表的起始类。
*/
@interface FLForumData : NSObject

@property(nonatomic, strong) NSArray *partList;  // 分区对象的数组

@end
