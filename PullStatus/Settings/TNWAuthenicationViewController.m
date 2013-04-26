//
//  TNWAuthenicationViewController.m
//  PullStatus
//
//  Created by Brendan Erwin on 4/24/13.
//  Copyright (c) 2013 The Network. All rights reserved.
//

#import "TNWAuthenicationViewController.h"
#import "TNWGitHubOathTokenRetriever.h"
#import "SVProgressHUD.h"

@interface TNWAuthenicationViewController ()

@end

@implementation TNWAuthenicationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil andHttpClient:(AFHTTPClient *)httpClient
{
    self = [super initWithNibName:nibNameOrNil bundle:nil];
    if (self) {
        self.httpClient = httpClient;
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
                               andClient:self.httpClient
                                 success:^(NSString *token){
                                     [SVProgressHUD showSuccessWithStatus:@"Authenticated"];
                                     [self dismissViewControllerAnimated:YES completion:nil];
                                 } failure:^(NSError *error) {
                                     [SVProgressHUD showErrorWithStatus:@"Login Failed"];
                                 }];
}
@end
