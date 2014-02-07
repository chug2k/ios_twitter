//
//  TweetCell.h
//  twitter
//
//  Created by Timothy Lee on 8/6/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweetCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *userFullNameTextView;
@property (weak, nonatomic) IBOutlet UILabel *screennameTextView;
@property (weak, nonatomic) IBOutlet UILabel *timeTextView;
@property (weak, nonatomic) IBOutlet UILabel *screenNameTextView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;
@property (weak, nonatomic) IBOutlet UILabel *retweetedTextView;

@property (weak, nonatomic) IBOutlet UILabel *tweetTextView;
@end
