//
//  UserInformationViewController.m
//  Air Health Assistant
//
//  Created by xu da on 14-5-16.
//  Copyright (c) 2014年 xu da. All rights reserved.
//

#import "UserInformationViewController.h"
#import "UserRegisterViewController.h"
#import "XBody.h"
#import "LocalizedString.h"
#import "WindowManager.h"

@interface UserInformationViewController ()

@end

@implementation UserInformationViewController

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
}

- (void)settingButtonClicked
{
    [[WindowManager getInstance]showSettingView:self];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self showLoginView];
}

- (void)showLoginView
{
    //如果未登录，弹出登录框
    if(![XBody getInstance].isLogined){
        [self.loginButton setHidden:NO];
        NSUserDefaults *standard = [NSUserDefaults standardUserDefaults];
        NSString *accountName = [standard objectForKey:ACCOUNT_NAME];
        NSString *accountPassword = [standard objectForKey:ACCOUNT_PASSWORD];
        
        //有账号，则自动登录
        if(accountName != nil && accountPassword != nil){
            //[self login];
        }
        LocalizedString * localizedString = [LocalizedString getInstance];
        
        //弹出框
        UIAlertView  *alert = [[UIAlertView alloc] initWithTitle:localizedString.TEXT_LOGIN message:nil delegate:self cancelButtonTitle:localizedString.T_CANCEL otherButtonTitles:localizedString.T_OK,nil];
        [alert setAlertViewStyle:UIAlertViewStyleLoginAndPasswordInput];
        //UITextField *accountTF = [alert textFieldAtIndex:0];
        UITextField *passwordTF = [alert textFieldAtIndex:1];
        passwordTF.keyboardType = UIKeyboardTypeASCIICapable;
        [alert show];
        NSLog(@"[XBody getInstance].isLogined:%d",[XBody getInstance].isLogined);
        
    }else{
        NSLog(@"loginButton setHidden:YES");
        [self.loginButton setHidden:YES];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [[self.tabBarController tabBar] setHidden:NO];
    //TODO [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:NAVIGATIONBAR_BACKGROUND] forBarMetrics:UIBarMetricsDefault];
    //[self.tabBarController.tabBar setBackgroundImage:[UIImage imageNamed:TABBAR_BACKGROUND]];

}

- (IBAction)userInformationButtonClick:(id)sender{
    NSLog(@"userInformationButtonClick");
    UserRegisterViewController *userRegisterViewController;
    if (userRegisterViewController == nil) {
        NSString *userRegisterViewNib = nil;
        //if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        userRegisterViewNib = @"UserRegisterViewController";
        //}else {
        //    userRegisterView = @"UserRegisterViewController";
        //}
        // Do any additional setup after loading the view from its nib.
        userRegisterViewController = [[UserRegisterViewController alloc] initWithNibName:userRegisterViewNib bundle:nil];
    }
    //隐藏tabbar
    [[self.tabBarController tabBar] setHidden:YES];
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:userRegisterViewController animated:YES];
}
- (IBAction)loginButtonClick:(id)sender{
    [self showLoginView];
}
@end
