//
//  TNWAppDelegate.m
//  PullStatus
//
//  Created by Brendan Erwin on 4/18/13.
//  Copyright (c) 2013 The Network. All rights reserved.
//

#import "TNWAppDelegate.h"

#import "TNWSettingsViewController.h"
#import "SWRevealViewController.h"
#import "TNWAuthenicationViewController.h"
#import "AFNetworking.h"

@implementation TNWAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    [self setAppearance];

    [self establishHttpClient];

    [self loadRootViewController];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(initiateAuthentication)
                                                 name:@"ReUpAuthentication"
                                               object:nil];

    

    [self.window makeKeyAndVisible];

    return YES;
}

-(void) establishHttpClient{
    NSURL *url = [NSURL URLWithString:@"https://api.github.com"];
    self.httpClient = [AFHTTPClient clientWithBaseURL:url];

    [self.httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [self.httpClient setDefaultHeader:@"Accept" value:@"application/json"];
}

- (void)loadRootViewController {
    TNWSettingsViewController *settingsView = [[TNWSettingsViewController alloc] initWithNibName:@"SettingsView" andHttpClient:self.httpClient];
    UIViewController *mainView = [[self storyboard] instantiateInitialViewController];

    self.settingsController = settingsView;

    SWRevealViewController *slideMenuController = [[SWRevealViewController alloc] initWithRearViewController:settingsView
                                                                                         frontViewController:mainView];
    [mainView.view addGestureRecognizer:slideMenuController.panGestureRecognizer];
    [mainView.navigationController.view addGestureRecognizer:slideMenuController.panGestureRecognizer];

    slideMenuController.delegate = self;
    self.window.rootViewController = slideMenuController;

    [[NSNotificationCenter defaultCenter] addObserverForName:@"SettingsRequested"
                                                      object:nil
                                                       queue:nil
                                                  usingBlock:^(NSNotification *note) {
        [slideMenuController revealToggle:mainView];
    }];
}

-(void) initiateAuthentication {
    TNWAuthenicationViewController *vc = [[TNWAuthenicationViewController alloc]initWithNibName:@"AuthenticateView" andHttpClient:self.httpClient];
    [self.window.rootViewController presentViewController:vc animated:YES completion:^{

    }];
}

- (UIStoryboard *)storyboard {
    return [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
}


- (void)setAppearance {
    UIImage *barButton = [[UIImage imageNamed:@"barButton.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 14, 0, 5)];
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil]
     setBackgroundImage:barButton
               forState:UIControlStateNormal
             barMetrics:UIBarMetricsDefault];

    UIImage *barButtonPressed = [[UIImage imageNamed:@"barButtonPressed.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 14, 0, 5)];
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil]
     setBackgroundImage:barButtonPressed
               forState:UIControlStateHighlighted
             barMetrics:UIBarMetricsDefault];

    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigationbar.png"] forBarMetrics:UIBarMetricsDefault];
}


#pragma mark - SWRevealViewControllerDelegate

- (void)revealController:(SWRevealViewController *)revealController didMoveToPosition:(FrontViewPosition)position {
    if (position == FrontViewPositionRight) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SettingsShown" object:self.settingsController];
    }
}

@end
