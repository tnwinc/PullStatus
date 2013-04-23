//
//  Rfc3339DateConverterSpec.m
//  PullStatus
//
//  Created by Brendan Erwin on 4/23/13.
//  Copyright 2013 The Network. All rights reserved.
//

#import "Kiwi.h"

#import "Rfc3339DateConverter.h"


SPEC_BEGIN(Rfc3339DateConverterSpec)

describe(@"RFC 3339 Date Converter", ^{
    Rfc3339DateConverter *cut = [[Rfc3339DateConverter alloc] init];
    
    describe(@"can transform value for class", ^{
        it(@"should want to transform dates", ^{
            [[@([cut canTransformValueForClass:[NSDate class]]) should] beTrue];
        });

        it(@"should not want to transform strings", ^{
            [[@([cut canTransformValueForClass:[NSString class]]) should] beFalse];
        });
    });

   describe(@"string to date", ^{
       __block NSDate *result;

       beforeEach(^{
           NSString *input = @"2011-01-26T19:06:43Z";
           result = [cut transformValue:input forDynamicAttribute:nil];
       });

       it(@"should create a date", ^{
           [[[result description] should] equal:@"2011-01-26 19:06:43 +0000"];
       });
   });

    describe(@"date to string", ^{
        __block NSString *result;

        beforeEach(^{
            NSDate *input = [cut transformValue:@"2011-01-26T19:06:43Z" forDynamicAttribute:nil];
            result = [cut serializeValue:input forDynamicAttribute:nil];
        });

        it(@"should serialize to string", ^{
            [[result should] equal:@"2011-01-26T19:06:43Z"];
        });
    });
});

SPEC_END


