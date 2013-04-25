//
//  Repository.h
//
//
//  Created by Brendan Erwin on 4/23/13.
//  Copyright (c) 2013. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RepositoryOwner;

@interface Repository : NSObject

@property (nonatomic, strong) NSURL *cloneUrl;
@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, strong) NSString *descriptionText;
@property (nonatomic, assign) BOOL fork;
@property (nonatomic, strong) NSString *fullName;
@property (nonatomic, strong) NSURL *gitUrl;
@property (nonatomic, strong) NSURL *htmlUrl;
@property (nonatomic, strong) NSNumber *repositoryId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) RepositoryOwner *owner;
@property (nonatomic, assign) BOOL private;
@property (nonatomic, strong) NSDate *pushedAt;
@property (nonatomic, strong) NSURL *sshUrl;
@property (nonatomic, strong) NSDate *updatedAt;
@property (nonatomic, strong) NSURL *url;

+ (NSDateFormatter *)dateFormatter;
+ (NSArray *)getRepoModels:(NSArray *)reposJSON;

- (Repository *)initWithJSON:(NSDictionary *)JSON;

@end
