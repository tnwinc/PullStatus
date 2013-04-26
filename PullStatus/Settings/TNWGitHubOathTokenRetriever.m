//
//  TNWGitHubOathTokenRetriever.m
//  PullStatus
//
//  Created by Brendan Erwin on 4/24/13.
//  Copyright (c) 2013 The Network. All rights reserved.
//

#import "TNWGitHubOathTokenRetriever.h"

@implementation TNWGitHubOathTokenRetriever
- (void)retrieveOAuthTokenForUser:(NSString *)aUser
                     withPassword:(NSString *)password
                        andClient:(AFOAuth2Client *)client
                          success:(void (^)())success
                          failure:(void (^)(NSError *))failure {
    NSDictionary *params = @{ @"client_id": kClientID, @"client_secret": kClientSecret, @"scopes": @[@"repo"] };

    client.parameterEncoding = AFJSONParameterEncoding;
    [client clearAuthorizationHeader];
    [client setAuthorizationHeaderWithUsername:aUser password:password];
    [client authenticateUsingOAuthWithPath:@"/authorizations"
                                parameters:params
                                   success:^(AFOAuthCredential *credential) {
        [AFOAuthCredential storeCredential:credential
                            withIdentifier:client.serviceProviderIdentifier];

        [client setAuthorizationHeaderWithToken:credential.accessToken];
        if (success) success();
    } failure:^(NSError *error) {
        NSLog(@"Error while retrieving OAuth Token: %@", error);
        if (failure) failure(error);
    }];
}

@end
