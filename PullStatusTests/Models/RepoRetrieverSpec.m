//
//  RepoRetrieverSpec.m
//  PullStatus
//
//  Created by Brendan Erwin on 4/24/13.
//  Copyright 2013 The Network. All rights reserved.
//

#import "Kiwi.h"
#import "TNWRepoRetriever.h"

SPEC_BEGIN(RepoRetrieverSpec)

    describe(@"Repository Retriever", ^{
        __block TNWRepoRetriever *cut;

        beforeEach(^{
            cut = [[TNWRepoRetriever alloc] init];
        });

        describe(@"URL Construction", ^{
            __block NSURL *url;

            beforeEach(^{
                url = [cut URLWithUsername:@"joe"];
            });

            it(@"should embed the username", ^{
                [[url.absoluteString should] matchPattern:@".joe."];
            });
        });
    });
SPEC_END


