//
//  TNWSettingsViewController.h
//  PullStatus
//
//  Created by Brendan Erwin on 4/18/13.
//  Copyright (c) 2013 The Network. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "TNWRepoRetriever.h"

@interface TNWSettingsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;
@property (weak, nonatomic) IBOutlet UITableView *repositoriesTableView;
@property (weak, nonatomic) IBOutlet UIButton *authenticationButton;

@property TNWRepoRetriever *repoRetriever;

- (IBAction)userPressedAuthenticationButton:(id)sender;

-(void) loadRepositories;
@end
