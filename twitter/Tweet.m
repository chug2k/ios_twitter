//
//  Tweet.m
//  twitter
//
//  Created by Timothy Lee on 8/5/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet

- (NSString *)id {
    return [self.data valueOrNilForKeyPath:@"id_str"];
}
- (NSString *)text {
    return [self.data valueOrNilForKeyPath:@"text"];
}
- (NSString *)name {
    return [[self.data valueOrNilForKeyPath:@"user"] valueOrNilForKeyPath:@"name"];
}
- (NSString *)screenName {
    NSString *screenName = [[self.data valueOrNilForKeyPath:@"user"] valueOrNilForKeyPath:@"screen_name"];
    return [NSString stringWithFormat:@"%@%@", @"@", screenName];
}
- (NSString *)profileImageURL {
    return [[self.data valueOrNilForKeyPath:@"user"] valueOrNilForKeyPath:@"profile_image_url"];
}
- (NSString *)created {
    return [self.data valueOrNilForKeyPath:@"created_at"];
}
- (NSDate *)createdDate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"EEE MMM dd HH:mm:ss Z yyyy"];
    return [formatter dateFromString:self.created];
}
- (int)retweetCount {
    return [[self.data valueOrNilForKeyPath:@"retweet_count"]intValue];
}
- (int)favoriteCount {
    return [[self.data valueOrNilForKeyPath:@"favorite_count"]intValue];
}

- (Tweet *)retweetedStatus {
    return [[Tweet alloc] initWithDictionary:[self.data valueOrNilForKeyPath:@"retweeted_status"]];
}
- (BOOL)retweeted {
    return [[self.data valueOrNilForKeyPath:@"retweeted"]
            boolValue];
}
- (BOOL)favorited {
    return [[self.data valueOrNilForKeyPath:@"favorited"]boolValue];
}

- (void)incrementRetweetCount {
    int count = self.retweetCount;
    count++;
    [self.data setValue:@(count) forKeyPath:@"retweet_count"];
}
- (void)decrementRetweetCount {
    int count = self.retweetCount;
    count--;
    [self.data setValue:@(count) forKeyPath:@"retweet_count"];
}
- (void) setRetweetedValue:(BOOL)val
{
    [self.data setValue:@(val) forKeyPath:@"retweeted"];
}
- (void) setFavoritedValue:(BOOL)val
{
    [self.data setValue:@(val) forKeyPath:@"favorited"];
}

- (void)incrementFavoriteCount {
    int count = self.favoriteCount;
    count++;
    [self.data setValue:@(count) forKeyPath:@"favorite_count"];
}
- (void)decrementFavoriteCount {
    int count = self.favoriteCount;
    count--;
    [self.data setValue:@(count) forKeyPath:@"favorite_count"];
}


+ (NSMutableArray *)tweetsWithArray:(NSArray *)array {
    NSMutableArray *tweets = [[NSMutableArray alloc] initWithCapacity:array.count];
    for (NSDictionary *params in array) {
        [tweets addObject:[[Tweet alloc] initWithDictionary:params]];
    }
    return tweets;
}

@end
