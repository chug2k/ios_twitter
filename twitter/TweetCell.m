//
//  TweetCell.m
//  twitter
//
//  Created by Timothy Lee on 8/6/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import "TweetCell.h"
#import "TwitterClient.h"
#import "NewTweetVC.h"

@implementation TweetCell

- (IBAction)onReplyPressed:(id)sender {
    [self.delegate onReply:self tweet:self.tweet];
}

- (IBAction)onRetweetPressed:(id)sender {
    [self.delegate onRetweet:self tweet:self.tweet];
  }

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
