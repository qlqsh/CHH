//
//  HTMLHandlerTests.m
//  CHH
//
//  Created by 刘明 on 14-7-9.
//  Copyright (c) 2014年 刘明. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "HTMLHandler.h"

@interface HTMLHandlerTests : XCTestCase

@end

@implementation HTMLHandlerTests

#pragma mark -

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

#pragma mark - 内容处理测试

- (void)testSpecialCharHandler
{
    NSString *specialCharString = @"空格 &nbsp;\n< &lt;\n> &gt;\n& &amp;\n¢ &cent;\n£ &pound;\n¥ &yen;\n€ &euro;\n§ &sect;\n© &copy;\n® &reg;\n™ &trade;";
    NSString *resultString = @"空格  \n< <\n> >\n& &\n¢ ¢\n£ £\n¥ ¥\n€ €\n§ §\n© ©\n® ®\n™ ™";
    
    NSString *handlerString = [HTMLHandler specialCharHandler:specialCharString];
    
    XCTAssertTrue([resultString isEqualToString:handlerString] == YES, @"预期转换后为：\n%@\n实际转换后为：\n%@", resultString, handlerString);
}

- (void)testUnnecessaryTagHandler
{
    NSString *htmlString1 = @"<span>该用户已注册</span>";
    NSString *resultString1 = @"该用户已注册";
    NSString *handlerString1 = [HTMLHandler unnecessaryTagHandler:htmlString1];
    
    XCTAssertTrue([resultString1 isEqualToString:handlerString1] == YES, @"预期结果：\n%@\n实际结果：\n%@\n", resultString1, handlerString1);
    
    NSString *htmlString2 = @"<span><span>tvenana</span></span>";
    NSString *resultString2 = @"tvenana";
    NSString *handlerString2 = [HTMLHandler unnecessaryTagHandler:htmlString2];
    
    XCTAssertTrue([resultString2 isEqualToString:handlerString2] == YES, @"预期结果：\n%@\n实际结果：\n%@\n", resultString2, handlerString2);
}

#pragma mark - URL处理测试

- (void)testIsValidURL
{
    // nil的时候
    NSString *urlString1 = nil;
    XCTAssertFalse([HTMLHandler isValidURL:urlString1], @"一个nil的字符串，应该不是合法URL");
    
    // @""的时候
    NSString *urlString2 = @"";
    XCTAssertFalse([HTMLHandler isValidURL:urlString2], @"一个空的字符串，应该不是合法URL");
    
    // http://www.wyxg.com 的时候
    NSString *urlString3 = @"http://www.wyxg.com";
    XCTAssertTrue([HTMLHandler isValidURL:urlString3], @"http://www.wyxg.com，应该是合法URL");
    
    // http://www.wyxg.com/index.htm 的时候
    NSString *urlString4 = @"http://www.wyxg.com/index.htm";
    XCTAssertTrue([HTMLHandler isValidURL:urlString4], @"http://www.wyxg.com/index.htm，应该是合法URL");
    
    // http://wyxg.com 的时候
    NSString *urlString5 = @"http://wyxg.com";
    XCTAssertTrue([HTMLHandler isValidURL:urlString5], @"http://wyxg.com，应该是合法URL");
    
    // www.wyxg.com 的时候
    NSString *urlString6 = @"www.wyxg.com";
    XCTAssertTrue([HTMLHandler isValidURL:urlString6], @"www.wyxg.com，应该是合法URL");
    
    // http://2007@www.wyxg.com 的时候
    NSString *urlString7 = @"http://2007@www.wyxg.com";
    XCTAssertTrue([HTMLHandler isValidURL:urlString7], @"http://2007@www.wyxg.com，应该是合法URL");
    
    // ftp://www.wyxg.com 的时候
    NSString *urlString8 = @"ftp://www.wyxg.com";
    XCTAssertTrue([HTMLHandler isValidURL:urlString8], @"ftp://www.wyxg.com，应该是合法URL");
	
	// http://www.ltaaa.com/bbs/forum-75-1.html 的时候
	NSString *urlString9 = @"http://www.ltaaa.com/bbs/forum-75-1.html";
    XCTAssertTrue([HTMLHandler isValidURL:urlString9], @"http://www.ltaaa.com/bbs/forum-75-1.html，应该是合法URL");
}

