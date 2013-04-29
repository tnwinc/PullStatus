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

    NSDictionary *params = @{ @"client_id": kGitHubApiClientID, @"client_secret": kGitHubApiClientSecret, @"scopes": @[@"repo"] };

    client.parameterEncoding = AFJSONParameterEncoding;
    [client setAuthorizationHeaderWithUsername:aUser password:password];

    void (^ setToken)(NSDictionary *) = ^(NSDictionary *item) {
        NSString *token = item[@"token"];
        [client setAuthorizationHeaderWithBearerToken:token];
        if (success) success(token);
    };

    void (^ getNewToken)(void) = ^{
        [client postPath:@"authorizations" parameters:params
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSMutableDictionary *response = (NSMutableDictionary *)responseObject;
            NSLog(@"Got new authorization");
            setToken(response);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error while retrieving OAuth Token: %@", error);
            if (failure) failure(error);
        }];
    };

    [client getPath:@"authorizations" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSPredicate *findOurApp = [NSPredicate predicateWithFormat:@"app.url == %@", @"https://github.com/tnwinc/PullStatus"];
        NSArray *authorizations = responseObject;
        authorizations = [authorizations filteredArrayUsingPredicate:findOurApp];

        if (authorizations.count > 0) {
            NSDictionary *entry = [authorizations lastObject];
            NSLog(@"Found existing authorization.");
            setToken(entry);
        } else {
            NSLog(@"No existing authorizations, getting a new one");
            getNewToken();
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error while checking for existing token: %@", error);
        getNewToken();
    }];
}

@end
