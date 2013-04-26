//
//  TNWHttpClient.h
//  PullStatus
//
//  Created by Brendan Erwin on 4/26/13.
//  Copyright (c) 2013 The Network. All rights reserved.
//

#import "AFNetworking.h"


@interface TNWHttpClient : AFHTTPClient
+ (TNWHttpClient *)sharedClient;
- (id)initWithBaseURL:(NSURL *)url;
- (void) setAuthorizationHeaderWithBearerToken:(NSString *)token;
@property BOOL hasToken;
@end
