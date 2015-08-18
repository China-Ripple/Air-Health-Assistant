//
//  MyResultsViewController.m
//  SearchController
//
//  Created by 曦炽 朱 on 14/10/27.
//  Copyright (c) 2014年 mirroon. All rights reserved.
//

#import "MyResultsViewController.h"

@interface MyResultsViewController ()
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *visableArray;
@property (nonatomic, strong) NSMutableArray *filterArray;
@property (nonatomic, strong) NSMutableArray *dataSourceArray;
@property (nonatomic, strong) UISearchController *mySearchController;
@end

@implementation MyResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
   // [self initial];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
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
    
    NSLog(@"Entering:%@",searchController.searchBar.text);
    
    NSString *filterString = searchController.searchBar.text;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains [c] %@", filterString];
    
    self.visableArray = [NSMutableArray arrayWithArray:[self.dataSourceArray filteredArrayUsingPredicate:predicate]];
    
    [self.myTableView reloadData];
}


//#pragma mark - UISearchResultsUpdating
//- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
//    
//    
//    NSLog(@"Entering:%@",searchController.searchBar.text);
//}
@end
