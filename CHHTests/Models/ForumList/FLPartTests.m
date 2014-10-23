//
//  FLPartTests.m
//  CHH
//
//  Created by 刘明 on 14-8-22.
//  Copyright (c) 2014年 刘明. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FLPart.h"
#import "FLSubforum.h"

#define LOCAL_DIRECTORY @"/Users/liuming/Documents/liuming/2014工程/"

@interface FLPartTests : XCTestCase

- (void)testIsEquals;
@end

@implementation FLPartTests

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

#pragma mark - 测试 Part 对象方法
/**
 *  判断对象是否相同。
 *
 *  1、判断程序提取网页的数据后形成的对象与预想的对象是否相等；
 *  2、判断程序提取网页的数据后形成的对象与解档后的对象是否相等；
 */
- (void)testIsEquals
{
	// 预期对象
	FLPart *expectPart = [[FLPart alloc] init];
	expectPart.name  = @"掌设";
	NSMutableArray *subforumList = [[NSMutableArray alloc] init];

	FLSubforum *subforum1 = [[FLSubforum alloc] init];
	subforum1.name      = @"智能手机/手表";
	subforum1.number    = @"(20)";
	subforum1.href      = @"forum.php?mod=forumdisplay&fid=187&mobile=yes";
	[subforumList addObject:subforum1];

	FLSubforum *subforum2 = [[FLSubforum alloc] init];
	subforum2.name      = @"笔记本电脑";
	subforum2.number    = @"(7)";
	subforum2.href      = @"forum.php?mod=forumdisplay&fid=188&mobile=yes";
	[subforumList addObject:subforum2];

	FLSubforum *subforum3 = [[FLSubforum alloc] init];
	subforum3.name      = @"平板电脑";
	subforum3.number    = @"(17)";
	subforum3.href      = @"forum.php?mod=forumdisplay&fid=189&mobile=yes";
	[subforumList addObject:subforum3];

	expectPart.subforumList = [subforumList copy];


	// 网页提取对象
	NSString *pathString  = @"CHH/CHHTests/TestsResource/ForumListSnippet2.html";
	NSString *path        = [NSString stringWithFormat:@"%@%@", LOCAL_DIRECTORY, pathString];
	NSString *htmlContent = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
	FLPart *part  = [[FLPart alloc] initWithContent:htmlContent];

    
    XCTAssert([expectPart isEqual:part], @"\n2个对象不想等：\n预期对象：%@\n网页提取对象：%@", expectPart, part);
}

@end
