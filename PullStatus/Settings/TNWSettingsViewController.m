//
//  TNWSettingsViewController.m
//  PullStatus
//
//  Created by Brendan Erwin on 4/18/13.
//  Copyright (c) 2013 The Network. All rights reserved.
//

#import "TNWSettingsViewController.h"
#import "Repository.h"

@interface TNWSettingsViewController ()
@property NSArray *organizations;
@property BOOL loadingRepositories;
- (void)setAppearance;
@end

@implementation TNWSettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil andHttpClient:(AFHTTPClient *)httpClient {
    self = [super initWithNibName:nibNameOrNil bundle:nil];

    if (self) {
        assert(httpClient);
        self.httpClient = httpClient;
    }

    return self;
}

- (void)viewDidLoad {
    self.repoRetriever = [[TNWRepoRetriever alloc] init];

    [[NSNotificationCenter defaultCenter] addObserverForName:@"SettingsShown"
                                                      object:nil
                                                       queue:nil
      usingBlock:^(NSNotification *note) {
          [self loadRepositories];
    }];
    [self setAppearance];
}

#pragma mark - Load Data

- (IBAction)userPressedAuthenticationButton:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ReUpAuthentication" object:nil];
}

- (void)loadRepositories {
    if (self.loadingRepositories) return;
    assert(self.httpClient);
    
    [self.activityView startAnimating];

    assert(self.repoRetriever);
    [self.repoRetriever loadRepositoriesWithClient:self.httpClient
      success:^(NSArray *repositories) {
        self.loadingRepositories = NO;
        [self.activityView stopAnimating];
        [self.repositoriesTableView reloadData];
        [self.organizationMenu reloadInputViews];

        [[NSNotificationCenter defaultCenter] postNotificationName:@"RepositoriesLoaded" object:self];
    } failure:^(NSError *error) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"RepositoriesFailedToLoad" object:error];
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.repoRetriever.repositories.count;
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
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.textColor = [UIColor whiteColor];
    }

    Repository *repo = [self.repoRetriever.repositories objectAtIndex:indexPath.item];
    assert(repo);

    cell.textLabel.text = repo.name;
    cell.detailTextLabel.text = repo.descriptionText;

    assert(cell);
    return cell;
}

#pragma mark - org menu datasource

- (UIColor *)textColorInScrollableTabView:(CCFScrollableTabView *)tabView {
    return [UIColor whiteColor];
}

- (UIColor *)darkColorInScrollableTabView:(CCFScrollableTabView *)tabView {
    return [UIColor colorWithWhite:0.074 alpha:1.000];
}

- (UIColor *)lightColorInScrollableTabView:(CCFScrollableTabView *)tabView {
    return [UIColor colorWithRed:0.101 green:0.106 blue:0.118 alpha:1.000];
}

- (NSArray *)titlesInScrollableTabView:(CCFScrollableTabView *)tabView {
//    return self.organizations;
    return @[@"Mine",@"tnwinc",@"clearwavebuild",@"littlebits",@"guard",@"rhok-atl-find-my-volunteers",@"StudioNeldstrom"];
}

#pragma mark - Appearance

- (void)setAppearance {
    UIImage *barButton = [[UIImage imageNamed:@"github-button.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 34, 0, 5)];
    [self.authenticationButton setBackgroundImage:barButton forState:UIControlStateNormal];
}

@end
