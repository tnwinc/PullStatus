//
//  RepositoryOwner.h
//
//
//  Created by Brendan Erwin on 4/22/13.
//  Copyright (c) 2013. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RepositoryOwner : NSObject

@property (nonatomic, strong) NSURL *avatarUrl;
@property (nonatomic, strong) NSString *gravatarId;
@property (nonatomic, strong) NSNumber *repositoryOwnerId;
@property (nonatomic, strong) NSString *login;
@property (nonatomic, strong) NSURL *url;

- (RepositoryOwner *)initWithJSON:(NSDictionary *)aDictionary;

@end
