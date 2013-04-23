//
//  Rfc3339DateConverter.h
//  PullStatus
//
//  Created by Brendan Erwin on 4/23/13.
//  Copyright (c) 2013 The Network. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCValueConverter.h"

@interface Rfc3339DateConverter : NSObject <DCValueConverter>
+(NSDateFormatter*) dateFormatter;
@end
