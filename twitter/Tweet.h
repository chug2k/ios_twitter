//
//  Tweet.h
//  twitter
//
//  Created by Timothy Lee on 8/5/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tweet : RestObject

@property (nonatomic, strong, readonly) NSString *id;
@property (nonatomic, strong, readonly) NSString *text;
@property (nonatomic, strong, readonly) NSString *screenName;
@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSString *profileImageURL;
@property (nonatomic, strong, readonly) NSString *created;
@property (nonatomic, strong, readonly) NSDate *createdDate;
@property (readonly) int retweetCount;
@property (nonatomic, strong, readonly) Tweet *retweetedStatus;
@property (nonatomic, strong) NSString *retweetId;

@property (nonatomic) BOOL retweeted;

-(void) setRetweetedValue:(BOOL)val;
-(void) incrementRetweetCount;
-(void) decrementRetweetCount;

+ (NSMutableArray *)tweetsWithArray:(NSArray *)array;

@end
