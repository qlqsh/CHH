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

@interface PostsListTableViewController ()

@end

@implementation PostsListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSLog(@"%@", _href);
    
    PLSubforum *subforum = [[PLSubforum alloc] initWithURL:_href];
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
