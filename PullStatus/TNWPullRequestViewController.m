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

    self.statusReports = [[NSMutableDictionary alloc] init];
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
    [self.statusReports removeAllObjects];
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

-(void)initiateStatusRequestForIndexPath:(NSIndexPath *)indexPath withSHA:(NSString *)sha {
    NSString *path = [NSString stringWithFormat:@"%@/statuses/%@",self.currentRepositoryPath, sha];

    [self.httpClient getPath:path parameters:nil
      success:^(AFHTTPRequestOperation *operation, id responseObject) {
          NSArray *statuses = responseObject;
          if (statuses.count > 0) {
              NSDictionary *status = [statuses objectAtIndex:0];
              NSLog(@"Got status for %@: %@", sha, status);

              [self.statusReports setValue:status forKey:[NSString stringWithFormat:@"%d", indexPath.item]];
              [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
          }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failed to load status for %@", sha);
    }];
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
    NSDictionary *status = self.statusReports[[NSString stringWithFormat:@"%d", index]];
    if (status) {
        cell.detailTextLabel.text = status[@"description"];
    } else {
        [self initiateStatusRequestForIndexPath:indexPath withSHA:pullRequest[@"head"][@"sha"]];
        cell.detailTextLabel.text = pullRequest[@"body"];
    }

    return cell;
}

@end
