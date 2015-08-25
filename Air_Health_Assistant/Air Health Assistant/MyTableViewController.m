//
//  MyTableViewController.m
//  SearchController
//
//  Created by 曦炽 朱 on 14/10/27.
//  Copyright (c) 2014年 mirroon. All rights reserved.
//

#import "MyTableViewController.h"
#import "MyResultsViewController.h"
#import "HttpConnectionLogic.h"
#import "MMLocationManager.h"
#import "JPNetwork.h"


@interface MyTableViewController ()
@property (nonatomic, strong) NSMutableArray  *dataArray;
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) CLLocationManager* locationMgr;
@property (strong,nonatomic) NSMutableArray  *searchList;
@property (nonatomic,strong) NSString * locatedCityName;
@property (nonatomic,strong) NSString * locatedCityWoeid;
@property (nonatomic, retain) UISearchBar*mSearchBar;
@property (nonatomic,retain)XBody *xbody ;
@property BOOL isActive;
@end



@implementation MyTableViewController
@synthesize cityDelegate;
@synthesize body ;

@synthesize alter;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _isActive = false;
    
    if(alter ==nil ){
         alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"正在搜索城市，请稍后" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
    }
    
    
    self.extendedLayoutIncludesOpaqueBars = YES;
    
    // Init Data
    self.dataArray = [[NSMutableArray alloc] init];
    
    body = [XBody getInstance];
    
//    // Init Search
//    MyResultsViewController *resultsController = [[MyResultsViewController alloc]init];
//    
//    
//    self.searchController = [[UISearchController alloc] initWithSearchResultsController:resultsController];
//    
//    self.searchController.searchResultsUpdater = resultsController;
//    [self.searchController.searchBar sizeToFit];
//    self.tableView.tableHeaderView = self.searchController.searchBar;
//    self.definesPresentationContext = YES;
    
    
   
    //导航栏字体颜色，back按钮的颜色
    //[self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    //初始化搜索条
    self.xbody = [XBody getInstance];
    if( self.xbody .currentDeviceType == XDeviceTypeIPad) {
        self.mSearchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(20, 5, 295, 30)];
        self.mSearchBar.searchBarStyle = UISearchBarStyleDefault;
        self.mSearchBar.autocorrectionType = UITextAutocorrectionTypeNo;
        self.mSearchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
        self.mSearchBar.placeholder = @"搜索城市";
        self.mSearchBar.delegate = self;
        self.mSearchBar.showsCancelButton = false;
        self.mSearchBar.keyboardType=UIKeyboardTypePhonePad;
        [self.tableView beginUpdates];
        
        [self.tableView setTableHeaderView:self.mSearchBar];
        
        [self.tableView endUpdates];
    }
    else{
        
        _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
        
        _searchController.searchBar.delegate = self;
        
        _searchController.searchResultsUpdater = self;
        
        _searchController.dimsBackgroundDuringPresentation = NO;
        
        
        _searchController.hidesNavigationBarDuringPresentation = NO;
        
        [_searchController.searchBar sizeToFit];
        
        _searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
        
        [self.tableView beginUpdates];
        
        [self.tableView setTableHeaderView:_searchController.searchBar];
        
        [self.tableView endUpdates];
    }
 
    
    
    
    //self.tableView.tableHeaderView = self.searchController.searchBar;
   // self.definesPresentationContext = YES;
    //============Location =========
    
    

//    CLLocation *loc = [[CLLocation alloc]initWithLatitude:31 longitude: 134];
//                       
//    HttpConnectionLogic *httpConnectionLogic = [HttpConnectionLogic getInstance];
//    httpConnectionLogic.locateCity = self;
//    httpConnectionLogic.updateCitys = self;
//    
//    NSString * currentCity = [[XBody getInstance] currentCity] ;
//    if(currentCity != nil && ![currentCity isEqual:@""] ){
//           [self.dataArray addObject:currentCity];
//    }
//    else{
//        
//        [httpConnectionLogic getCityName:loc];
//      
//    }
    
    //self.presentingViewController.navigationItem.title = @"Search";
 
    self.title =@"Search For City";
    
    
    //==============================
    
   }


-(void) viewWillAppear:(BOOL)animated{
   
    BOOL reachability = [JPNetwork connectedToNetwork ];
    
    if(reachability == false){
        [JPNetwork networkBreak ];
    }
    else {
       [self startLocation]; 
    }
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
    
    //设置导航栏背景
    UIImage *image = [UIImage imageNamed:@"backTitle_iphone5_mask"];
    UIImage *stretchedImage = [image stretchableImageWithLeftCapWidth:10 topCapHeight:5];
    [self.navigationController.navigationBar setBackgroundImage:stretchedImage forBarMetrics:UIBarMetricsDefault];
    
    
    
    [super viewWillAppear:animated];
}

