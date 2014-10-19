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

// 需要解析的 HTML 内容
#define HTMLContent @"<div class=\"bm bmw  flg cl\">\n<div class=\"bm_h cl\">\n<span class=\"o\">\n<img id=\"category_174_img\" src=\"static/image/common/collapsed_no.gif\" title=\"收起/展开\" alt=\"收起/展开\" onclick=\"toggle_collapse(\'category_174\');\" />\n</span>\n<h2><a href=\"http://www.chiphell.com/forum.php?gid=174\" style=\"color: #FFFFFF;\">汽车</a></h2>\n</div>\n<div id=\"category_174\" class=\"bm_c\" style=\"\">\n<table cellspacing=\"0\" cellpadding=\"0\" class=\"fl_tb\">\n<tr><td class=\"fl_g\" width=\"32.9%\">\n<div class=\"fl_icn_g\">\n<a href=\"http://www.chiphell.com/forum-175-1.html\"><img src=\"static/image/common/forum_new.gif\" alt=\"汽车Show\" /></a>\n</div>\n<dl>\n<dt><a href=\"http://www.chiphell.com/forum-175-1.html\">汽车Show</a><em class=\"xw0 xi1\" title=\"今日\"> (14)</em></dt>\n<dd><em>主题: 953</em>, <em>帖数: <span title=\"106367\">10万</span></em></dd><dd>\n<a href=\"http://www.chiphell.com/forum.php?mod=redirect&amp;tid=1110581&amp;goto=lastpost#lastpost\">最后发表: 2014-8-22 10:21</a>\n</dd>\n</dl>\n</td>\n<td class=\"fl_g\" width=\"32.9%\">\n<div class=\"fl_icn_g\">\n<a href=\"http://www.chiphell.com/forum-177-1.html\"><img src=\"static/image/common/forum.gif\" alt=\"汽车改装\" /></a>\n</div>\n<dl>\n<dt><a href=\"http://www.chiphell.com/forum-177-1.html\" style=\"color: #2f2d32;\">汽车改装</a><em class=\"xw0 xi1\" title=\"今日\"> (5)</em></dt>\n<dd><em>主题: 330</em>, <em>帖数: 6810</em></dd><dd>\n<a href=\"http://www.chiphell.com/forum.php?mod=redirect&amp;tid=1111062&amp;goto=lastpost#lastpost\">最后发表: 2014-8-22 10:07</a>\n</dd>\n</dl>\n</td>\n<td class=\"fl_g\" width=\"32.9%\">\n<div class=\"fl_icn_g\">\n<a href=\"http://www.chiphell.com/forum-176-1.html\"><img src=\"static/image/common/forum_new.gif\" alt=\"汽车讨论\" /></a>\n</div>\n<dl>\n<dt><a href=\"http://www.chiphell.com/forum-176-1.html\" style=\"color: #2f2d32;\">汽车讨论</a><em class=\"xw0 xi1\" title=\"今日\"> (32)</em></dt>\n<dd><em>主题: 2649</em>, <em>帖数: <span title=\"69945\">6万</span></em></dd><dd>\n<a href=\"http://www.chiphell.com/forum.php?mod=redirect&amp;tid=1108673&amp;goto=lastpost#lastpost\">最后发表: 2014-8-22 10:14</a>\n</dd>\n</dl>\n</td>\n</tr>\n</table>\n</div>"

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
    FLPart *part = [[FLPart alloc] initWithContent:HTMLContent];
    
    FLPart *anPart = [[FLPart alloc] init];
    anPart.name  = @"汽车";
    NSMutableArray *subforumList = [[NSMutableArray alloc] init];
    
    FLSubforum *subforum1 = [[FLSubforum alloc] init];
    subforum1.name      = @"汽车Show";
    subforum1.number    = @"(16)";
    subforum1.href      = @"http://www.chiphell.com/forum-175-1.html";
    [subforumList addObject:subforum1];
    
    FLSubforum *subforum2 = [[FLSubforum alloc] init];
    subforum2.name      = @"汽车改装";
    subforum2.number    = @"(1)";
    subforum2.href      = @"http://www.chiphell.com/forum-177-1.html";
    [subforumList addObject:subforum2];
    
    FLSubforum *subforum3 = [[FLSubforum alloc] init];
    subforum3.name      = @"汽车讨论";
    subforum3.number    = @"(18)";
    subforum3.href      = @"http://www.chiphell.com/forum-176-1.html";
    [subforumList addObject:subforum3];
    
    anPart.subforumList = [subforumList copy];
    
    XCTAssert([anPart isEqual:part], @"\n2个对象不想等：\n网页提取对象：%@\n预期对象：%@", part, anPart);
    
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
    NSString *savePath        = [NSHomeDirectory() stringByAppendingString:@"/Library/Caches/part.chh"];
    NSMutableData *saveData   = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:saveData];
    [archiver encodeObject:part forKey:@"part"];
    [archiver finishEncoding];
    BOOL success = [saveData writeToFile:savePath atomically:YES];
    if (!success)
    {
        NSLog(@"存档失败, %@", savePath);
    }
    
    // 解档
    NSString *loadPath            = [NSHomeDirectory() stringByAppendingString:@"/Library/Caches/part.chh"];
    NSMutableData *loadData       = [NSMutableData dataWithContentsOfFile:loadPath];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:loadData];
    FLPart *otherPart               = [unarchiver decodeObjectForKey:@"part"];
    
    XCTAssert([part isEqual:otherPart], @"\n2个对象不相等：\n程序对象：%@\n解档对象：%@", part, otherPart);
}

@end
