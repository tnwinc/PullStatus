//
//  Repository.m
//
//
//  Created by Brendan Erwin on 4/23/13.
//  Copyright (c) 2013. All rights reserved.
//

#import "Repository.h"

#import "RepositoryOwner.h"

@implementation Repository

+ (NSDateFormatter *)dateFormatter {
    static NSDateFormatter *formatter;

    if (!formatter) {
        @synchronized(self) {
            if (!formatter) {
                formatter = [[NSDateFormatter alloc] init];
                assert(formatter != nil);

                NSLocale *enUSPOSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
                assert(enUSPOSIXLocale != nil);

                [formatter setLocale:enUSPOSIXLocale];
                [formatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
                [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
            }
        }
    }

    assert(formatter != nil);
    return formatter;
}

+ (NSArray *)arrayOfInstancesFromArrayOfDictionaries:(NSArray *)anArray{
    NSMutableArray *result = [[NSMutableArray alloc] init];

    for (NSDictionary *item in anArray) {
        [result addObject:[Repository instanceFromDictionary:item]];
    }

    return result;
}

+ (Repository *)instanceFromDictionary:(NSDictionary *)aDictionary; {
    Repository *instance = [[Repository alloc] init];
    [instance setAttributesFromDictionary:aDictionary];
    return instance;
}

- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary; {
    if (![aDictionary isKindOfClass:[NSDictionary class]]) {
        return;
    }

    [self setValuesForKeysWithDictionary:aDictionary];
}

- (void)setValue:(id)value forKey:(NSString *)key; {
    NSDateFormatter *formatter = [self class].dateFormatter;

    if ([key isEqualToString:@"owner"]) {
        if ([value isKindOfClass:[NSDictionary class]]) {
            self.owner = [RepositoryOwner instanceFromDictionary:value];
        }
    } else if ([key isEqualToString:@"clone_url"]) {
        self.cloneUrl = [NSURL URLWithString:value];
    } else if ([key isEqualToString:@"created_at"]) {
        self.createdAt = [formatter dateFromString:value];
    } else if ([key isEqualToString:@"git_url"]) {
        self.gitUrl = [NSURL URLWithString:value];
    } else if ([key isEqualToString:@"homepage"]) {
        self.homepage = [NSURL URLWithString:value];
    } else if ([key isEqualToString:@"html_url"]) {
        self.htmlUrl = [NSURL URLWithString:value];
    } else if ([key isEqualToString:@"mirror_url"]) {
        self.mirrorUrl = [NSURL URLWithString:value];
    } else if ([key isEqualToString:@"pushed_at"]) {
        self.pushedAt = [formatter dateFromString:value];
    } else if ([key isEqualToString:@"ssh_url"]) {
        self.sshUrl = [NSURL URLWithString:value];
    } else if ([key isEqualToString:@"updated_at"]) {
        self.updatedAt = [formatter dateFromString:value];
    } else if ([key isEqualToString:@"url"]) {
        self.url = [NSURL URLWithString:value];
    } else {
        [super setValue:value forKey:key];
    }
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key; {
    if ([key isEqualToString:@"clone_url"]) {
        [self setValue:value forKey:@"cloneUrl"];
    } else if ([key isEqualToString:@"created_at"]) {
        [self setValue:value forKey:@"createdAt"];
    } else if ([key isEqualToString:@"description"]) {
        [self setValue:value forKey:@"descriptionText"];
    } else if ([key isEqualToString:@"full_name"]) {
        [self setValue:value forKey:@"fullName"];
    } else if ([key isEqualToString:@"git_url"]) {
        [self setValue:value forKey:@"gitUrl"];
    } else if ([key isEqualToString:@"html_url"]) {
        [self setValue:value forKey:@"htmlUrl"];
    } else if ([key isEqualToString:@"id"]) {
        [self setValue:value forKey:@"repositoryId"];
    } else if ([key isEqualToString:@"mirror_url"]) {
        [self setValue:value forKey:@"mirrorUrl"];
    } else if ([key isEqualToString:@"pushed_at"]) {
        [self setValue:value forKey:@"pushedAt"];
    } else if ([key isEqualToString:@"ssh_url"]) {
        [self setValue:value forKey:@"sshUrl"];
    } else if ([key isEqualToString:@"updated_at"]) {
        [self setValue:value forKey:@"updatedAt"];
    } else {
        if ([super respondsToSelector:@selector(key)]) {
            [super setValue:value forUndefinedKey:key];
        }
    }
}


@end
