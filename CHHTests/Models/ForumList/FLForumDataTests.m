//
//  FLForumDataTests.m
//  CHH
//
//  Created by 刘明 on 14-8-25.
//  Copyright (c) 2014年 刘明. All rights reserved.
//
#import <XCTest/XCTest.h>
#import "FLForumData.h"

@interface FLForumDataTests : XCTestCase

@end

@implementation FLForumDataTests

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

#pragma mark - 相等方法测试
/**
 *  判断网页提取对象与归档后解档出的对象相等
 */
- (void)testIsEquals
{
//    FLForumData *forumData = [[FLForumData alloc] init];
    
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
//    NSString *savePath        = [NSHomeDirectory() stringByAppendingString:@"/Library/Caches/forum.chh"];
//    NSMutableData *saveData   = [NSMutableData data];
//    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:saveData];
//    [archiver encodeObject:forumData forKey:@"forum"];
//    [archiver finishEncoding];
//    BOOL success = [saveData writeToFile:savePath atomically:YES];
//    if (!success)
//    {
//        NSLog(@"存档失败, %@", savePath);
//    }
//    
//    // 解档
//    NSString *loadPath            = [NSHomeDirectory() stringByAppendingString:@"/Library/Caches/forum.chh"];
//    NSMutableData *loadData       = [NSMutableData dataWithContentsOfFile:loadPath];
//    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:loadData];
//    FLForumData *otherForumData   = [unarchiver decodeObjectForKey:@"forum"];
//    
//    XCTAssert([forumData isEqual:otherForumData], @"\n2个对象不相等：\n程序对象：%@\n解档对象：%@", forumData, otherForumData);
}

@end
