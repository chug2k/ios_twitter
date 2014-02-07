//
//  TweetVC.m
//  twitter
//
//  Created by Charles Lee on 2/3/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "TweetVC.h"
#import "UIImageView+AFNetworking.h"
#import "TwitterClient.h"
#import "NewTweetVC.h"


@interface TweetVC ()
- (IBAction)onReplyPressed:(id)sender;
- (IBAction)onRetweetPressed:(id)sender;
- (IBAction)onFavoritePressed:(id)sender;

@end

@implementation TweetVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Tweet Detailz";
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.userNameTextView.text = self.tweet.name;
    self.userScreenNameTextView.text = self.tweet.screenName;
    self.tweetTextView.text = self.tweet.text;
    self.timestampTextView.text = self.tweet.created;

    [self.userProfileImageView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.tweet.profileImageURL]]
                                 placeholderImage:nil
                                          success:nil
                                          failure:nil];
    self.retweetCountTextView.text = [NSString stringWithFormat:@"%d",self.tweet.retweetCount];
    self.favoriteCountTextView.text = [NSString stringWithFormat:@"%d",self.tweet.favoriteCount];
    
    if(self.tweet.retweeted) {
        self.retweetButton.backgroundColor = [UIColor greenColor];
    }
    if(self.tweet.favorited) {
        self.favoriteButton.backgroundColor = [UIColor redColor];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onReplyPressed:(id)sender {
    NewTweetVC *newTweetVC = [[NewTweetVC alloc] init];
    newTweetVC.parentTweet = self.tweet;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:newTweetVC];
    navController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:navController animated:YES completion:nil];
}

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
    [[NSNotificationCenter defaultCenter] postNotificationName:@"UserDidTakeActionNotification" object:nil];
}

- (IBAction)onFavoritePressed:(id)sender {
    if(self.tweet.favorited) {
        [[TwitterClient instance] destroyFavorite:self.tweet.id success:^(AFHTTPRequestOperation *operation, id response) {
            self.favoriteButton.backgroundColor = [UIColor clearColor];
            [self.tweet setFavoritedValue:NO];
            [self.tweet decrementFavoriteCount];
            NSLog(@"Decrementing favorite count");
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@", error);
        }];
    } else {
        [[TwitterClient instance] favoriteTweet:self.tweet.id success:^(AFHTTPRequestOperation *operation, id response) {
            self.favoriteButton.backgroundColor = [UIColor redColor];
            [self.tweet setFavoritedValue:YES];
            [self.tweet incrementFavoriteCount];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@", error);
        }];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"UserDidTakeActionNotification" object:nil];

}
@end

