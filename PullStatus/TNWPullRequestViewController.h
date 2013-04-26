//
//  TNWViewController.h
//  PullStatus
//
//  Created by Brendan Erwin on 4/18/13.
//  Copyright (c) 2013 The Network. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"

@interface TNWPullRequestViewController : UITableViewController

@property (nonatomic, strong) AFHTTPClient *httpClient;
@property NSArray *pullRequests;
@property NSMutableDictionary *statusReports;
@property NSString *currentRepositoryPath;

- (IBAction)settingsWasPressed:(id)sender;

@end
