//
//  TweetCell.h
//  twitter
//
//  Created by Timothy Lee on 8/6/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@protocol TweetCellDelegate

-(void)onReply:(id)sender tweet:(Tweet *)tweet;
-(void)onRetweet:(id)sender tweet:(Tweet *)tweet;
-(void)onFavorite:(id)sender tweet:(Tweet *)tweet;

@end

@interface TweetCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *userFullNameTextView;
@property (weak, nonatomic) IBOutlet UILabel *screennameTextView;
@property (weak, nonatomic) IBOutlet UILabel *timeTextView;
@property (weak, nonatomic) IBOutlet UILabel *screenNameTextView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;
@property (weak, nonatomic) IBOutlet UILabel *retweetedTextView;

@property (weak, nonatomic) IBOutlet UILabel *tweetTextView;

@property (weak, nonatomic) Tweet* tweet;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;

@property (weak, nonatomic) id<TweetCellDelegate>delegate;

@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;

@end
