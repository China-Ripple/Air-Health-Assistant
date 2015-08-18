//
//  SettingViewController.m
//  Air Health Assistant
//
//  Created by xu da on 14-7-19.
//  Copyright (c) 2014年 xu da. All rights reserved.
//

#import "SettingViewController.h"
#import "XBody.h"
#import "MMLocationManager.h"
#import "LocalizedString.h"

@interface SettingViewController ()

@end

@implementation SettingViewController
@synthesize gpsSelection;
@synthesize gpslabel;
@synthesize autoConnLabel;

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
    NSLog(@"load gpsSwitch: %d",[XBody getInstance].gpsSwitch);
    if ([XBody getInstance].gpsSwitch) {
        [gpsSelection setSelectedSegmentIndex:1];
    }else{
        [gpsSelection setSelectedSegmentIndex:0];
    }
    
    LocalizedString *localizedString = [LocalizedString getInstance];
    
    gpslabel.text =localizedString.SETTING_GUIDE;
    autoConnLabel.text=localizedString.SETTING_AUTO_CONN;

}
-(void)viewWillAppear:(BOOL)animated
{
    LocalizedString * ls = [LocalizedString getInstance];
    self.navigationItem.title = ls.SETTING_VIEW_TITLE;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)gpsSelectionChanged:(id)sender
{
    NSLog(@"gpsSelectionChanged:%ld",(long)[gpsSelection selectedSegmentIndex]);
    //save value
    [XBody getInstance].gpsSwitch = [gpsSelection selectedSegmentIndex];
    NSUserDefaults *standard = [NSUserDefaults standardUserDefaults];
    [standard setObject:[NSString stringWithFormat:@"%d",[gpsSelection selectedSegmentIndex]] forKey:DATA_GPS_SWITCH];
    [standard synchronize];
    //turn on or off locationManager
    if ([gpsSelection selectedSegmentIndex] == 0) {
        [[MMLocationManager shareLocation]gpsLocateCity];
    }
}

@end
