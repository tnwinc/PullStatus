//
//  TNWGitHubOathTokenRetriever.m
//  PullStatus
//
//  Created by Brendan Erwin on 4/24/13.
//  Copyright (c) 2013 The Network. All rights reserved.
//

#import "TNWGitHubOathTokenRetriever.h"
#import "AFNetworking.h"
#import "AFOAuth2Client.h"

@implementation TNWGitHubOathTokenRetriever
- (void)retrieveOAuthTokenForUser:(NSString *)aUser
                     withPassword:(NSString *)password
                          success:(void (^)())success
                          failure:(void (^)(NSError *))failure {
    
    NSURL *url = [NSURL URLWithString:@"https://api.github.com"];
    AFOAuth2Client *oauthClient = [AFOAuth2Client clientWithBaseURL:url clientID:kClientID secret:kClientSecret];

    NSDictionary *params = @{ @"client_id": kClientID, @"client_secret": kClientSecret, @"scopes": @[@"repo"] };

    oauthClient.parameterEncoding = AFJSONParameterEncoding;
    [oauthClient clearAuthorizationHeader];
    [oauthClient setAuthorizationHeaderWithUsername:aUser password:password];
    [oauthClient authenticateUsingOAuthWithPath:@"/authorizations"
                                     parameters:params
                                        success:^(AFOAuthCredential *credential) {
        [AFOAuthCredential storeCredential:credential
                            withIdentifier:oauthClient.serviceProviderIdentifier];
        if (success) success();
    } failure:^(NSError *error) {
        NSLog(@"Error while retrieving OAuth Token: %@", error);
        if (failure) failure(error);
    }];
}

@end
