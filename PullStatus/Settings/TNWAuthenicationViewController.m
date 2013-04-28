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
- (void)setAppearance;
@end

@implementation TNWAuthenicationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil andHttpClient:(AFHTTPClient *)httpClient
{
    self = [super initWithNibName:nibNameOrNil bundle:nil];
    if (self) {
        _httpClient = httpClient;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setAppearance];
}

- (IBAction)userDidPressAuthorize:(id)sender {
    TNWGitHubOathTokenRetriever *retriever = [[TNWGitHubOathTokenRetriever alloc] init];

    [retriever retrieveOAuthTokenForUser:self.userNameOrEmailTextField.text
                            withPassword:self.passwordTextField.text
                               andClient:self.httpClient
                                 success:^(NSString *token){
                                     [[NSUserDefaults standardUserDefaults] setValue:token forKey:@"oauth_token"];
                                     [SVProgressHUD showSuccessWithStatus:@"Authenticated!"];
                                     [self dismissViewControllerAnimated:YES completion:nil];
                                 } failure:^(NSError *error) {
                                     [SVProgressHUD showErrorWithStatus:@"Login Failed."];
                                 }];
}

#pragma mark - UITextField Delegate Methods

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if (theTextField == self.userNameOrEmailTextField) {
        [self.passwordTextField becomeFirstResponder];
    } else if (theTextField == self.passwordTextField) {
        [self userDidPressAuthorize:theTextField];
    }
    return YES;
}

#pragma mark - Appearance

- (void)setAppearance {
    UIImage *barButton = [[UIImage imageNamed:@"github-dark-button.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 34, 0, 5)];
    [self.authorizeButton setBackgroundImage:barButton forState:UIControlStateNormal];
}

@end
