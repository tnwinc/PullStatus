//
//  RepositoryOwner.h
//  
//
//  Created by Brendan Erwin on 4/22/13.
//  Copyright (c) 2013. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RepositoryOwner : NSObject

@property (nonatomic, copy) NSURL *avatarUrl;
@property (nonatomic, copy) NSString *gravatarId;
@property (nonatomic, copy) NSNumber *RepositoryOwnerId;
@property (nonatomic, copy) NSString *login;
@property (nonatomic, copy) NSURL *url;


+ (RepositoryOwner *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

@end