-(void) viewWillDisappear:(BOOL)animated{
    //设置导航栏背景
    UIImage *image = [UIImage imageNamed:@"backTitle_iphone5_mask"];
    UIImage *stretchedImage = [image stretchableImageWithLeftCapWidth:10 topCapHeight:5];
    [self.navigationController.navigationBar setBackgroundImage:stretchedImage forBarMetrics:UIBarMetricsDefault];
    [self setUnActive];
    
    if(self.locationMgr != nil){
        [self.locationMgr stopUpdatingLocation];
    }

    [super viewDidAppear:animated];
   
    
    
}

-(void)startLocation{
    
    if ([CLLocationManager locationServicesEnabled] == NO) {
        
        NSLog(@"没有GPS服务");
        
        self.locationMgr = nil;
        
        
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"警告" message:@"没有GPS服务,在设置中打开定位功能可以自动定位城市。" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        
        [alertView show];
        
        
        
        return;
        
    }

    
    
   
    if ([CLLocationManager locationServicesEnabled]&&[CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied) {
        
        self.locationMgr = [[CLLocationManager alloc] init];
        
       [self.locationMgr setDesiredAccuracy:kCLLocationAccuracyBest];
        
        self.locationMgr.delegate = self;
        
       // self.locationMgr.desiredAccuracy=kCLLocationAccuracyBestForNavigation;
      
        if (__IPHONE_8_0) {
           
            NSLog(@"IOS8 ");
          
            self.locationMgr.distanceFilter=10;
            
            if([self.locationMgr respondsToSelector:@selector(requestAlwaysAuthorization)]) {
                 [self.locationMgr requestAlwaysAuthorization];
            }
            
           
          
        }
      
        NSLog(@"start to locate ");
       
        [self.locationMgr startUpdatingLocation];
       
    }
   
}
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
   
    switch (status) {
          
        case kCLAuthorizationStatusNotDetermined:
           
            if ([self.locationMgr respondsToSelector:@selector(requestAlwaysAuthorization)]) {
               
                [self.locationMgr requestWhenInUseAuthorization];
            }
            break;
           
        default:
          
            break;
           
    }
 
}
#pragma mark - CLLocationManagerDelegate
// iso 6.0以上SDK版本使用，包括6.0。
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
    CLLocation *cl = [locations objectAtIndex:0];
    NSLog(@"纬度--%f",cl.coordinate.latitude);
    NSLog(@"经度--%f",cl.coordinate.longitude);
    
        CLLocation *loc = [[CLLocation alloc]initWithLatitude:cl.coordinate.latitude longitude: cl.coordinate.longitude];
    
        HttpConnectionLogic *httpConnectionLogic = [HttpConnectionLogic getInstance];
        httpConnectionLogic.locateCity = self;
        httpConnectionLogic.updateCitys = self;
    
//        NSString * currentCity = [[XBody getInstance] currentCity] ;
//        if(currentCity != nil && ![currentCity isEqual:@""] ){
//               [self.dataArray addObject:currentCity];
//        }
//        else{
    
            [httpConnectionLogic getCityName:loc];
          
//}
    
   
    
 
    
}
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    
   
    NSLog(@"纬度%f,经度%f",newLocation.coordinate.latitude,newLocation.coordinate.longitude);
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"纬度获取失败%@",error);
}


-(void)cityLocated:(NSString *)city cityCode:(NSString *)weiod{
     NSLog(@"Location city %@, code %@",city,weiod);
    
    _locatedCityName = [[NSString alloc] initWithString:city];
    _locatedCityWoeid =[[NSString alloc] initWithString:weiod];
    
    [_dataArray removeAllObjects];
    [_dataArray addObject:city];
    [self.tableView reloadData];

}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

-(void)searchDisplayController:(UISearchDisplayController *)controller willShowSearchResultsTableView:(UITableView *)tableView
{
    [self.tableView setContentInset:UIEdgeInsetsZero];
    [self.tableView setScrollIndicatorInsets:UIEdgeInsetsZero];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self isSearchBarActive]) {
        
        if(section == 0){
            return 1;
        }
        else{
            return [self.searchList count];
        }
        
    }else{
         return self.dataArray.count;
    }
   
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    if ([self isSearchBarActive]) {
        if(section == 0){
            return @"定位的城市";
        }
        else{
            return @"搜索城市";
        }
    }
    else{
        return @"定位城市";
    }
    
}
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.searchController.searchBar resignFirstResponder];
   
    return indexPath;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if ([self isSearchBarActive]) {
        return 2;
    }
    else{
        return 1;
    }
    
}
#pragma mark - UITableViewDataSource
- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if ([self isSearchBarActive]) {
        
        if(indexPath.section == 1){
            NSMutableDictionary * city = [body.cities objectAtIndex:indexPath.row];
            
            NSString* name = [city objectForKey:@"cityName"];
            
            NSString *woeid = [city objectForKey:@"woeid"];
            
            NSLog(@"cityName: %@ ,woeid: %@",name,woeid);
            
            
            [XBody getInstance].currentCityCode = woeid;
            [XBody getInstance].currentCity = name;
            [XBody getInstance].currentProvince =@"";
            [self.dataArray removeAllObjects];
            [self.dataArray addObject:name];
            
            [cityDelegate cityChanged];
        }
        else{
            
            [XBody getInstance].currentCityCode = [_locatedCityWoeid copy];
            [XBody getInstance].currentCity = [_locatedCityName copy];
            [XBody getInstance].currentProvince =@"";
            [self.dataArray removeAllObjects];
            
            
            [cityDelegate cityChanged];

        }
        // [self.searchController setActive:false];
        
       [self setUnActive];
       

    }
    else{
        [XBody getInstance].currentCityCode = [_locatedCityWoeid copy];
        [XBody getInstance].currentCity = [_locatedCityName copy];
        [XBody getInstance].currentProvince =@"";
        [self.dataArray removeAllObjects];
        
        
        [cityDelegate cityChanged];
        

        
        //[self.searchController.searchBar setShowsCancelButton:YES animated:YES];
    }
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
   
    
    //
    
   
}

