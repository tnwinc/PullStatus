//
//  TNWGitHubOathTokenRetriever.h
//  PullStatus
//
//  Created by Brendan Erwin on 4/24/13.
//  Copyright (c) 2013 The Network. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFOAuth2Client.h"



@interface TNWGitHubOathTokenRetriever : NSObject

-(void) retrieveOAuthTokenForUser:(NSString *)aUser
                     withPassword:(NSString *)password
                        andClient:(AFOAuth2Client *)client
                       success:(void (^)())success
                       failure:(void (^)(NSError *error))failure;

@end
