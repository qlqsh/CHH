//
//  PLSubforumTests.m
//  CHH
//
//  Created by 刘明 on 14-9-1.
//  Copyright (c) 2014年 刘明. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PLSubforum.h"

#define LOCAL_DIRECTORY @"/Users/liuming/Documents/liuming/2014工程/"
//#define URL @"http://www.chiphell.com/forum.php?mod=forumdisplay&fid=80&page=1&mobile=yes"
#define URL @"http://www.chiphell.com/forum.php?mod=forumdisplay&fid=80&page=2&mobile=yes"

@interface PLSubforumTests : XCTestCase

@end

@implementation PLSubforumTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark - 方法测试
/**
 *  测试2个对象是否相同。
 *
 *  硬编数据太多，不值得，判断一下预期帖子数量就行。共2个对象参与测试：网页提取对象、归档对象。
 */
- (void)testIsEquals
{
    // 网页解析对象（本地）
    PLSubforum *parseSubforum = [[PLSubforum alloc] initWithURL:URL];
    
    // 帖子数量每页并不一样，所以这里的测试意义不大。
    XCTAssert(30 == [parseSubforum.postsList count], @"\n是预期的帖子数量。\n帖子数量不对：%ld\n", [parseSubforum.postsList count]);
}

@end
