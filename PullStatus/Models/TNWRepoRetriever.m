//
//  TNWRepoRetriever.m
//  PullStatus
//
//  Created by Brendan Erwin on 4/24/13.
//  Copyright (c) 2013 The Network. All rights reserved.
//

#import "TNWRepoRetriever.h"
#import "Repository.h"

@implementation TNWRepoRetriever

- (void)loadRepositoriesWithClient:(AFHTTPClient *)client
                   forOrganization:(NSString *)organization
                           success:(void (^)(NSArray *repositories))success
                           failure:(void (^)(NSError *error))failure {
    assert(client);
    NSString *path;
    if (organization) {
        path = [NSString stringWithFormat:@"/orgs/%@/repos", organization];
    } else {
        path = @"user/repos";
    }

    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];

    [client getPath:path parameters:nil
            success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:NO];
        self.repositories = [Repository repoModelsFromJSON:responseObject];
        if (success) success(self.repositories);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:NO];
        NSLog(@"Error: loading repositories: %@", error);
        if (failure) failure(error);
    }];
}

@end
