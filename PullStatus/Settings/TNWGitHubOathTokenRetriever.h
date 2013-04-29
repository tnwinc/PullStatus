//
//  TNWGitHubOathTokenRetriever.h
//  PullStatus
//
//  Created by Brendan Erwin on 4/24/13.
//  Copyright (c) 2013 The Network. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TNWHttpClient.h"
#import "Constants.h"

@interface TNWGitHubOathTokenRetriever : NSObject

-(void) retrieveOAuthTokenForUser:(NSString *)aUser
                     withPassword:(NSString *)password
                        andClient:(TNWHttpClient *)client
                       success:(void (^)(NSString *token))success
                       failure:(void (^)(NSError *error))failure;

@end
