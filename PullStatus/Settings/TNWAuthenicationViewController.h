//
//  TNWAuthenicationViewController.h
//  PullStatus
//
//  Created by Brendan Erwin on 4/24/13.
//  Copyright (c) 2013 The Network. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"

@interface TNWAuthenicationViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *userNameOrEmailTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UIButton *authorizeButton;
@property AFHTTPClient *httpClient;

- (IBAction)userDidPressAuthorize:(id)sender;

-(id) initWithNibName:(NSString *)nibNameOrNil andHttpClient:(AFHTTPClient *)httpClient;
@end
