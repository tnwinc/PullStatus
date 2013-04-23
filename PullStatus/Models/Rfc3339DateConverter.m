//
//  Rfc3339DateConverter.m
//  PullStatus
//
//  Created by Brendan Erwin on 4/23/13.
//  Copyright (c) 2013 The Network. All rights reserved.
//

#import "Rfc3339DateConverter.h"

@implementation Rfc3339DateConverter

+(NSDateFormatter*)dateFormatter{
    static NSDateFormatter *formatter;

    if (!formatter) {
        @synchronized(self){
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

//to date
- (id)transformValue:(id)value forDynamicAttribute:(DCDynamicAttribute *)attribute {
    NSDateFormatter *formatter = [[self class] dateFormatter];
    return [formatter dateFromString:value];
}

//from date to string
- (id)serializeValue:(id)value forDynamicAttribute:(DCDynamicAttribute *)attribute {
    NSDateFormatter *formatter = [[self class] dateFormatter];
    return [formatter stringFromDate:value];
}

- (BOOL)canTransformValueForClass:(Class)class {
    return [class isSubclassOfClass:[NSDate class]];
}

@end
