//
//  TNWAuthenicationViewController.m
//  PullStatus
//
//  Created by Brendan Erwin on 4/24/13.
//  Copyright (c) 2013 The Network. All rights reserved.
//

#import "TNWAuthenicationViewController.h"
#import "TNWGitHubOathTokenRetriever.h"

@interface TNWAuthenicationViewController ()

@end

@implementation TNWAuthenicationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (IBAction)userDidPressAuthorize:(id)sender {
    TNWGitHubOathTokenRetriever *retriever = [[TNWGitHubOathTokenRetriever alloc] init];

    [retriever retrieveOAuthTokenForUser:self.userNameOrEmailTextField.text
                            withPassword:self.passwordTextField.text
                                 success:^{
                                     [self dismissViewControllerAnimated:YES completion:nil];
                                 } failure:^(NSError *error) {
                                         //TODO: display error
                                 }];
}
@end
