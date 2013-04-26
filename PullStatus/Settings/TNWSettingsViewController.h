//
//  TNWSettingsViewController.h
//  PullStatus
//
//  Created by Brendan Erwin on 4/18/13.
//  Copyright (c) 2013 The Network. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "AFOAuth2Client.h"
#import "TNWRepoRetriever.h"

@interface TNWSettingsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;
@property (weak, nonatomic) IBOutlet UITableView *repositoriesTableView;
@property (weak, nonatomic) IBOutlet UIButton *authenticationButton;
@property AFOAuth2Client *httpClient;

@property TNWRepoRetriever *repoRetriever;

- (IBAction)userPressedAuthenticationButton:(id)sender;

-(void) loadRepositories;

-(id) initWithNibName:(NSString *)nibNameOrNil andHttpClient:(AFOAuth2Client *)httpClient;
@end
