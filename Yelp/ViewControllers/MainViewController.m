//
//  MainViewController.m
//  Yelp
//
//  Created by Milan Amin on 6/19/14.
//  Copyright (c) 2014 Milan Amin. All rights reserved.
//

#import "MainViewController.h"
#import "FilterOption.h"
#import <MBProgressHUD.h>


static NSString *cellIdentifier = @"YelpTableViewCell";

@interface MainViewController ()

@property (nonatomic, strong) NSArray * businesses;
@property (nonatomic, strong) YelpClient *client;
@property (nonatomic, strong) CLLocationManager * locationManager;
@property (nonatomic, strong) CLLocation * currLocation;

@property (nonatomic, strong) UISearchBar * searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) YelpTableViewCell * prototypeCell;

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _businesses = nil;
        
        _client = [[YelpClient alloc] init];
        
        // setup location manager
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.distanceFilter = kCLDistanceFilterNone;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [_locationManager startUpdatingLocation];
        
        _currLocation = nil;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // setup table view
    UINib *tableCellNib = [UINib nibWithNibName:cellIdentifier bundle:nil];
    [_tableView registerNib:tableCellNib forCellReuseIdentifier:cellIdentifier];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _prototypeCell = [_tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    // setup search bar and navigation bar
    _searchBar = [[UISearchBar alloc] init];
    _searchBar.delegate = self;
    _searchBar.text= @"Thai";
    [self performSearchWithTerm:@"Thai"];

    self.navigationItem.titleView = _searchBar;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Filter"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(filterButtonHandler:)];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    _currLocation = [locations lastObject];
}

#pragma mark - UISearchBarDelegate

// helper
- (void)performSearchWithTerm:(NSString *)term {
    FilterOption * options = [[FilterOption alloc] init];
    options.term = term;

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.client searchWithFilterOption:options success:^(AFHTTPRequestOperation *operation, id response) {
        _businesses = [Business businessesWithData:response];
        [_tableView reloadData];

        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:[error localizedDescription]
                                                       message:[error localizedRecoverySuggestion]
                                                      delegate:self
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil];
        [alert show];
    }];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    NSString * term = _searchBar.text;
    [self performSearchWithTerm:term];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_businesses count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YelpTableViewCell * cell = [_tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.business = [_businesses objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 99;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    _prototypeCell.business = [_businesses objectAtIndex:indexPath.row];
    [_prototypeCell layoutSubviews];
    CGSize size = [_prototypeCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height+1;
}

#pragma mark - FiltersViewControllerDelegate

- (void)searchWithFilterOption:(FilterOption *)filterOption {
    _searchBar.text = filterOption.term;
    [self.client searchWithFilterOption:filterOption success:^(AFHTTPRequestOperation *operation, id response) {
        _businesses = [Business businessesWithData:response];
        [_tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:[error localizedDescription]
                                                       message:[error localizedRecoverySuggestion]
                                                      delegate:self
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil];
        [alert show];
    }];
}

#pragma mark - button handlers

- (void)filterButtonHandler:(id)sender {
    FiltersViewController *filtersController = [[FiltersViewController alloc] init];
    filtersController.filterOption.term = _searchBar.text;
    filtersController.delegate = self;
    [[self navigationController] pushViewController:filtersController animated:YES];
    [self.navigationController.view clipsToBounds];
}

@end
