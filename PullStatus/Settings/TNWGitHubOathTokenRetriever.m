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
                        andClient:(TNWHttpClient *)client
                          success:(void (^)(NSString *))success
                          failure:(void (^)(NSError *))failure {
    
    NSDictionary *params = @{ @"client_id": kClientID, @"client_secret": kClientSecret, @"scopes": @[@"repo"] };

    client.parameterEncoding = AFJSONParameterEncoding;
    [client setAuthorizationHeaderWithUsername:aUser password:password];
    [client postPath:@"/authorizations" parameters:params
      success:^(AFHTTPRequestOperation *operation, id responseObject) {

          NSMutableDictionary *response = (NSMutableDictionary *) responseObject;
          NSString *token = response[@"token"];
          [client setAuthorizationHeaderWithBearerToken:token];
          if (success) success(token);
          
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error while retrieving OAuth Token: %@", error);
        if (failure) failure(error);
    }];
}

@end
