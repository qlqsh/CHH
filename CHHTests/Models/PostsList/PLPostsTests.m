//
//  PLPostsTests.m
//  CHH
//
//  Created by 刘明 on 14-9-1.
//  Copyright (c) 2014年 刘明. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "PLPosts.h"

#define HTMLContent @"<tbody id=\"normalthread_1118100\">\n<tr>\n<td class=\"icn\">\n<a href=\"http://www.chiphell.com/thread-1118100-1-1.html\" title=\"有新回复 - 新窗口打开\" target=\"_blank\">\n<img src=\"static/image/common/folder_new.gif\" />\n</a>\n</td>\n<th class=\"new\">\n<a href=\"javascript:;\" id=\"content_1118100\" class=\"showcontent y\" title=\"更多操作\" onclick=\"CONTENT_TID=\'1118100\';CONTENT_ID=\'normalthread_1118100\';showMenu({\'ctrlid\':this.id,\'menuid\':\'content_menu\'})\"></a>\n<a class=\"tdpre y\" href=\"javascript:void(0);\" onclick=\"previewThread(\'1118100\', \'normalthread_1118100\');\">预览</a>\n <a href=\"http://www.chiphell.com/thread-1118100-1-1.html\" onclick=\"atarget(this)\" class=\"s xst\">升級了哈~~</a>\n<img src=\"static/image/filetype/image_s.gif\" alt=\"attach_img\" title=\"图片附件\" align=\"absmiddle\" />\n<img src=\"static/image/common/agree.gif\" align=\"absmiddle\" alt=\"agree\" title=\"帖子被加分\" />\n<a href=\"http://www.chiphell.com/forum.php?mod=redirect&amp;tid=1118100&amp;goto=lastpost#lastpost\" class=\"xi1\">New</a>\n</th>\n<td class=\"by\">\n<cite>\n<a href=\"http://www.chiphell.com/space-uid-275216.html\" c=\"1\">mito</a></cite>\n<em><span>2014-8-31 22:07</span></em>\n</td>\n<td class=\"num\"><a href=\"http://www.chiphell.com/thread-1118100-1-1.html\" class=\"xi2\">24</a><em>259</em></td>\n<td class=\"by\">\n<cite><a href=\"http://www.chiphell.com/space-username-%E9%A3%8E%E6%97%A0%E8%BF%B9.html\" c=\"1\">风无迹</a></cite>\n<em><a href=\"http://www.chiphell.com/forum.php?mod=redirect&tid=1118100&goto=lastpost#lastpost\">2014-9-1 07:00</a></em>\n</td>\n</tr>\n</tbody>"

@interface PLPostsTests : XCTestCase

@end

@implementation PLPostsTests

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
 *  判断2个帖子对象是否相同。
 *
 *  共3个对象参加测试：预期对象、网页解析对象、归档对象
 */
- (void)testIsEquals
{
    // 预期对象
    PLPosts *expectedPosts = [[PLPosts alloc] init];
    expectedPosts.title       = @"升級了哈~~";
    expectedPosts.href        = @"http://www.chiphell.com/thread-1118100-1-1.html";
    expectedPosts.replySum    = @"24";
    expectedPosts.author      = @"mito";
    expectedPosts.releaseDate = @"2014-8-31 22:07";
    
    // 网页解析对象
    PLPosts *parsePosts = [[PLPosts alloc] initWithContent:HTMLContent];
    
    XCTAssert([expectedPosts isEqual:parsePosts], @"\n2个对象不相同。\n预期对象：%@ \n网页解析对象：%@\n", expectedPosts, parsePosts);
    
    // 归档对象
    NSString *savePath        = [NSHomeDirectory() stringByAppendingString:@"/Library/Caches/posts.chh"];
    NSMutableData *saveData   = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:saveData];
    [archiver encodeObject:expectedPosts forKey:@"posts"];
    [archiver finishEncoding];
    BOOL success = [saveData writeToFile:savePath atomically:YES];
    if (!success)
    {
        NSLog(@"存档失败, %@", savePath);
    }
    // 解档
    NSString *loadPath            = [NSHomeDirectory() stringByAppendingString:@"/Library/Caches/posts.chh"];
    NSMutableData *loadData       = [NSMutableData dataWithContentsOfFile:loadPath];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:loadData];
    PLPosts *archiverPosts        = [unarchiver decodeObjectForKey:@"posts"];
    
    XCTAssert([parsePosts isEqual:archiverPosts], @"\n2个对象不相同。\n预期对象：%@ \n网页解析对象：%@\n", parsePosts, archiverPosts);
}

@end
