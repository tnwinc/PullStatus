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
        _name = JSON[@"name"];
        if (JSON[@"description"] != (id)[NSNull null]) {
            _descriptionText = JSON[@"description"];
        } else {
            _descriptionText = @"";
        }
        _owner = [[RepositoryOwner alloc] initWithJSON:JSON[@"owner"]];
        _cloneUrl = [NSURL URLWithString:JSON[@"clone_url"]];
        _createdAt = [formatter dateFromString:JSON[@"created_at"]];
        _gitUrl = [NSURL URLWithString:JSON[@"git_url"]];
        _htmlUrl = [NSURL URLWithString:JSON[@"html_url"]];
        _pushedAt = [formatter dateFromString:JSON[@"pushed_at"]];
        _sshUrl = [NSURL URLWithString:JSON[@"ssh_url"]];
        _updatedAt = [formatter dateFromString:JSON[@"updated_at"]];
        _url = [NSURL URLWithString:JSON[@"url"]];
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

+ (NSArray *)repoModelsFromJSON:(NSArray *)JSON {
    NSAssert(JSON, @"Must provide an array");
    NSMutableArray *repos = [[NSMutableArray alloc] init];
    for (NSDictionary *repoJSON in JSON) {
        [repos addObject:[[Repository alloc] initWithJSON:repoJSON]];
    }
    return [[NSArray alloc] initWithArray:repos];
}

@end
