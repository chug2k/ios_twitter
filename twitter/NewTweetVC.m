//
//  NewTweetVC.m
//  twitter
//
//  Created by Charles Lee on 2/3/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "NewTweetVC.h"
#import "User.h"
#import "UIImageView+AFNetworking.h"

@interface NewTweetVC ()
- (void) onBackButton;
- (void) onTweetButton;

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *screennameTextLabel;

@property (weak, nonatomic) IBOutlet UITextView *tweetTextView;

@end

@implementation NewTweetVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"New Tweet";
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(onBackButton)];
        
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Tweet" style:UIBarButtonItemStylePlain target:self action:@selector(onTweetButton)];
        
        self.edgesForExtendedLayout = UIRectEdgeNone;

        
    }

    return self;
}

- (void) onBackButton
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void) onTweetButton
{
    [[TwitterClient instance] postTweet:self.tweetTextView.text success:^(AFHTTPRequestOperation *operation, id response) {
        NSLog(@"%@", response);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       NSLog(@"Failure %@", error);
    }];

    [self onBackButton];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar.layer removeAllAnimations];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    User *user = [User currentUser];
    self.nameTextLabel.text = user.name;
    self.screennameTextLabel.text = user.screenName;
    
    [self.profileImageView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:user.profileImageURL]]
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
