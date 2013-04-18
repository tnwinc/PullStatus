//
//  TNWViewController.m
//  PullStatus
//
//  Created by Brendan Erwin on 4/18/13.
//  Copyright (c) 2013 The Network. All rights reserved.
//

#import "TNWViewController.h"
#import "NVSlideMenuController.h"

@interface TNWViewController () {
    BOOL isMenuOpen;
}

@end

@implementation TNWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    isMenuOpen = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)settingsDidPress:(id)sender {
    NSLog(@"Settings was pressed");
    if (isMenuOpen) [self.slideMenuController closeMenuAnimated:YES completion:nil];
    else [self.slideMenuController openMenuAnimated:YES completion:nil];
}

#pragma mark - Slide callbacks

- (void)viewDidSlideIn:(BOOL)animated inSlideMenuController:(NVSlideMenuController *)slideMenuController {
    isMenuOpen = NO;
    NSLog(@"Menu is closed %d", isMenuOpen);
}

- (void)viewDidSlideOut:(BOOL)animated inSlideMenuController:(NVSlideMenuController *)slideMenuController {
    isMenuOpen = YES;
    NSLog(@"Menu is open %d", isMenuOpen);
}

@end
