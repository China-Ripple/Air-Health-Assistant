//
//  UserRegisterViewController.m
//  Air Health Assistant
//
//  Created by xu da on 14-6-30.
//  Copyright (c) 2014年 xu da. All rights reserved.
//

#import "UserRegisterViewController.h"

@interface UserRegisterViewController ()

@end

@implementation UserRegisterViewController

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [[self.tabBarController tabBar] setHidden:YES];
}
@end
