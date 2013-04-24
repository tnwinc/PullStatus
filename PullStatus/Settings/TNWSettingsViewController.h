//
//  TNWSettingsViewController.h
//  PullStatus
//
//  Created by Brendan Erwin on 4/18/13.
//  Copyright (c) 2013 The Network. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"

@interface TNWSettingsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;
@property (weak, nonatomic) IBOutlet UIButton *authenticationButton;
@property (weak, nonatomic) IBOutlet UITableView *repositoriesTableView;
@property NSMutableArray *repositories;

-(void) loadRepositories;
@end
