//
//  FLSubforum.h
//  CHH
//
//  Created by 刘明 on 14-7-7.
//  Copyright (c) 2014年 刘明. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
*  子板块对象，包括：名称、新帖子数量、url地址，3个属性。
*/
@interface FLSubforum : NSObject

@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *number;
@property(nonatomic, copy) NSString *href;

// 使用网页片断提取数据，建立子板块对象。
- (id)initWithContent:(NSString *)content;

@end
