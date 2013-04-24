//
//  TNWAppDelegate.h
//  PullStatus
//
//  Created by Brendan Erwin on 4/18/13.
//  Copyright (c) 2013 The Network. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"

#import "TNWSettingsViewController.h"

@interface TNWAppDelegate : UIResponder <UIApplicationDelegate, SWRevealViewControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property TNWSettingsViewController *settingsController;

-(void)setAppearance;

@end
