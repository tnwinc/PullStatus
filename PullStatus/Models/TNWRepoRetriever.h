//
//  TNWRepoRetriever.h
//  PullStatus
//
//  Created by Brendan Erwin on 4/24/13.
//  Copyright (c) 2013 The Network. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface TNWRepoRetriever : NSObject

@property NSArray *repositories;
@property NSURL *requestedURL;

-(void)loadRepositoriesWithClient:(AFHTTPClient *)client
                       success:(void (^)(NSArray *repositories))success
                       failure:(void (^)(NSError *error))failure;

@end
