//
//  TNWAuthenicationViewController.h
//  PullStatus
//
//  Created by Brendan Erwin on 4/24/13.
//  Copyright (c) 2013 The Network. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"

@interface TNWAuthenicationViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *userNameOrEmailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property AFHTTPClient *httpClient;

- (IBAction)userDidPressAuthorize:(id)sender;

-(id) initWithNibName:(NSString *)nibNameOrNil andHttpClient:(AFHTTPClient *)httpClient;
@end
