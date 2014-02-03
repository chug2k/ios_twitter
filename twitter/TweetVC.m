//
//  TweetVC.m
//  twitter
//
//  Created by Charles Lee on 2/3/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "TweetVC.h"
#import "UIImageView+AFNetworking.h"


@interface TweetVC ()

@end

@implementation TweetVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Tweet!";
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
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
