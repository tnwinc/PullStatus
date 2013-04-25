//
//  Repository.m
//
//
//  Created by Brendan Erwin on 4/23/13.
//  Copyright (c) 2013. All rights reserved.
//

#import "Repository.h"
#import "RepositoryOwner.h"

@implementation Repository

- (Repository *)initWithJSON:(NSDictionary *)JSON {
    NSDateFormatter *formatter = [self class].dateFormatter;
    
    self = [super init];
    if (self) {
        self.name = JSON[@"name"];
        if (JSON[@"description"] != (id)[NSNull null]) {
            self.descriptionText = JSON[@"description"];
        } else {
            self.descriptionText = @"";
        }
        self.owner = [[RepositoryOwner alloc] initWithJSON:JSON[@"owner"]];
        self.cloneUrl = [NSURL URLWithString:JSON[@"clone_url"]];
        self.createdAt = [formatter dateFromString:JSON[@"created_at"]];
        self.gitUrl = [NSURL URLWithString:JSON[@"git_url"]];
        self.htmlUrl = [NSURL URLWithString:JSON[@"html_url"]];
        self.pushedAt = [formatter dateFromString:JSON[@"pushed_at"]];
        self.sshUrl = [NSURL URLWithString:JSON[@"ssh_url"]];
        self.updatedAt = [formatter dateFromString:JSON[@"updated_at"]];
        self.url = [NSURL URLWithString:JSON[@"url"]];
    }
    return self;
}

+ (NSDateFormatter *)dateFormatter {
    static NSDateFormatter *formatter;
    
    if (!formatter) {
        @synchronized(self) {
            if (!formatter) {
                formatter = [[NSDateFormatter alloc] init];
                assert(formatter != nil);
                
                NSLocale *enUSPOSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
                assert(enUSPOSIXLocale != nil);
                
                [formatter setLocale:enUSPOSIXLocale];
                [formatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
                [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
            }
        }
    }
    
    assert(formatter != nil);
    return formatter;
}

+ (NSArray *)getRepoModels:(NSArray *)reposJSON {
    NSMutableArray *repos = [[NSMutableArray alloc] init];
    for (NSDictionary *repoJSON in reposJSON) {
        [repos addObject:[[Repository alloc] initWithJSON:repoJSON]];
    }
    return [[NSArray alloc] initWithArray:repos];
}

@end
