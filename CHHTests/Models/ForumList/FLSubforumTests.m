//
//  SubForumTests.m
//  CHH
//
//  Created by 刘明 on 14-7-30.
//  Copyright (c) 2014年 刘明. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FLSubforum.h"

#define LOCAL_DIRECTORY @"/Users/liuming/Documents/liuming/2014工程/"

@interface FLSubforumTests : XCTestCase

@end

@implementation FLSubforumTests

- (void)setUp {
	[super setUp];
	// Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
	// Put teardown code here. This method is called after the invocation of each test method in the class.
	[super tearDown];
}

#pragma mark - 测试 FLSubforum 方法

/**
*  判断2个 FLSubforum 对象是否相同。
*/
- (void)testIsEquals {
	// 预期对象
	FLSubforum *expectSubforum = [[FLSubforum alloc] init];
    expectSubforum.name   = @"业界新闻";
    expectSubforum.href   = @"forum.php?mod=forumdisplay&fid=80&mobile=yes";
    expectSubforum.number = @"";


	// 测试仅 number 不同的2个 FLSubforum 对象。
    NSString *pathString  = @"CHH/CHHTests/TestsResource/ForumListSnippet1.html";
    NSString *path        = [NSString stringWithFormat:@"%@%@", LOCAL_DIRECTORY, pathString];
    NSString *htmlContent = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    FLSubforum *subforum  = [[FLSubforum alloc] initWithContent:htmlContent];


	XCTAssert([expectSubforum isEqual:subforum], @"\n2个对象不相同：\t\n预期对象：%@\t\n网页提取对象：%@",
			[expectSubforum description], [subforum description]);
}


@end
