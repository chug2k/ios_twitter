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
    return [[self.data valueOrNilForKeyPath:@"user"] valueOrNilForKeyPath:@"screen_name"];
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
- (NSString *)retweetCount {
    return [self.data valueOrNilForKeyPath:@"retweet_count"];
}
- (Tweet *)retweetedStatus {
    return [[Tweet alloc] initWithDictionary:[self.data valueOrNilForKeyPath:@"retweeted_status"]];
}


+ (NSMutableArray *)tweetsWithArray:(NSArray *)array {
    NSMutableArray *tweets = [[NSMutableArray alloc] initWithCapacity:array.count];
    for (NSDictionary *params in array) {
        [tweets addObject:[[Tweet alloc] initWithDictionary:params]];
    }
    return tweets;
}

@end
