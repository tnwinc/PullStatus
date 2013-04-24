//
//  TNWViewController.m
//  PullStatus
//
//  Created by Brendan Erwin on 4/18/13.
//  Copyright (c) 2013 The Network. All rights reserved.
//

#import "TNWPullRequestViewController.h"
#import "SWRevealViewController.h"

@interface TNWPullRequestViewController () {
}

@end

@implementation TNWPullRequestViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    SWRevealViewController *revealController = self.revealViewController;
    [self.view addGestureRecognizer:revealController.panGestureRecognizer];
    [self.navigationController.view addGestureRecognizer:revealController.panGestureRecognizer];

    self.refreshControl = [[UIRefreshControl alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)settingsWasPressed:(id)sender {
    [self.revealViewController revealToggle:self];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"PRCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }

    cell.textLabel.text = @"test";
    cell.detailTextLabel.text = indexPath.description;

    return cell;
}

@end
