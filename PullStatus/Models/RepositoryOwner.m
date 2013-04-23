//
//  RepositoryOwner.m
//  
//
//  Created by Brendan Erwin on 4/22/13.
//  Copyright (c) 2013. All rights reserved.
//

#import "RepositoryOwner.h"

@implementation RepositoryOwner

+ (RepositoryOwner *)instanceFromDictionary:(NSDictionary *)aDictionary; {

    RepositoryOwner *instance = [[RepositoryOwner alloc] init];
    [instance setAttributesFromDictionary:aDictionary];
    return instance;

}

- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary; {

    if (![aDictionary isKindOfClass:[NSDictionary class]]) {
        return;
    }

    [self setValuesForKeysWithDictionary:aDictionary];

}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key; {

    if ([key isEqualToString:@"avatar_url"]) {
        [self setValue:value forKey:@"avatarUrl"];
    } else if ([key isEqualToString:@"gravatar_id"]) {
        [self setValue:value forKey:@"gravatarId"];
    } else if ([key isEqualToString:@"id"]) {
        [self setValue:value forKey:@"RepositoryOwnerId"];
    } else {
        if ([super respondsToSelector:@selector(key)]) {
            [super setValue:value forUndefinedKey:key];
        }
    }
}


@end
