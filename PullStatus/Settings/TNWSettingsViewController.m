//
//  TNWSettingsViewController.m
//  PullStatus
//
//  Created by Brendan Erwin on 4/18/13.
//  Copyright (c) 2013 The Network. All rights reserved.
//

#import "TNWSettingsViewController.h"
#import "AFNetworking.h"
#import "Repository.h"

@interface TNWSettingsViewController ()
@property BOOL loadingRepositories;
- (void)setAppearance;
@end

@implementation TNWSettingsViewController

- (void)viewDidLoad {
    [[NSNotificationCenter defaultCenter] addObserverForName:@"SettingsShown"
                                                      object:nil
                                                       queue:nil
                                                  usingBlock:^(NSNotification *note) {
                                                      [self loadRepositories];
                                                  }];
    [self setAppearance];
}

#pragma mark - Load Data

- (void)loadRepositories {
    if (self.loadingRepositories) return;
    self.loadingRepositories = YES;
    self.repositories = [[NSMutableArray alloc] init];
    
    NSURL *url = [NSURL URLWithString:@"https://api.github.com/users/tnwinc/repos"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFJSONRequestOperation *operation;
    operation = [AFJSONRequestOperation
                 JSONRequestOperationWithRequest:request
                 
                 success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                     NSMutableArray *repos = self.repositories;
                     //TODO: This loop should be out of the controller
                     for (NSDictionary *item in JSON) {
                         [repos addObject:[Repository instanceFromDictionary:item]];
                     }
                     
                     self.loadingRepositories = NO;
                     [self.activityView stopAnimating];
                     [self.repositoriesTableView reloadData];
                     [[NSNotificationCenter defaultCenter] postNotificationName:@"RepositoriesLoaded" object:self];
                 }
                 
                 failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                     NSLog(@"Error: loading repositories: %@", error);
                     [[NSNotificationCenter defaultCenter] postNotificationName:@"RepositoriesFailedToLoad" object:error];
                 }];
    
    [self.activityView startAnimating];
    [operation start];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.repositories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"RCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];

        UIImage *cellBackground = [[UIImage imageNamed:@"repo-cell.png"] resizableImageWithCapInsets:UIEdgeInsetsZero];
        
        UIView *cellBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cellBackgroundView.backgroundColor = [UIColor colorWithPatternImage:cellBackground];
        cell.backgroundView = cellBackgroundView;
        
        UIView *cellSelectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cellSelectedBackgroundView.backgroundColor = [UIColor blackColor];
        cell.selectedBackgroundView = cellSelectedBackgroundView;
        
        cell.textLabel.textColor = [UIColor whiteColor];
    }
    
    Repository *repo = [self.repositories objectAtIndex:indexPath.item];
    assert(repo);
    
    cell.textLabel.text = repo.name;
    cell.detailTextLabel.text = repo.descriptionText;
    
    assert(cell);
    return cell;
}

#pragma mark - Appearance

- (void)setAppearance {
    UIImage *barButton = [[UIImage imageNamed:@"barButton.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 14, 0, 5)];
    [self.authenticationButton setBackgroundImage:barButton forState:UIControlStateNormal];
}

@end
