//
//  TNWAppDelegate.m
//  PullStatus
//
//  Created by Brendan Erwin on 4/18/13.
//  Copyright (c) 2013 The Network. All rights reserved.
//

#import "TNWAppDelegate.h"

#import "TNWSettingsViewController.h"
#import "PKRevealController.h"

@implementation TNWAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    [self setAppearance];

    [self loadRootViewController];

    [self.window makeKeyAndVisible];
    return YES;
}

- (void)loadRootViewController {
    UIViewController *settingsView = [[TNWSettingsViewController alloc] initWithNibName:@"SettingsView" bundle:nil];
    UIViewController *mainView = [[self storyboard] instantiateInitialViewController];


    PKRevealController *slideMenuController = [PKRevealController revealControllerWithFrontViewController:mainView
                                                                                       leftViewController:settingsView
                                                                                                  options:nil];
    self.window.rootViewController = slideMenuController;
}

- (UIStoryboard *)storyboard {
    return [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
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

@end
