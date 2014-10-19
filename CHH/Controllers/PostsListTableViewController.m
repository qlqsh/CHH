//
//  PostsListTableViewController.m
//  CHH
//
//  Created by 刘明 on 14-10-8.
//  Copyright (c) 2014年 刘明. All rights reserved.
//

#import "PostsListTableViewController.h"
#import "PLPosts.h"
#import "PLSubforum.h"
#import "PostsCell.h"

#define LOCAL_DIRECTORY @"/Users/liuming/Documents/liuming/2014工程/" // 临时措施

@interface PostsListTableViewController ()

@end

@implementation PostsListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    // TODO：临时措施，最终需要SubforumTableViewController 通过 segue 把需要访问的链接地址传递过来。
    NSString *pathString = @"CHH/CHHTests/Models/PostsList/PL.txt";
    NSString *path = [NSString stringWithFormat:@"%@%@", LOCAL_DIRECTORY, pathString];
    NSData *htmlData = [NSData dataWithContentsOfFile:path];
    PLSubforum *subforum = [[PLSubforum alloc] initWithContent:htmlData];
    _postsList = subforum.postsList;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_postsList count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PostsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostsCell"];

    if (cell == nil) {
        cell = [[PostsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PostsCell"];
    }

    PLPosts *post = _postsList[(NSUInteger) indexPath.section];

    cell.title.text = post.title;
    cell.author.text = post.author;
    cell.releaseDate.text = post.releaseDate;
    cell.replySum.text = post.replySum;

    return cell;
}

@end
