//
//  SubForumTests.m
//  CHH
//
//  Created by 刘明 on 14-7-30.
//  Copyright (c) 2014年 刘明. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FLSubforum.h"

// 需要解析的 HTML 内容
#define HTMLContent1 @"<dt><a href=\"http://www.chiphell.com/forum-65-1.html\" style=\"color: #2f2d32;\">败家Show</a><em class=\"xw0 xi1\" title=\"今日\"> (33)</em></dt>"
#define HTMLContent2 @"<dt><a href=\"http://www.chiphell.com/forum-65-1.html\" style=\"color: #2f2d32;\">败家Show</a><em class=\"xw0 xi1\" title=\"今日\"> (3)</em></dt>"

@interface FLSubforumTests : XCTestCase

@end

@implementation FLSubforumTests

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

#pragma mark - 测试 FLSubforum 方法
/**
 *  判断2个 FLSubforum 对象是否相同。
 */
- (void)testIsEquals
{
    // 测试仅 number 不同的2个 FLSubforum 对象。
    FLSubforum *subforum1 = [[FLSubforum alloc] initWithContent:HTMLContent1];
    FLSubforum *subforum2 = [[FLSubforum alloc] initWithContent:HTMLContent2];
    
    XCTAssert([subforum1 isEqual:subforum2], @"2个对象不相同：%@\t%@", [subforum1 description], [subforum2 description]);
    
    // 测试网页提取对象与 initWithCoder 对象。
    /**
     *  存档
     *  NSHomeDirectory()   根目录。4个文件夹（Documents、AppName.app、Library、tmp）
     *      AppName.app     程序目录。
     *      Documents       存储用户数据或其它定期备份信息。
     *      Library
     *          Preferences 偏好设置目录。
     *          Caches      程序专用的支持文件目录。保存程序再次启动中需要的信息。
     *      tmp             临时文件目录。程序再次启动中不需要的信息。
     */
    NSString *savePath        = [NSHomeDirectory() stringByAppendingString:@"/Library/Caches/FLSubforum.chh"];
    NSMutableData *saveData   = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:saveData];
    [archiver encodeObject:subforum2 forKey:@"subforum1"];
    [archiver finishEncoding];
    BOOL success = [saveData writeToFile:savePath atomically:YES];
    if (!success)
    {
        NSLog(@"存档失败, %@", savePath);
    }
    
    // 解档
    NSString *loadPath            = [NSHomeDirectory() stringByAppendingString:@"/Library/Caches/FLSubforum.chh"];
    NSMutableData *loadData       = [NSMutableData dataWithContentsOfFile:loadPath];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:loadData];
    FLSubforum *subforum3           = [unarchiver decodeObjectForKey:@"subforum1"];
    XCTAssert([subforum3 isEqual:subforum1], @"2个对象不相同：%@\t%@", [subforum1 description], [subforum3 description]);
}


@end
