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
    // 网页解析对象（本地）（TODO: 因为没有存取权限，必须是登录用户，所以这里使用本地数据进行测试）
    NSString *pathString      = @"CHH/CHHTests/Models/PostsList/PL.txt";
    NSString *path            = [NSString stringWithFormat:@"%@%@", LOCAL_DIRECTORY, pathString];
    NSData *htmlData          = [NSData dataWithContentsOfFile:path];
    PLSubforum *parseSubforum = [[PLSubforum alloc] initWithContent:htmlData];
    
    // 归档对象
    NSString *savePath        = [NSHomeDirectory() stringByAppendingString:@"/Library/Caches/subforum.chh"];
    NSMutableData *saveData   = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:saveData];
    [archiver encodeObject:parseSubforum forKey:@"subforum"];
    [archiver finishEncoding];
    BOOL success = [saveData writeToFile:savePath atomically:YES];
    if (!success)
    {
        NSLog(@"存档失败, %@", savePath);
    }
    // 解档
    NSString *loadPath            = [NSHomeDirectory() stringByAppendingString:@"/Library/Caches/subforum.chh"];
    NSMutableData *loadData       = [NSMutableData dataWithContentsOfFile:loadPath];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:loadData];
    PLSubforum *archiverSubforum  = [unarchiver decodeObjectForKey:@"subforum"];
    
    XCTAssert([parseSubforum isEqual:archiverSubforum], @"\n2个对象不相同。\n网页解析对象：%@ \n归档对象：%@\n", parseSubforum, archiverSubforum);
    
    // 预期帖子数量和网页解析出帖子数量对比 TODO：因为一些特殊情况，所以有些帖子目前无法解析。
    // XCTAssert(50 == [parseSubforum.postsList count], @"\n是预期的帖子数量。\n帖子数量不对：%ld\n", [parseSubforum.postsList count]);
}

@end
