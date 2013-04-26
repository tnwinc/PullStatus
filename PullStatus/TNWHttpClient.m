//
//  TNWHttpClient.m
//  PullStatus
//
//  Created by Brendan Erwin on 4/26/13.
//  Copyright (c) 2013 The Network. All rights reserved.
//

#import "TNWHttpClient.h"

@implementation TNWHttpClient

+ (TNWHttpClient *)sharedClient {
    static TNWHttpClient *_sharedClient = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        _sharedClient = [[TNWHttpClient alloc] initWithBaseURL:[NSURL URLWithString:@"https://api.github.com"]];
    });

    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }

    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [self setDefaultHeader:@"Accept" value:@"application/json"];
    self.parameterEncoding = AFJSONParameterEncoding;

    NSString *token = [[NSUserDefaults standardUserDefaults] stringForKey:@"oauth_token"];
    if (token) {
        [self setAuthorizationHeaderWithBearerToken:token];
    }

    return self;
}

-(void)setAuthorizationHeaderWithBearerToken:(NSString *)token{
    self.hasToken = YES;
    [[NSUserDefaults standardUserDefaults] setValue:token forKey:@"oauth_token"];
    [self setDefaultHeader:@"Authorization" value:[NSString stringWithFormat:@"Bearer %@", token]];
}
@end
