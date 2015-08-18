//
//  WindowManager.m
//  Air Health Assistant
//
//  Created by xu da on 14-7-19.
//  Copyright (c) 2014年 xu da. All rights reserved.
//

#import "WindowManager.h"

@implementation WindowManager
@synthesize mainViewController;
@synthesize weatherDetailViewController;
@synthesize pmInformationViewController;
@synthesize deviceViewController;
@synthesize informationViewController;
@synthesize testTableViewController;
@synthesize healthConsultantTableViewController;
@synthesize exerciseDetailViewController;
@synthesize exercise4DetailViewController;
@synthesize settingViewController;
@synthesize dustViewController;

+(WindowManager *)getInstance
{
    static WindowManager *instance;
    if (instance == nil) {
        instance = [[WindowManager alloc]init];
    }
    return instance;
}
-(void)initWithDelegate:(UIViewController<WeatherDelegate>*)viewController
{
    XBody *xbody = [XBody getInstance];
    self.mainViewController = viewController;
    if (dustViewController == nil) {
        NSString *dustViewNib = nil;
        if (xbody.currentDeviceType == XDeviceTypeIPhone4) {
            dustViewNib = @"DustView";
        }else if (xbody.currentDeviceType == XDeviceTypeIPhone5){
            dustViewNib = @"DustView_iphone5";
        }else{
            dustViewNib = @"DustView_ipad";
        }
        // Do any additional setup after loading the view from its nib.
        dustViewController = [[DustViewController alloc] initWithNibName:dustViewNib bundle:nil];
        [[HttpConnectionLogic getInstance] setPMDetailViewController:dustViewController];
    }
    if (pmInformationViewController == nil) {
        NSString *pmInformationViewNib = nil;
        if (xbody.currentDeviceType == XDeviceTypeIPhone4) {
            pmInformationViewNib = @"PMInformationView";
        }else if (xbody.currentDeviceType == XDeviceTypeIPhone5){
            pmInformationViewNib = @"PMInformationView_iphone5";
        }else{
            pmInformationViewNib = @"PMInformationView_ipad";
        }
        // Do any additional setup after loading the view from its nib.
        pmInformationViewController = [[PMInformationViewController alloc] initWithNibName:pmInformationViewNib bundle:nil];
        [[HttpConnectionLogic getInstance] setPMDetailViewController:pmInformationViewController];
    }
    if (weatherDetailViewController == nil) {
        //初始化天气详细界面，设定通知
        NSString *weatherViewNib = nil;
        if (xbody.currentDeviceType == XDeviceTypeIPhone4) {
            weatherViewNib = @"WeatherViewController";
        }else if (xbody.currentDeviceType == XDeviceTypeIPhone5){
            weatherViewNib = @"WeatherViewController_iphone5";
        }else{
            weatherViewNib = @"WeatherViewController_ipad";
        }
        weatherDetailViewController = [[WeatherViewController alloc] initWithNibName:weatherViewNib bundle:nil];
        //set delegate
        weatherDetailViewController.weatherDelegate = mainViewController;
    }
    if (informationViewController == nil) {
        NSString *informationViewNib = nil;
        if (xbody.currentDeviceType == XDeviceTypeIPhone4) {
            informationViewNib = @"InformationViewController";
        }else if (xbody.currentDeviceType == XDeviceTypeIPhone5){
            informationViewNib = @"InformationViewController_iphone5";
        }else{
            informationViewNib = @"InformationViewController_ipad";
        }
        informationViewController = [[InformationViewController alloc] initWithNibName:informationViewNib bundle:nil];
    }
    if (deviceViewController == nil) {
        NSString *deviceViewNib = nil;
        if (xbody.currentDeviceType == XDeviceTypeIPhone4) {
            deviceViewNib = @"DeviceViewController";
        }else if (xbody.currentDeviceType == XDeviceTypeIPhone5){
            deviceViewNib = @"DeviceViewController_iphone5";
        }else{
            deviceViewNib = @"DeviceViewController_ipad";
        }
        deviceViewController = [[DeviceViewController alloc] initWithNibName:deviceViewNib bundle:nil];
    }
    if (testTableViewController == nil) {
        NSString *testTableViewNib = nil;
        testTableViewNib = @"TestTextViewController";
        testTableViewController = [[TestTextViewController alloc] initWithNibName:testTableViewNib bundle:nil];
    }
    if (testTableViewController == nil) {
        NSString *testTableViewNib = nil;
        testTableViewNib = @"TestTextViewController";
        testTableViewController = [[TestTextViewController alloc] initWithNibName:testTableViewNib bundle:nil];
    }
    if (healthConsultantTableViewController == nil) {
        NSString *nibForController = nil;
        nibForController = @"HealthConsultantTableViewController";
        healthConsultantTableViewController = [[HealthConsultantTableViewController alloc] initWithNibName:nibForController bundle:nil];
    }
    if (exerciseDetailViewController == nil) {
        NSString *nibForController = nil;
        nibForController = @"ExerciseDetailViewController";
        exerciseDetailViewController = [[ExerciseDetailViewController alloc] initWithNibName:nibForController bundle:nil];
    }
    if (exercise4DetailViewController == nil) {
        NSString *nibForController = nil;
        nibForController = @"Exercise4DetailViewController";
        exercise4DetailViewController = [[Exercise4DetailViewController alloc] initWithNibName:nibForController bundle:nil];
    }
    if (testTableViewController == nil) {
        NSString *testTableViewNib = nil;
        testTableViewNib = @"TestTextViewController";
        testTableViewController = [[TestTextViewController alloc] initWithNibName:testTableViewNib bundle:nil];
    }
}
- (void)showPM25DetailView:(UIViewController*)theViewController
{
    //隐藏tabbar
    [[theViewController.tabBarController tabBar] setHidden:YES];
    // Pass the selected object to the new view controller.
    [theViewController.navigationController pushViewController:pmInformationViewController animated:YES];
}

