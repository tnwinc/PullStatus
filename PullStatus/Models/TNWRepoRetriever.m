//
//  TNWRepoRetriever.m
//  PullStatus
//
//  Created by Brendan Erwin on 4/24/13.
//  Copyright (c) 2013 The Network. All rights reserved.
//

#import "TNWRepoRetriever.h"
#import "AFNetworking.h"
#import "Repository.h"

@implementation TNWRepoRetriever

- (NSURL *)URLWithUsername:(id)aName {
    NSString *url = [NSString stringWithFormat:@"https://api.github.com/users/%@/repos", aName];
    return [NSURL URLWithString:url];
}

- (void)loadRepositoriesForUser:(NSString *)aUser
                        success:(void (^)(NSArray *repositories))success
                        failure:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON))failure {
    self.requestedURL = [self URLWithUsername:aUser];

    NSURLRequest *request = [NSURLRequest requestWithURL:self.requestedURL];
    AFJSONRequestOperation *operation;
    operation = [AFJSONRequestOperation
                 JSONRequestOperationWithRequest:request

                                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        self.repositories = [Repository arrayOfInstancesFromArrayOfDictionaries:JSON];
        if (success) success(self.repositories);
    }

                                         failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"Error: loading repositories: %@", error);
        if (failure) failure(request, response, error, JSON);
    }];

    [operation start];
}

@end
