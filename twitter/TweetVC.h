//
//  TweetVC.h
//  twitter
//
//  Created by Charles Lee on 2/3/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@interface TweetVC : UIViewController

@property (nonatomic, strong) Tweet *tweet;
@property (weak, nonatomic) IBOutlet UIImageView *userProfileImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameTextView;
@property (weak, nonatomic) IBOutlet UILabel *userScreenNameTextView;
@property (weak, nonatomic) IBOutlet UILabel *tweetTextView;
@property (weak, nonatomic) IBOutlet UILabel *timestampTextView;
@property (weak, nonatomic) IBOutlet UILabel *retweetCountTextView;
@property (weak, nonatomic) IBOutlet UILabel *favoriteCountTextView;

@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UIButton *replyButton;
@end
