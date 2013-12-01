//
//  BRBeersViewController.m
//  Brews
//
//  Created by Bradley Bergeron on 30/11/13.
//  Copyright (c) 2013 Bradley Bergeron. All rights reserved.
//

#import "BreweryDB.h"
#import "BRBeerCell.h"
#import "BRBeersViewController.h"


#pragma mark -
@interface BRBeersViewController ()

@property (nonatomic, strong) BRBeerCell *beerCell;

@property (nonatomic) NSSet *beers;
@property (nonatomic) NSArray *sortedBeers;

- (void)refreshBeers;

@end


#pragma mark -
@implementation BRBeersViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    UINib *beerCellNib = [UINib nibWithNibName:@"BRBeerCell" bundle:nil];
    [self.tableView registerNib:beerCellNib forCellReuseIdentifier:@"BRBeerCell"];
    [beerCellNib instantiateWithOwner:self.beerCell options:nil];

    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshBeers) forControlEvents:UIControlEventValueChanged];
}

#pragma mark Beers
- (void)refreshBeers
{
    [BreweryDB fetchBeersWithParameters:nil
                        withBreweryInfo:NO
                                success:^(NSArray *beers) {
                                    <#code#>
                                }
                                failure:^(NSError *error) {
                                    <#code#>
                                }];
}

#pragma mark UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BRBeerCell" forIndexPath:indexPath];
    
    return cell;
}

@end
