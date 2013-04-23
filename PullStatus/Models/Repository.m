//
//  Repository.m
//
//
//  Created by Brendan Erwin on 4/22/13.
//  Copyright (c) 2013. All rights reserved.
//

#import "DCParserConfiguration.h"
#import "DCObjectMapping.h"
#import "Rfc3339DateConverter.h"
#import "RepositoryOwner.h"
#import "Repository.h"

@implementation Repository

+ (DCKeyValueObjectMapping *)mapper {
    static DCKeyValueObjectMapping *mapper;

    if (!mapper) {
        @synchronized(self) {
            if (!mapper) {

                Rfc3339DateConverter *rfc3339Converter = [[Rfc3339DateConverter alloc] init];
                assert(rfc3339Converter != nil);
                
                DCParserConfiguration *config = [DCParserConfiguration configuration];

                [config addObjectMapping:[DCObjectMapping mapKeyPath:@"id"
                                                         toAttribute:@"repositoryId"
                                                             onClass:self]];

                [config addObjectMapping:[DCObjectMapping mapKeyPath:@"description"
                                                         toAttribute:@"descriptionText"
                                                             onClass:self]];

                [config addObjectMapping:[DCObjectMapping mapKeyPath:@"pushed_at"
                                                         toAttribute:@"pushedAt"
                                                             onClass:self
                                                           converter:rfc3339Converter]];
                
                [config addObjectMapping:[DCObjectMapping mapKeyPath:@"created_at"
                                                         toAttribute:@"createdAt"
                                                             onClass:self
                                                           converter:rfc3339Converter]];

                [config addObjectMapping:[DCObjectMapping mapKeyPath:@"updated_at"
                                                         toAttribute:@"updatedAt"
                                                             onClass:self
                                                           converter:rfc3339Converter]];

                config.datePattern = @"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'";
                mapper = [DCKeyValueObjectMapping mapperForClass:self andConfiguration:config];
            }
        }
    }

    return mapper;
}

+ (Repository *)instanceFromDictionary:(NSDictionary *)aDictionary; {
    DCKeyValueObjectMapping *mapper = self.mapper;
    Repository *instance = [mapper parseDictionary:aDictionary];
    return instance;
}

@end
