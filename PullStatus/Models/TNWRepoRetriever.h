//
//  TNWRepoRetriever.h
//  PullStatus
//
//  Created by Brendan Erwin on 4/24/13.
//  Copyright (c) 2013 The Network. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TNWRepoRetriever : NSObject

@property NSArray *repositories;
@property NSURL *requestedURL;

-(NSURL*)URLWithUsername:aName;
-(void)loadRepositoriesForUser:(NSString *)aUser
                       success:(void (^)(NSArray *repositories))success
                       failure:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON))failure;

@end
