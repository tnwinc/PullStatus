//
//  TNWRepoRetriever.h
//  PullStatus
//
//  Created by Brendan Erwin on 4/24/13.
//  Copyright (c) 2013 The Network. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFOAuth2Client.h"

@interface TNWRepoRetriever : NSObject

@property NSArray *repositories;
@property NSURL *requestedURL;

-(NSURL*)URLWithUsername:aName;
-(void)loadRepositoriesForUser:(NSString *)aUser
                    withClient:(AFOAuth2Client *)client
                       success:(void (^)(NSArray *repositories))success
                       failure:(void (^)(NSError *error))failure;

@end
