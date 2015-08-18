//
//  AirViewController.m
//  Air Health Assistant
//
//  Created by xu da on 14-5-4.
//  Copyright (c) 2014年 xu da. All rights reserved.
//

#import "AirViewController.h"
#import "MainTabViewController.h"

@interface AirViewController ()

@end

@implementation AirViewController
@synthesize mainTabViewController;

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
}
-(void)viewDidAppear:(BOOL)animated
{
    self.navigationItem.title = @"AirView";
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelButtonClick:(id)sender {
    NSLog(@"cancelButtonClick");
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)showAirViewButtonClick:(id)sender {
    NSLog(@"showAirViewButtonClick");
        //[[MainTabViewController sharedInstance] showState];
    
}
@end