//-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [self.searchController.searchBar setShowsCancelButton:YES animated:YES];
//}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if(cell ==nil){
         cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    // Configure the cell...
    
    if ([self isSearchBarActive]) {
        
        if(indexPath.section ==0){
            [cell.textLabel setText:self.dataArray[0]];
        }
        else{
            [cell.textLabel setText:self.searchList[indexPath.row]];
        }
    }
    else{
        cell.textLabel.text = self.dataArray[indexPath.row];
    }
    
    
    return cell;
}

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    NSString *searchString = [self.searchController.searchBar text];
    
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchString];
    
    if (self.searchList!= nil) {
        [self.searchList removeAllObjects];
    }
    //过滤数据
    self.searchList= [NSMutableArray arrayWithArray:[_dataArray filteredArrayUsingPredicate:preicate]];
    //刷新表格
    
    [self.tableView reloadData];
}


-(void) update{
    NSLog(@"UPDATE CITY");
    
    if(self.searchList == nil){
        self.searchList= [[NSMutableArray alloc] init];
    }
    
   
    if(body.cities != nil && body.cities.count >0){
        
        for(int i =0 ;i<body.cities.count;i++){
            
            NSMutableDictionary * city = [body.cities objectAtIndex:i];
            
            [ self.searchList addObject: [city objectForKey:@"cityName"]];
        }
        
        [self.tableView reloadData];
    }
    
    [alter dismissWithClickedButtonIndex:0 animated:true];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    NSLog(@"搜索Begin");
    
    
    
  
    return YES;
}


- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    
    
    
//    
    
    
    NSString *text = [self.searchController.searchBar text];
    
    if(text ==nil || [text isEqual:@""]){
        NSLog(@"搜索End empty");
        
        return  YES;
    }
    
    [alter show];
    
    
    HttpConnectionLogic *httpConnectionLogic = [HttpConnectionLogic getInstance];
    
    
    [httpConnectionLogic getCitys: text];
    
    NSLog(@"搜索End %@",text);
    
    return YES;
}



-(BOOL)isSearchBarActive{
    
   
    if( self.xbody .currentDeviceType != XDeviceTypeIPad) {
         return self.searchController.active;
    }
    else{
        return _isActive;
    }
//    if(self.searchController != nil){
//        return self.searchController.active;
//    }
//    else if(self.mSearchBar != nil){
//        if(self.searchList != nil && [self.searchList count] >0){
//            return true;
//        }
//    }
//    return false;
   
}
-(void)setActive:(BOOL)active{
    if( self.xbody .currentDeviceType != XDeviceTypeIPad){
        [self.searchController setActive: active];
    }
    else {
        [self.searchList removeAllObjects];
        _isActive = active;
    }
    [self.tableView reloadData];
    
}
//添加搜索框事件：
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    [searchBar setShowsCancelButton:YES animated:YES];
    [self setActive:true];
    NSLog(@"searchBarTextDidBeginEditing");
}
//添加Cancel事件：
- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar   //called when cancel button pressed
{
    NSLog(@"searchBarCancelButtonClicked");
    searchBar.text=@"";
    [searchBar setShowsCancelButton:NO animated:YES];
    [self setUnActive];
    [searchBar resignFirstResponder];
}

-(void)setUnActive{
    [self setActive:false];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar    // called when keyboard search button pressed
{
    
        NSString *text = [self.mSearchBar text];
    
        if(text ==nil || [text isEqual:@""]){
            NSLog(@"搜索End empty");
    
            return  ;
        }
    
        [alter show];
    
    
        HttpConnectionLogic *httpConnectionLogic = [HttpConnectionLogic getInstance];
    
    
        [httpConnectionLogic getCitys: text];
    
        NSLog(@"搜索End %@",text);
    
        [searchBar resignFirstResponder];
        [self setActive:true];
        [searchBar setShowsCancelButton:NO animated:YES];
        [searchBar resignFirstResponder];
    
    
}


@end
