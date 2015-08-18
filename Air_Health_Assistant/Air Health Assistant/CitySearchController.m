//
//  CitySearchController.m
//  Air Health Assistant
//
//  Created by 钟其鸿 on 15/7/30.
//  Copyright (c) 2015年 xu da. All rights reserved.
//

#import "CitySearchController.h"

@interface CitySearchController ()
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *visableArray;
@property (nonatomic, strong) NSMutableArray *filterArray;
@property (nonatomic, strong) NSMutableArray *dataSourceArray;
@property (nonatomic, strong) UISearchController *mySearchController;
@end

@implementation CitySearchController




- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    [self initial];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)initial{
    self.dataSourceArray = [NSMutableArray array];
    self.filterArray = [NSMutableArray array];
    for (int i = 0; i < 26; i++) {
        for (int j = 0; j < 4; j++) {
            NSString *str = [NSString stringWithFormat:@"%c%d", 'A'+i, j];
            [self.dataSourceArray addObject:str];
        }
    }
    
    self.visableArray = self.dataSourceArray;
    
    self.myTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    [self.view addSubview:_myTableView];
    
    self.mySearchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _mySearchController.searchResultsUpdater = self;
    _mySearchController.dimsBackgroundDuringPresentation = NO;
    [_mySearchController.searchBar sizeToFit];
    
    self.myTableView.tableHeaderView = self.mySearchController.searchBar;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (!_visableArray || _visableArray.count == 0) {
        _visableArray = _dataSourceArray;
    }
    return _visableArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifier"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"identifier"];
    }
    
    cell.textLabel.text = [_visableArray objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    NSString *filterString = searchController.searchBar.text;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains [c] %@", filterString];
    
    self.visableArray = [NSMutableArray arrayWithArray:[self.dataSourceArray filteredArrayUsingPredicate:predicate]];
    
    [self.myTableView reloadData];
}
@end
