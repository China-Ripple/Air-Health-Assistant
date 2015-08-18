//
//  OnlineStoreViewController.m
//  Air Health Assistant
//
//  Created by xu da on 14-5-16.
//  Copyright (c) 2014年 xu da. All rights reserved.
//

#import "OnlineStoreViewController.h"
#import "StoreItemCell.h"
#import "WindowManager.h"

@interface OnlineStoreViewController ()

@end

@implementation OnlineStoreViewController

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
    
  
	// Do any additional setup after loading the view.
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [button setBackgroundImage:[UIImage imageNamed:@"m_setting"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(settingButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = btn;
    
     /**
      *@zhongqihong
      **/
      LocalizedString *localizedString = [LocalizedString getInstance];
     self.navigationController.title=localizedString.PAGE_ONLINE_STORE;
     self.navigationItem.title =localizedString.PAGE_ONLINE_STORE;
    /*****/
}

-(void)settingButtonClicked
{
    [[WindowManager getInstance]showSettingView:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onlineStoreButtonClick:(id)sender
{
    NSLog(@"onlineStoreButtonClick");
}

-(void)viewWillAppear:(BOOL)animated
{
    [[self.tabBarController tabBar] setHidden:NO];
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:NAVIGATIONBAR_BACKGROUND] forBarMetrics:UIBarMetricsDefault];
    //[self.tabBarController.tabBar setBackgroundImage:[UIImage imageNamed:TABBAR_BACKGROUND]];
    //设置导航栏背景
    UIImage *image = [UIImage imageNamed:NAVIGATIONBAR_BACKGROUND];
    UIImage *stretchedImage = [image stretchableImageWithLeftCapWidth:10 topCapHeight:5];
    [self.navigationController.navigationBar setBackgroundImage:stretchedImage forBarMetrics:UIBarMetricsDefault];

}

#pragma mark -
#pragma mark Table Data Source Methods
// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //float scaleValue = [XAppProperties getProperties].scaleValue;
    static NSString *eaAccessoryCellIdentifier = @"eaAccessoryCellIdentifier";
    NSUInteger row = [indexPath row];
    StoreItemCell *cell = [theTableView dequeueReusableCellWithIdentifier:eaAccessoryCellIdentifier];
    if (cell == nil) {
        cell = [[StoreItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:eaAccessoryCellIdentifier];
        cell.frame = CGRectMake(0.0, 0.0, theTableView.frame.size.width, theTableView.rowHeight);
        cell.rowIndex = row;
        [cell initValue];
    }
    // cell操作
    @try {/*
           EAAccessory * eaa =[_accessoryList objectAtIndex:row];
           NSString *eaAccessoryName = [eaa name];
           NSString *protocolStrings = [NSString stringWithFormat:@"%@",[[eaa protocolStrings] objectAtIndex:0]];
           [[cell deviceName]setText: eaAccessoryName];
           [[cell deviceAddress]setText: protocolStrings];*/
        
    }
    @catch (NSException *exception) {
    }
    @finally {
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return STORE_TABLECELL_HIGHT;
}

//选择
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    @try {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.rongtai-china.com"]];

        /*
           NSUInteger row = [indexPath row];
           _selectedAccessory = [_accessoryList objectAtIndex:row];
           [deviceNameLabel setText:_selectedAccessory.name];
           [deviceDescription setText:[NSString stringWithFormat:@"%@",[[_selectedAccessory protocolStrings] objectAtIndex:0]]];*/
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    //NSLog(@"select%@",[deviceListArray objectAtIndex:row]);
    /*
     _selectedAccessory = [_accessoryList objectAtIndex:row];
     
     _protocolSelectionActionSheet = [[UIActionSheet alloc] initWithTitle:@"Select Protocol" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles: nil];
     NSArray *protocolStrings = [_selectedAccessory protocolStrings];
     for(NSString *protocolString in protocolStrings) {
     [_protocolSelectionActionSheet addButtonWithTitle:protocolString];
     }
     
     [_protocolSelectionActionSheet setCancelButtonIndex:[_protocolSelectionActionSheet addButtonWithTitle:@"Cancel"]];
     //[_protocolSelectionActionSheet showInView:[self tableView]];
     
     //[[self tableView] deselectRowAtIndexPath:indexPath animated:YES];
     */
}
-(BOOL)openSessionForAccessory{
    return false;
}
#pragma mark -
#pragma mark DeviceListTableCellDelegate
-(void)connectButtonClick:(id)sender index:(NSUInteger)rowIndex
{/*
  @try {
  @synchronized (mainController.connectLock){
  if (mainController.connectStep == CONNECT_STEP_NO_ATTEMPT) {
  mainController.connectStep = CONNECT_STEP_TRY_TO_CONNECT;
  if (_accessoryList != 0 && [_accessoryList count] > 0) {
  _selectedAccessory = [_accessoryList objectAtIndex:rowIndex];
  EADSessionController *sharedController = [EADSessionController sharedController];
  [sharedController setupControllerForAccessory:_selectedAccessory withProtocolString:[[_selectedAccessory protocolStrings] objectAtIndex:0]];
  if([self openSessionForAccessory]){
  [deviceNameLabel setText:_selectedAccessory.name];
  [deviceDescription setText:[NSString stringWithFormat:@"%@",[[_selectedAccessory protocolStrings] objectAtIndex:0]]];
  }
  }
  }
  }
  }
  @catch (NSException *exception) {
  }*/
}
#pragma StoreItemCellDelegate
-(void)itemClick:(id)sender index:(NSUInteger)rowIndex information:(NSString *)inf
{
}
@end
