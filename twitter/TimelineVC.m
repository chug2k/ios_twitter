//
//  TimelineVC.m
//  twitter
//
//  Created by Timothy Lee on 8/4/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import "TimelineVC.h"
#import "TweetCell.h"
#import "TweetVC.h"
#import "UIImageView+AFNetworking.h"
#import "NewTweetVC.h"
#import "UIScrollView+SVInfiniteScrolling.h"
#import "NSDate+TimeAgo.h"

@interface TimelineVC ()

@property (nonatomic, strong) NSMutableArray *tweets;
@property (nonatomic, strong) NSString *maxId;
@property (nonatomic, strong) NSString *minId;

- (void)onSignOutButton;
- (void)onNewTweetButton;
- (void)reload;
- (void)appendNewTweet:(NSNotification *)notification;

@end

@implementation TimelineVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = @"Twitter";
        self.tweets = [[NSMutableArray alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appendNewTweet:) name:@"UserDidTweetNotification" object:nil];
        [self reload];
    }
    return self;
}
- (void)appendNewTweet:(NSNotification *)notification
{
    [self.tweets insertObject:notification.object atIndex:0];
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Sign Out" style:UIBarButtonItemStylePlain target:self action:@selector(onSignOutButton)];

 
    self.navigationItem.rightBarButtonItem =  [[UIBarButtonItem alloc] initWithTitle:@"New Tweet" style:UIBarButtonItemStylePlain target:self action:@selector(onNewTweetButton)];
    
    __weak typeof(self) weakSelf = self;
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf reload];
    }];
    
    
}
- (void)onNewTweetButton
{
    NewTweetVC *newTweetVC = [[NewTweetVC alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:newTweetVC];
    
    navController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:navController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TweetCell Delegate
- (void)onReply:(id)sender tweet:(Tweet *)tweet
{
    NewTweetVC *newTweetVC = [[NewTweetVC alloc] init];
    newTweetVC.parentTweet = tweet;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:newTweetVC];
    navController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:navController animated:YES completion:nil];

}

- (void)onRetweet:(id)sender tweet:(Tweet *)tweet
{
    TweetCell *cell = ((TweetCell *)sender);
    if(tweet.retweeted) {
        [[TwitterClient instance] destroyTweet:tweet.retweetId success:^(AFHTTPRequestOperation *operation, id response) {
            NSLog(@"%@", response);
            cell.retweetButton.backgroundColor = [UIColor clearColor];
            [tweet setRetweetedValue:NO];
            [tweet setRetweetId: nil];
            [tweet decrementRetweetCount];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@", error);
        }];
    } else {
        [[TwitterClient instance] postRetweet:tweet.id success:^(AFHTTPRequestOperation *operation, id response) {
            NSLog(@"%@", response);
            cell.retweetButton.backgroundColor = [UIColor greenColor];
            [tweet setRetweetedValue:YES];
            [tweet setRetweetId: response[@"id_str"]];
            [tweet incrementRetweetCount];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@", error);
        }];
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TweetCell";
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"TweetCell" owner:self options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = [topLevelObjects objectAtIndex:0];
    }

    Tweet *tweet = self.tweets[indexPath.row];
    cell.tweet = tweet;
    
    if(tweet.retweetedStatus.id) {
        cell.retweetedTextView.text = [NSString stringWithFormat:@"%@%@", @"Retweeted by ", tweet.name];
        tweet = tweet.retweetedStatus;
        cell.heightConstraint.constant = 12;
    } else {
        cell.heightConstraint.constant = 0;
    }
    if(tweet.retweeted) {
        cell.retweetButton.backgroundColor = [UIColor greenColor];
    }
    cell.userFullNameTextView.text = tweet.name;
    cell.screenNameTextView.text = tweet.screenName;
    cell.tweetTextView.text = tweet.text;
    
    [cell.profileImageView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:tweet.profileImageURL]]
                                 placeholderImage:nil
                                          success:nil
                                          failure:nil];
    
 
    cell.timeTextView.text = [tweet.createdDate timeAgoSimple];
    
    cell.delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	Tweet *item = self.tweets[indexPath.row];
    UITextView *textView = [[UITextView alloc] init];
    int width = 237;
    
    [textView setAttributedText:[[NSAttributedString alloc] initWithString:item.text]];
	CGRect textRect = [textView.text boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
												  options:NSStringDrawingUsesLineFragmentOrigin
											   attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}
												  context:nil];
    
    return textRect.size.height + 70;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TweetVC *tweetVC = [[TweetVC alloc] init];
    tweetVC.tweet = self.tweets[indexPath.row];
    [self.navigationController pushViewController:tweetVC animated:YES];
}

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */


#pragma mark - Private methods

- (void)onSignOutButton {
    [User setCurrentUser:nil];
}

#pragma mark - Ugly code
- (void) reload
{
    [[TwitterClient instance] homeTimelineWithCount:4 sinceId:nil maxId:self.maxId success:^(AFHTTPRequestOperation *operation, id response) {
//        NSLog(@"%@", response);
        NSMutableArray* newTweets = [Tweet tweetsWithArray:response];
        Tweet* lastTweet = (Tweet *)[newTweets lastObject];
        self.maxId = lastTweet.id;
        [newTweets removeLastObject]; // Hack to prevent duplication on sinceId. Can't figure out how to add 1 to this huge number.
        [self.tweets addObjectsFromArray:newTweets];
        [self.tableView reloadData];
        [self.tableView.infiniteScrollingView stopAnimating];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}

@end
