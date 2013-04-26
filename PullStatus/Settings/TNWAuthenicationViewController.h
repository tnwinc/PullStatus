//
//  TNWAuthenicationViewController.h
//  PullStatus
//
//  Created by Brendan Erwin on 4/24/13.
//  Copyright (c) 2013 The Network. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFOAuth2Client.h"

@interface TNWAuthenicationViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *userNameOrEmailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property AFOAuth2Client *httpClient;

- (IBAction)userDidPressAuthorize:(id)sender;

-(id) initWithNibName:(NSString *)nibNameOrNil andHttpClient:(AFOAuth2Client *)httpClient;
@end
