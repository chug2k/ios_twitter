//
//  TweetCell.m
//  twitter
//
//  Created by Timothy Lee on 8/6/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import "TweetCell.h"
#import "TwitterClient.h"

@implementation TweetCell
- (IBAction)onRetweetPressed:(id)sender {
    if(self.tweet.retweeted) {
        [[TwitterClient instance] destroyTweet:self.tweet.retweetId success:^(AFHTTPRequestOperation *operation, id response) {
            NSLog(@"%@", response);
            self.retweetButton.backgroundColor = [UIColor clearColor];
            [self.tweet setRetweetedValue:NO];
            [self.tweet setRetweetId: nil];
            [self.tweet decrementRetweetCount];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@", error);
        }];
    } else {
        [[TwitterClient instance] postRetweet:self.tweet.id success:^(AFHTTPRequestOperation *operation, id response) {
            NSLog(@"%@", response);
            self.retweetButton.backgroundColor = [UIColor greenColor];
            [self.tweet setRetweetedValue:YES];
            [self.tweet setRetweetId: response[@"id_str"]];
            [self.tweet incrementRetweetCount];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@", error);
        }];
    }
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
