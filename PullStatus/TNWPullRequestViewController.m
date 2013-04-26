//
//  TNWViewController.m
//  PullStatus
//
//  Created by Brendan Erwin on 4/18/13.
//  Copyright (c) 2013 The Network. All rights reserved.
//

#import "TNWPullRequestViewController.h"
#import "SVProgressHUD.h"
#import "TNWHttpClient.h"

@implementation TNWPullRequestViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshPullRequests) forControlEvents:UIControlEventValueChanged];

    self.httpClient = [TNWHttpClient sharedClient];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(repositorySelectedWithNotificationObject:) name:@"RepositorySelected" object:nil];
}

- (IBAction)settingsWasPressed:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SettingsRequested"
                                                        object:nil];
}

-(void)refreshPullRequests {
    [self refreshPullRequestsWithRepositoryPath:self.currentRepositoryPath];
}

-(void)refreshPullRequestsWithRepositoryPath:(NSString *)repositoryPath {
    NSString *path = [NSString stringWithFormat:@"%@/pulls", repositoryPath];
    [self.refreshControl beginRefreshing];

    void (^cleanUp)() = ^(){
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
    };

    [self.httpClient getPath:path parameters:nil
                     success:^(AFHTTPRequestOperation *operation, id responseObject) {
                         NSLog(@"Got Pull Requests: %@", responseObject);
                         self.pullRequests = responseObject;
                         cleanUp();

                     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                         [SVProgressHUD showErrorWithStatus:@"Failed to load pull requests."];
                         cleanUp();
                     }];
}

-(void)repositorySelectedWithNotificationObject:(NSNotification *)notificationObject{
    self.currentRepositoryPath = notificationObject.object;
    [self refreshPullRequestsWithRepositoryPath:self.currentRepositoryPath];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pullRequests.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"PRCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }

    NSInteger index = indexPath.item;
    NSDictionary *pullRequest = [self.pullRequests objectAtIndex:index];

    cell.textLabel.text = pullRequest[@"title"];
    cell.detailTextLabel.text = pullRequest[@"body"];

    return cell;
}

@end