- (void)showWeatherDetailView:(UIViewController*)theViewController
{
    [[theViewController.tabBarController tabBar] setHidden:YES];
    [theViewController.navigationController pushViewController:weatherDetailViewController animated:YES];
}

- (void)showInformationView:(UIViewController*)theViewController
{
    [[theViewController.tabBarController tabBar] setHidden:YES];
    [theViewController.navigationController pushViewController:informationViewController animated:YES];
    LocalizedString *localizedString = [LocalizedString getInstance];
    informationViewController.navigationItem.title = localizedString.PAGE_INFORMATION;
}

- (void)showDustView:(UIViewController*)theViewController
{
    [[theViewController.tabBarController tabBar] setHidden:YES];
    [theViewController.navigationController pushViewController:dustViewController animated:YES];
    LocalizedString *localizedString = [LocalizedString getInstance];
    dustViewController.navigationItem.title = localizedString.PAGE_DUST_DETAIL;
}

- (void)showDeviceView:(UIViewController*)theViewController
{
    [[theViewController.tabBarController tabBar] setHidden:YES];
    [theViewController.navigationController pushViewController:deviceViewController animated:YES];
    LocalizedString *localizedString = [LocalizedString getInstance];
    deviceViewController.navigationItem.title = localizedString.PAGE_DEVICE;
}

