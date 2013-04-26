//
//  TNWGitHubOathTokenRetriever.h
//  PullStatus
//
//  Created by Brendan Erwin on 4/24/13.
//  Copyright (c) 2013 The Network. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFOAuth2Client.h"

static NSString *const kClientID = @"afc2d14f7ed691a50027";
static NSString *const kClientSecret = @"3de36cf4f344f9aadd985bd0f31d01d1ee2d29b5";

@interface TNWGitHubOathTokenRetriever : NSObject

-(void) retrieveOAuthTokenForUser:(NSString *)aUser
                     withPassword:(NSString *)password
                        andClient:(AFOAuth2Client *)client
                       success:(void (^)())success
                       failure:(void (^)(NSError *error))failure;

@end
