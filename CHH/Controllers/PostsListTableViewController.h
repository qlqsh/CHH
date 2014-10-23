//
//  PostsListTableViewController.h
//  CHH
//
//  Created by 刘明 on 14-10-8.
//  Copyright (c) 2014年 刘明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostsListTableViewController : UITableViewController

@property (nonatomic, copy) NSString *href;
@property (nonatomic, strong) NSArray *postsList;

@end