- (void)testURLConvertWithNeedChangeURL_andCurrentURL
{
    // 任一参数为nil或空字符串的时候
    NSString *needChangeURL = nil;
    NSString *currentURL = @"http://www.ltaaa.com";
    NSString *result = [HTMLHandler urlConvertWithNeedChangeURL:needChangeURL andCurrentURL:currentURL];
    XCTAssertNil(result, @"有参数为nil，应该返回nil才对");
    
    needChangeURL = @"thread-250046-1-1.html";
    currentURL = nil;
    result = [HTMLHandler urlConvertWithNeedChangeURL:needChangeURL andCurrentURL:currentURL];
    XCTAssertNil(result, @"有参数为nil，应该返回nil才对");
    
    needChangeURL = @"";
    currentURL = @"http://www.ltaaa.com";
    result = [HTMLHandler urlConvertWithNeedChangeURL:needChangeURL andCurrentURL:currentURL];
    XCTAssertNil(result, @"有参数为空字符串，应该返回nil才对");
    
    needChangeURL = @"thread-250046-1-1.html";
    currentURL = @"";
    result = [HTMLHandler urlConvertWithNeedChangeURL:needChangeURL andCurrentURL:currentURL];
    XCTAssertNil(result, @"有参数为空字符串，应该返回nil才对");
    
    // 参数正常情况下，几种情况测试
    needChangeURL = @"thread-250046-1-1.html";
    currentURL = @"http://www.ltaaa.com";
    NSString *expect = @"http://www.ltaaa.com/thread-250046-1-1.html";
    result = [HTMLHandler urlConvertWithNeedChangeURL:needChangeURL andCurrentURL:currentURL];
    XCTAssertTrue([expect isEqualToString:result], @"预期：%@\n结果：%@", expect, result);
    
    needChangeURL = @"thread-250046-1-1.html";
    currentURL = @"http://www.ltaaa.com/";
    expect = @"http://www.ltaaa.com/thread-250046-1-1.html";
    result = [HTMLHandler urlConvertWithNeedChangeURL:needChangeURL andCurrentURL:currentURL];
    XCTAssertTrue([expect isEqualToString:result], @"预期：%@\n结果：%@", expect, result);
    
    needChangeURL = @"thread-250046-1-1.html";
    currentURL = @"http://www.ltaaa.com/bbs";
    expect = @"http://www.ltaaa.com/bbs/thread-250046-1-1.html";
    result = [HTMLHandler urlConvertWithNeedChangeURL:needChangeURL andCurrentURL:currentURL];
    XCTAssertTrue([expect isEqualToString:result], @"预期：%@\n结果：%@", expect, result);
    
    needChangeURL = @"thread-250046-1-1.html";
    currentURL = @"http://www.ltaaa.com/bbs/";
    expect = @"http://www.ltaaa.com/bbs/thread-250046-1-1.html";
    result = [HTMLHandler urlConvertWithNeedChangeURL:needChangeURL andCurrentURL:currentURL];
    XCTAssertTrue([expect isEqualToString:result], @"预期：%@\n结果：%@", expect, result);
    
    needChangeURL = @"thread-250046-1-1.html";
    currentURL = @"http://www.ltaaa.com/bbs/xxxx.htm";
    expect = @"http://www.ltaaa.com/bbs/thread-250046-1-1.html";
    result = [HTMLHandler urlConvertWithNeedChangeURL:needChangeURL andCurrentURL:currentURL];
    XCTAssertTrue([expect isEqualToString:result], @"预期：%@\n结果：%@", expect, result);
    
    needChangeURL = @"thread-250046-1-1.html";
    currentURL = @"http://www.ltaaa.com/bbs/xxxx.html";
    expect = @"http://www.ltaaa.com/bbs/thread-250046-1-1.html";
    result = [HTMLHandler urlConvertWithNeedChangeURL:needChangeURL andCurrentURL:currentURL];
    XCTAssertTrue([expect isEqualToString:result], @"预期：%@\n结果：%@", expect, result);
    
    needChangeURL = @"thread-250046-1-1.html";
    currentURL = @"http://www.ltaaa.com/bbs/xx.html&user=aaa&pass=ss";
    expect = @"http://www.ltaaa.com/bbs/thread-250046-1-1.html";
    result = [HTMLHandler urlConvertWithNeedChangeURL:needChangeURL andCurrentURL:currentURL];
    XCTAssertTrue([expect isEqualToString:result], @"预期：%@\n结果：%@", expect, result);
    
    needChangeURL = @"thread-250046-1-1.html";
    currentURL = @"http://www.ltaaa.com/bbs/forum.php";
    expect = @"http://www.ltaaa.com/bbs/thread-250046-1-1.html";
    result = [HTMLHandler urlConvertWithNeedChangeURL:needChangeURL andCurrentURL:currentURL];
    XCTAssertTrue([expect isEqualToString:result], @"预期：%@\n结果：%@", expect, result);
    
	// ../的情况
    needChangeURL = @"../thread-250046-1-1.html";
    currentURL = @"http://www.ltaaa.com/bbs/forum.php";
    expect = @"http://www.ltaaa.com/thread-250046-1-1.html";
    result = [HTMLHandler urlConvertWithNeedChangeURL:needChangeURL andCurrentURL:currentURL];
    XCTAssertTrue([expect isEqualToString:result], @"预期：%@\n结果：%@", expect, result);
}

@end
