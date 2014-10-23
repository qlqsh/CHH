//
//  PLPostsTests.m
//  CHH
//
//  Created by 刘明 on 14-9-1.
//  Copyright (c) 2014年 刘明. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PLPosts.h"

#define LOCAL_DIRECTORY @"/Users/liuming/Documents/liuming/2014工程/"

@interface PLPostsTests : XCTestCase

@end

@implementation PLPostsTests

- (void)setUp {
	[super setUp];
	// Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
	// Put teardown code here. This method is called after the invocation of each test method in the class.
	[super tearDown];
}

#pragma mark - 方法测试

/**
*  判断2个帖子对象是否相同。
*
*  共3个对象参加测试：预期对象、网页解析对象、归档对象
*/
- (void)testIsEquals {
	// 预期对象
	PLPosts *expectedPosts = [[PLPosts alloc] init];
	expectedPosts.title = @"Chiphell基础攻略 V0.8";
	expectedPosts.href = @"forum.php?mod=viewthread&tid=382666&mobile=yes";
	expectedPosts.replySum = @"回1200";
	expectedPosts.author = @"nApoleon";
	expectedPosts.releaseDate = @"2012-3-14 00:31";


	// 网页解析对象
	NSString *pathString = @"CHH/CHHTests/TestsResource/PostsListSnippet1.html";
	NSString *path = [NSString stringWithFormat:@"%@%@", LOCAL_DIRECTORY, pathString];
	NSString *htmlContent = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
	PLPosts *parsePosts = [[PLPosts alloc] initWithContent:htmlContent];


	XCTAssert([expectedPosts isEqual:parsePosts], @"\n2个对象不相同。\n预期对象：%@ \n网页解析对象：%@\n",
              [expectedPosts description], [parsePosts description]);
}

@end
