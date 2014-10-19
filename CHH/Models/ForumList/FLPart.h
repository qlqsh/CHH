//
//  FLPart.h
//  CHH
//
//  Created by 刘明 on 14-8-14.
//  Copyright (c) 2014年 刘明. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
*  分区对象。
*
*  包含：分区名称、子板块列表。
*/
@interface FLPart : NSObject

@property(nonatomic, copy) NSString *name;
@property(nonatomic, strong) NSArray *subforumList;

// 使用网页片断提取数据，建立分区对象。
- (id)initWithContent:(NSString *)content;

@end
