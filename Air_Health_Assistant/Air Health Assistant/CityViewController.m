//
//  CityViewController.m
//  Air Health Assistant
//
//  Created by xu da on 14-5-21.
//  Copyright (c) 2014年 xu da. All rights reserved.
//

#import "CityViewController.h"
#import "XBody.h"
#import "CityViewTableCell.h"
#import "LocalizedString.h"
@interface CityViewController ()
@property (nonatomic, strong) NSArray *provinceArray;
@property (nonatomic, strong) NSArray *cityArray;
@property (nonatomic, strong) NSArray *titleArray;

@end

@implementation CityViewController

@synthesize cityDelegate;
@synthesize provinceDic;
@synthesize cityDic;
@synthesize frameView;
@synthesize imageFrameView;
@synthesize tableView;
@synthesize imageView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSString *path = [[NSBundle mainBundle] pathForResource:@"City" ofType:@"plist"];
    cityDic = [NSDictionary dictionaryWithContentsOfFile:path];
    NSString *path2 = [[NSBundle mainBundle] pathForResource:@"Province" ofType:@"plist"];
    provinceDic = [NSDictionary dictionaryWithContentsOfFile:path2];
    
    self.provinceArray = [cityDic allKeys];
    NSComparator cmptr = ^(id obj1, id obj2){
        if ([obj1 integerValue] > [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        
        if ([obj1 integerValue] < [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    };
    self.provinceArray = [self.provinceArray sortedArrayUsingComparator:cmptr];
    
    NSLog(@"provinceArray:%@",self.provinceArray);
    /*
    //------
    NSString *backGroundImage;
    XBody *xbody = [XBody getInstance];
    if (xbody.currentDeviceType == XDeviceTypeIPhone4) {
        backGroundImage = CITY_SELECT_TITLE_640x960;
    }else if(xbody.currentDeviceType == XDeviceTypeIPhone5) {
        backGroundImage = CITY_SELECT_TITLE_640x1136;
    }else if(xbody.currentDeviceType == XDeviceTypeIPad) {
        backGroundImage = CITY_SELECT_TITLE_1024x768;
    }
    [self.imageView setImage:[UIImage imageNamed:backGroundImage]];
    if (xbody.currentDeviceType == XDeviceTypeIPhone4) {
        [self.imageFrameView setFrame:CGRectMake(0, 0, 320, 64)];
    }else if(xbody.currentDeviceType == XDeviceTypeIPhone5) {
        [self.imageFrameView setFrame:CGRectMake(0, 0, 320, 64)];
    }else if(xbody.currentDeviceType == XDeviceTypeIPad) {
        [self.imageFrameView setFrame:CGRectMake(0, 0, IPAD_MAIN_WIDTH, 64)];
    }*/
    //设置导航栏背景
    UIImage *image = [UIImage imageNamed:NAVIGATIONBAR_BACKGROUND];
    UIImage *stretchedImage = [image stretchableImageWithLeftCapWidth:10 topCapHeight:5];
    [self.navigationController.navigationBar setBackgroundImage:stretchedImage forBarMetrics:UIBarMetricsDefault];
    //导航栏字体颜色，back按钮的颜色
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];

}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	// this UIViewController is about to re-appear, make sure we remove the current selection in our table view
	NSIndexPath *tableSelection = [self.tableView indexPathForSelectedRow];
	[self.tableView deselectRowAtIndexPath:tableSelection animated:NO];
    LocalizedString *localizedString = [LocalizedString getInstance];
    self.navigationItem.title = localizedString.PAGE_CITY_SELECT;
    [[self.tabBarController tabBar] setHidden:YES];
    /*
    //缩放
    XBody *xbody = [XBody getInstance];
    if (xbody.currentDeviceType == XDeviceTypeIPhone4) {
        [self.frameView setFrame:CGRectMake(0,IPHONE4_DETAIL_Y,320,IPHONE4_DETAIL_HEIGHT)];
    }else if(xbody.currentDeviceType == XDeviceTypeIPhone5) {
        [self.frameView setFrame:CGRectMake(0,IPHONE5_DETAIL_Y,320,IPHONE5_DETAIL_HEIGHT)];
    }else if(xbody.currentDeviceType == XDeviceTypeIPad) {
        [self.frameView setFrame:CGRectMake(IPAD_DETAIL_X,IPAD_DETAIL_Y,IPAD_DETAIL_WIDTH,IPAD_DETAIL_HEIGHT)];
    }*/
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	CityViewTableCell *cell = (CityViewTableCell*)[theTableView cellForRowAtIndexPath:indexPath];
    /*
    NSString *path = [[NSBundle mainBundle] pathForResource:@"CityCode" ofType:@"strings"];
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:path];
    NSString *theCityCode = [self.dataArray objectAtIndex:indexPath.row];
	*/
    [XBody getInstance].currentCityCode = cell.cityCode;
    [XBody getInstance].currentCity = cell.textLabel.text;
    NSString *province = [self.provinceArray objectAtIndex:indexPath.section];
    [XBody getInstance].currentProvince = [provinceDic objectForKey:province];
    [cityDelegate cityChanged];
	[self.navigationController popToRootViewControllerAnimated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
     static NSString *eaAccessoryCellIdentifier = @"eaAccessoryCellIdentifier";
     NSUInteger row = [indexPath row];
     DeviceListTableCell *cell = [theTableView dequeueReusableCellWithIdentifier:eaAccessoryCellIdentifier];
     if (cell == nil) {
     cell = [[DeviceListTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:eaAccessoryCellIdentifier];
     cell.frame = CGRectMake(0.0, 0.0, theTableView.frame.size.width, theTableView.rowHeight);
     [cell initValue];
     }
     // cell操作
     cell.rowIndex = row;
     */
    //CityViewTableCell
	static NSString *kCellID = @"cellID";
	
	CityViewTableCell *cell = [theTableView dequeueReusableCellWithIdentifier:kCellID];
	if (cell == nil)
	{
		cell = [[CityViewTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellID];
		cell.accessoryType = UITableViewCellAccessoryNone;
		cell.selectionStyle = UITableViewCellSelectionStyleBlue;
	}
    NSString *province = [self.provinceArray objectAtIndex:indexPath.section];
    NSDictionary *thisProvinceDic = [cityDic objectForKey:province];
    NSArray *cityInThisProvinceArray = [thisProvinceDic allKeys];

    NSComparator cmptr = ^(id obj1, id obj2){
        if ([obj1 integerValue] > [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        
        if ([obj1 integerValue] < [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    };
    cityInThisProvinceArray = [cityInThisProvinceArray sortedArrayUsingComparator:cmptr];

    NSString *theCityCode = [cityInThisProvinceArray objectAtIndex:indexPath.row];
	cell.textLabel.text = [thisProvinceDic objectForKey:theCityCode];
    cell.cityCode = theCityCode;
	
	return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *province = [self.provinceArray objectAtIndex:section];
    NSDictionary *thisProvinceDic = [cityDic objectForKey:province];
	return [[thisProvinceDic allKeys]count];
}

//分组
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.provinceArray count];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    NSMutableArray *theTitleArray = [[NSMutableArray alloc]init];
    for (int i = 0; i < [self.provinceArray count]; i++) {
        NSString *province = [provinceDic objectForKey:[self.provinceArray objectAtIndex:i]];
        [theTitleArray addObject:province];
    }
    self.titleArray = theTitleArray;
    return self.titleArray;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *provinceCode = [self.provinceArray objectAtIndex:section];
    return [provinceDic objectForKey:provinceCode];
}

/*
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setTitle:@"SS" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    //btn.frame=CGRectMake(0, 0, 320, 80);
    btn.tag=section;
    return btn;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    NSLog(@"heightForHeaderInSection-->%zi",section);
    return 80;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"heightForRowAtIndexPath--->seciont-%zi--row---%zi",indexPath.section,indexPath.row);
    return 80;
}
*/
@end
