//
//  RLReplyTests.m
//  CHH
//
//  Created by 刘明 on 14/10/21.
//  Copyright (c) 2014年 刘明. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "RLReply.h"

#define LOCAL_DIRECTORY @"/Users/liuming/Documents/liuming/2014工程/"

@interface RLReplyTests : XCTestCase

@end

@implementation RLReplyTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
	// 预期1
	RLReply *expectedReply1 = [[RLReply alloc] init];
	expectedReply1.author = @"";
	expectedReply1.replyDate = @"";
	expectedReply1.content = @"";
	expectedReply1.imgHref = @"";


	// 预期2


	// 预期3

	NSString *pathString      = @"CHH/CHHTests/Models/ReplyList/RLTestSnippet1.txt";
	NSString *path            = [NSString stringWithFormat:@"%@%@", LOCAL_DIRECTORY, pathString];
	NSString *HTMLContent1    = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
	RLReply *parseReply = [[RLReply alloc] initWithContent:HTMLContent1];

}

@end
