//
//  PostsCell.h
//  CHH
//
//  Created by 刘明 on 14-10-8.
//  Copyright (c) 2014年 刘明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *author;
@property (weak, nonatomic) IBOutlet UILabel *releaseDate;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *replySum;

@property(nonatomic, copy) NSString *href;          // 地址

@end
