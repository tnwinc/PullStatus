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

@implementation TNWSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadRepositories];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Load Data

- (void)loadRepositories {
    self.repositories = [[NSMutableArray alloc] init];

    NSURL *url = [NSURL URLWithString:@"https://api.github.com/users/tnwinc/repos"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFJSONRequestOperation *operation;
    operation = [AFJSONRequestOperation
                 JSONRequestOperationWithRequest:request

                 success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                     NSMutableArray *repos = self.repositories;
                     for (NSDictionary *item in JSON) {
                         [repos addObject:[Repository instanceFromDictionary:item]];
                     }
                 }

                 failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                     NSLog(@"Error: loading repositories: %@", error);
                 }];

    [operation start];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.repositories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"RCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }

    Repository *repo = [self.repositories objectAtIndex:indexPath.item];
    assert(repo);

    cell.textLabel.text = repo.name;
    cell.detailTextLabel.text = repo.descriptionText;

    assert(cell);
    return cell;
}

@end
