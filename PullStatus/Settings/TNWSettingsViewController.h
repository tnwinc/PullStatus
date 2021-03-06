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
#import "AFNetworking.h"
#import "CCFScrollableTabView.h"

@interface TNWSettingsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, CCFScrollableTabViewDataSource, CCFScrollableTabViewDelegate>

@property (weak, nonatomic) IBOutlet CCFScrollableTabView *organizationMenu;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;
@property (weak, nonatomic) IBOutlet UITableView *repositoriesTableView;
@property (weak, nonatomic) IBOutlet UIButton *authenticationButton;

@property AFHTTPClient *httpClient;
@property TNWRepoRetriever *repoRetriever;

@property NSString *selectedOrganization;
@property NSArray *organizations;

- (IBAction)userPressedAuthenticationButton:(id)sender;

-(void) loadRepositories;

-(id) initWithNibName:(NSString *)nibNameOrNil andHttpClient:(AFHTTPClient *)httpClient;
@end
