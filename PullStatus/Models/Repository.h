//
//  Repository.h
//  
//
//  Created by Brendan Erwin on 4/22/13.
//  Copyright (c) 2013. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCKeyValueObjectMapping.h"

@class RepositoryOwner;

@interface Repository : NSObject

@property (nonatomic, copy) NSURL *cloneUrl;
@property (nonatomic, copy) NSDate *createdAt;
@property (nonatomic, copy) NSString *descriptionText;
@property (nonatomic, assign) BOOL fork;
@property (nonatomic, copy) NSString *fullName;
@property (nonatomic, copy) NSURL *gitUrl;
@property (nonatomic, copy) NSURL *homepage;
@property (nonatomic, copy) NSURL *htmlUrl;
@property (nonatomic, copy) NSNumber *repositoryId;
@property (nonatomic, copy) NSURL *mirrorUrl;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) RepositoryOwner *owner;
@property (nonatomic, assign) BOOL private;
@property (nonatomic, copy) NSDate *pushedAt;
@property (nonatomic, copy) NSURL *sshUrl;
@property (nonatomic, copy) NSDate *updatedAt;
@property (nonatomic, copy) NSURL *url;


+ (Repository *)instanceFromDictionary:(NSDictionary *)aDictionary;
+ (DCKeyValueObjectMapping *)mapper;
@end
