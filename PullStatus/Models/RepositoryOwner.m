//
//  RepositoryOwner.m
//
//
//  Created by Brendan Erwin on 4/22/13.
//  Copyright (c) 2013. All rights reserved.
//

#import "RepositoryOwner.h"

@implementation RepositoryOwner

- (RepositoryOwner *)initWithJSON:(NSDictionary *)JSON {
    self = [super init];
    if (self) {
        self.avatarUrl = [NSURL URLWithString:JSON[@"avatar_url"]];
        self.gravatarId = JSON[@"gravatar_id"];
        self.repositoryOwnerId = JSON[@"id"];
        self.login = JSON[@"login"];
        self.url = [NSURL URLWithString:JSON[@"url"]];
    }
    return self;
}

@end