- (void)showHealthExamingView:(UIViewController*)theViewController
{
    [[theViewController.tabBarController tabBar] setHidden:YES];
    testTableViewController.detailArray = [XBody getInstance].healthDetailArray;
    [theViewController.navigationController pushViewController:testTableViewController animated:YES];
    LocalizedString *localizedString = [LocalizedString getInstance];
    testTableViewController.navigationItem.title = localizedString.PAGE_TEST1;
}
- (void)showHealthConsularView:(UIViewController*)theViewController
{
    [[theViewController.tabBarController tabBar] setHidden:YES];
    healthConsultantTableViewController.detailArray = [XBody getInstance].healthConsultantArray;
    [theViewController.navigationController pushViewController:healthConsultantTableViewController animated:YES];
    LocalizedString *localizedString = [LocalizedString getInstance];
    healthConsultantTableViewController.navigationItem.title = localizedString.PAGE_TEST2;
}
- (void)showHealthExamingByFingerView:(UIViewController*)theViewController
{
    [[theViewController.tabBarController tabBar] setHidden:YES];
    testTableViewController.detailArray = [XBody getInstance].healthByFingerDetailArray;
    [theViewController.navigationController pushViewController:testTableViewController animated:YES];
    LocalizedString *localizedString = [LocalizedString getInstance];
    testTableViewController.navigationItem.title = localizedString.PAGE_TEST3;
}
- (void)showFitnessExercise1:(UIViewController*)theViewController
{
    [[theViewController.tabBarController tabBar] setHidden:YES];
    exerciseDetailViewController.detailArray = [XBody getInstance].healthExercise1Array;
    [theViewController.navigationController pushViewController:exerciseDetailViewController animated:YES];
    LocalizedString *localizedString = [LocalizedString getInstance];
    exerciseDetailViewController.navigationItem.title = localizedString.PAGE_EXERCISE1;
}
- (void)showFitnessExercise2:(UIViewController*)theViewController
{
    [[theViewController.tabBarController tabBar] setHidden:YES];
    exerciseDetailViewController.detailArray = [XBody getInstance].healthExercise2Array;
    [theViewController.navigationController pushViewController:exerciseDetailViewController animated:YES];
    LocalizedString *localizedString = [LocalizedString getInstance];
    exerciseDetailViewController.navigationItem.title = localizedString.PAGE_EXERCISE2;
}
- (void)showFitnessExercise3:(UIViewController*)theViewController
{
    [[theViewController.tabBarController tabBar] setHidden:YES];
    exerciseDetailViewController.detailArray = [XBody getInstance].healthExercise3Array;
    [theViewController.navigationController pushViewController:exerciseDetailViewController animated:YES];
    LocalizedString *localizedString = [LocalizedString getInstance];
    exerciseDetailViewController.navigationItem.title = localizedString.PAGE_EXERCISE3;
}
- (void)showFitnessExercise4:(UIViewController*)theViewController
{
    [[theViewController.tabBarController tabBar] setHidden:YES];
    exercise4DetailViewController.detailArray = [XBody getInstance].healthExercise4Array;
    [theViewController.navigationController pushViewController:exercise4DetailViewController animated:YES];
    LocalizedString *localizedString = [LocalizedString getInstance];
    exercise4DetailViewController.navigationItem.title = localizedString.PAGE_EXERCISE4;
}
- (void)showFitnessExercise5:(UIViewController*)theViewController
{
    [[theViewController.tabBarController tabBar] setHidden:YES];
    testTableViewController.detailArray = [XBody getInstance].healthExercise5Array;
    [theViewController.navigationController pushViewController:testTableViewController animated:YES];
    LocalizedString *localizedString = [LocalizedString getInstance];
    testTableViewController.navigationItem.title = localizedString.PAGE_EXERCISE5;
    
}
- (void)showSettingView:(UIViewController*)theViewController
{
    if (settingViewController == nil) {
        NSString *settingViewNib = nil;
        settingViewNib = @"SettingViewController";
        settingViewController = [[SettingViewController alloc] initWithNibName:settingViewNib bundle:nil];
    }
    [[theViewController.tabBarController tabBar] setHidden:YES];
    [theViewController.navigationController pushViewController:settingViewController animated:YES];
    //设置导航栏背景
    UIImage *image = [UIImage imageNamed:NAVIGATIONBAR_BACKGROUND];
    UIImage *stretchedImage = [image stretchableImageWithLeftCapWidth:10 topCapHeight:5];
    [theViewController.navigationController.navigationBar setBackgroundImage:stretchedImage forBarMetrics:UIBarMetricsDefault];
    //导航栏字体颜色，back按钮的颜色
    [theViewController.navigationController.navigationBar setTintColor:[UIColor whiteColor]];

}
@end
