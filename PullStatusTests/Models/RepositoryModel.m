//
//  RepositoryModel.m
//  PullStatus
//
//  Created by Brendan Erwin on 4/22/13.
//  Copyright 2013 The Network. All rights reserved.
//

#import "Kiwi.h"
#import "Repository.h"

SPEC_BEGIN(RepositoryModel)

describe(@"Repository Model", ^{
    describe(@"Load with JSON", ^{
        __block NSDictionary *sourceDictionary;
        __block Repository *cut;

        beforeEach (^{
            NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource:@"Repository" ofType:@"json"];
            sourceDictionary = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:path]
                                                               options:NSJSONReadingAllowFragments error:nil];
            cut = [Repository instanceFromDictionary:sourceDictionary];
        });


        it(@"should create the repository", ^{
            [cut shouldNotBeNil];
        });

        it(@"should get the values from the JSON", ^{
            [[cut.repositoryId should] equal:@1296269];
            [[cut.name should] equal:@"Hello-World"];
            [[cut.fullName should] equal:@"octocat/Hello-World"];
            [[cut.descriptionText should] equal:@"This your first repo!"];
            [[@(cut.private)should] equal:@(NO)];
            [[@(cut.fork)should] equal:@(NO)];
            [[cut.url should] equal:[NSURL URLWithString:@"https://api.github.com/repos/octocat/Hello-World"]];
            [[cut.htmlUrl should] equal:[NSURL URLWithString:@"https://github.com/octocat/Hello-World"]];
            [[cut.cloneUrl should] equal:[NSURL URLWithString:@"https://github.com/octocat/Hello-World.git"]];
            [[cut.gitUrl should] equal:[NSURL URLWithString:@"git://github.com/octocat/Hello-World.git"]];
            [[cut.sshUrl should] equal:[NSURL URLWithString:@"git@github.com:octocat/Hello-World.git"]];
            [[cut.mirrorUrl should] equal:[NSURL URLWithString:@"git://git.example.com/octocat/Hello-World"]];
            [[cut.homepage should] equal:[NSURL URLWithString:@"https://github.com"]];
            [[cut.createdAt should] equal:[[Repository dateFormatter] dateFromString:@"2011-01-26T19:01:12Z"]];
        });

        it(@"should really return URLs", ^{
            [[cut.url.class.description should] equal:@"NSURL"];
        });
    });
});
SPEC_END
