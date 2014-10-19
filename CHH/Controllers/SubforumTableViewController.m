//
//  SubforumTableViewController.m
//  CHH
//
//  Created by 刘明 on 14-7-8.
//  Copyright (c) 2014年 刘明. All rights reserved.
//

#import "SubforumTableViewController.h"
#import "FLForumData.h"
#import "FLPart.h"
#import "FLSubforum.h"

@interface SubforumTableViewController ()

@end

@implementation SubforumTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    FLForumData *forumData = [[FLForumData alloc] init];
    _partList = forumData.partList;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource

/**
*  节数。
*/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_partList count];
}

/**
*  每节行数。
*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    FLPart *part = _partList[(NSUInteger) section];
    return [part.subforumList count];
}

/**
*  定义每一行。
*/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SubforumCell" forIndexPath:indexPath];

    FLPart *part = _partList[(NSUInteger) indexPath.section];
    FLSubforum *subforum = (part.subforumList)[(NSUInteger) indexPath.row];

    cell.textLabel.text = [NSString stringWithFormat:@"%@%@", subforum.name, subforum.number];

    return cell;
}

/**
* 设置头内容。
*/
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    FLPart *part = _partList[(NSUInteger) section];
    return part.name;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
