//
//  PastPatientVisitsViewController.m
//  EHRAfrica
//
//  Created by Alec Thimsen on 4/28/15.
//  Copyright (c) 2015 Alec Thimsen. All rights reserved.
//

#import "PastPatientVisitsViewController.h"

@interface PastPatientVisitsViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (weak, nonatomic) AppDelegate *appDelegate;

@property (strong, nonatomic) NSString *searchValue;

@property (strong, nonatomic) NSMutableArray *searchResults;
@end

@implementation PastPatientVisitsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bluetooth.png"]];
    
    _appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    _searchValue = @"";
    _searchResults = [[NSMutableArray alloc] init];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier"];
    NSString *name = [_searchResults objectAtIndex:indexPath.row];
    cell.textLabel.text = name;
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [_searchResults count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *selectedName = [_searchResults objectAtIndex:indexPath.row];
    Patient *patient = [_appDelegate.patientLookupByName objectForKey:[selectedName lowercaseString]];
    _appDelegate.currentPatient = patient;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0., 0., self.view.frame.size.width, 44.)];
    searchBar.keyboardAppearance = UIKeyboardAppearanceDark;
    searchBar.autocapitalizationType = UITextAutocapitalizationTypeWords;
    searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    searchBar.spellCheckingType = UITextSpellCheckingTypeNo;
    searchBar.keyboardType = UIKeyboardTypeASCIICapable;
    searchBar.delegate = self;
    return searchBar;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50.0f;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    _searchValue = [searchBar.text lowercaseString];
    Patient *patient = [_appDelegate.patientLookupByName objectForKey:_searchValue];
    if (patient != nil) {
        General *general = [patient valueForKey:@"general"];
        
        [_searchResults removeAllObjects];
        [_searchResults addObject:[general valueForKey:@"name"]];
        [_patientsTableView reloadData];
    }
}


@end
