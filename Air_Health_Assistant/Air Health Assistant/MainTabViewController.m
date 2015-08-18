//
//  MainTabViewController.m
//  Air Health Assistant
//
//  Created by xu da on 14-5-4.
//  Copyright (c) 2014年 xu da. All rights reserved.
//

#import "MainTabViewController.h"
#import "AirViewController.h"
#import "WeatherViewController.h"
#import "PMInformationViewController.h"
#import "LocalizedString.h"

// NSUserDefaults key values:
NSString *kWhichTabPrefKey		= @"kWhichTab";     // which tab to select at launch
NSString *kTabBarOrderPrefKey	= @"kTabBarOrder";  // the ordering of the tabs


#define kCustomizeTabBar        0   // compile time option to turn on or off custom tab bar appearance
#define kDefaultTabSelection    1	// default tab value is 0 (tab #1), stored in NSUserDefaults

@interface MainTabViewController ()

@end


@implementation MainTabViewController
 

/*
+ (MainTabViewController *) sharedInstance
{
    return self;
}*/

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}
-(void)viewDidAppear:(BOOL)animated
{
    //LocalizedString *localizedString = [LocalizedString getInstance];
    //self.navigationItem.title = localizedString.PAGE_MAIN;
}
- (void)viewDidLoad
{

    [super viewDidLoad];

    // Do any additional setup after loading the view from its nib.
    //
    //UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:self];
    //[navController setViewControllers:self];
    //主界面背景
    //[self.view setBackgroundColor:[XBody getInstance].backgroundColor];
    NSString *backGroundImage;
    XBody *xbody = [XBody getInstance];
    if (xbody.currentDeviceType == XDeviceTypeIPhone4) {
        backGroundImage = BACKGROUND_640x960;
    }else if(xbody.currentDeviceType == XDeviceTypeIPhone5) {
        backGroundImage = BACKGROUND_640x1136;
    }else if(xbody.currentDeviceType == XDeviceTypeIPad) {
        backGroundImage = BACKGROUND_1024x768;
    }
    UIImageView * imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:backGroundImage]];
    [imageView setFrame:[UIScreen mainScreen].bounds];
    [imageView setAutoresizesSubviews:YES];
    [self.view addSubview:imageView];
    [self.view sendSubviewToBack:imageView];

    /*
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [button setBackgroundImage:[UIImage imageNamed:@"m_setting"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(settingButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithCustomView:button];

    self.navigationItem.rightBarButtonItem = btn;*/
    [self.navigationItem setHidesBackButton:YES];
    /*
     UIBarButtonItem *aa = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"aa", @"")
     style:UIBarButtonItemStyleBordered
     target:self
     action:nil];
     UIBarButtonItem *bb = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"bb", @"")
     style:UIBarButtonItemStyleBordered
     target:self
     action:nil];
     //self.navigationController.toolbarItems = [NSArray arrayWithObjects:aa, bb, nil];
     
     UserViewController *userViewController = [[UserViewController alloc] initWithNibName:@"UserViewController_iPhone" bundle:nil];
     
     [self.xTabBarController addChildViewController:userViewController];
     */
    //self.navigationController.viewControllers
    //self.navigationController.toolbarItems
    
   // NSLog(@"viewControllers %d",[self.xTabBarController.viewControllers count]);
    
    // test for "kWhichTabPrefKey" key value
    NSUInteger testValue = [[NSUserDefaults standardUserDefaults] integerForKey:kWhichTabPrefKey];
	if (testValue == 0)
	{
		// no default source value has been set, create it here
		//
		// since no default values have been set (i.e. no preferences file created), create it here
		NSDictionary *appDefaults = [NSDictionary dictionaryWithObjectsAndKeys:
                                     [NSNumber numberWithInt:kDefaultTabSelection], kWhichTabPrefKey,
                                     nil];
		
		[[NSUserDefaults standardUserDefaults] registerDefaults:appDefaults];
	}
	
	// customize the More page's navigation bar color
	self.xTabBarController.moreNavigationController.navigationBar.tintColor = [UIColor grayColor];
    
	
#if kCustomizeTabBar
    // use the custom appearance feature found in iOS 5.0 or later by customizing the
    // appearance of our UITabBar.
    //
    
    
    
    self.myTabBarController.tabBar.tintColor = [UIColor darkGrayColor];
    self.myTabBarController.tabBar.selectedImageTintColor = [UIColor yellowColor];
    
    // note:
    // 1) you can also apply additional custom appearance to UITabBar using:
    // "backgroundImage" and "selectionIndicatorImage"
    // 2) you can also customize the appearance of individual UITabBarItems as well.
#endif
    
	// restore the tab-order from prefs
	NSArray *classNames = [[NSUserDefaults standardUserDefaults] arrayForKey:kTabBarOrderPrefKey];
	if (classNames.count > 0)
	{
		NSMutableArray *controllers = [[NSMutableArray alloc] init];
		for (NSString *className in classNames)
		{
			for (UIViewController* controller in self.xTabBarController.viewControllers)
			{
				NSString* controllerClassName = nil;
				
				if ([controller isKindOfClass:[UINavigationController class]])
				{
					controllerClassName = NSStringFromClass([[(UINavigationController*)controller topViewController] class]);
				}
				else
				{
					controllerClassName = NSStringFromClass([controller class]);
				}
				
				if ([className isEqualToString:controllerClassName])
				{
					[controllers addObject:controller];
					break;
				}
			}
		}
		
		if (controllers.count == self.xTabBarController.viewControllers.count)
		{
			self.xTabBarController.viewControllers = controllers;
		}
     
		
	}
    
   	
	// re-store previously selected tab from prefs
	//
	// if the More navigation controller was last selected, you must change the value of the "selectedViewController" property instead.
	if ([[NSUserDefaults standardUserDefaults] integerForKey:kWhichTabPrefKey] == NSNotFound)
	{
		self.xTabBarController.selectedViewController = self.xTabBarController.moreNavigationController;
	}
	else
	{
		self.xTabBarController.selectedIndex = [[NSUserDefaults standardUserDefaults] integerForKey:kWhichTabPrefKey];
	}
    //self.xTabBarController.selectedIndex = 2;
	// listen for changes in view controller from the More screen
	self.xTabBarController.moreNavigationController.delegate = self;
    
    // choose to make one of our view controllers ("FeaturedViewController"),
    // not movable/reorderable in More's edit screen
    //
    
    /*
     NSMutableArray *customizeableViewControllers = (NSMutableArray *)self.xTabBarController.viewControllers;
     for (UIViewController *viewController in customizeableViewControllers)
     {
     if ([viewController isKindOfClass:[FeaturedViewController class]])
     {
     [customizeableViewControllers removeObject:viewController];
     break;
     }
     }
     self.xTabBarController.customizableViewControllers = customizeableViewControllers;*/
    
    //NSLog(@"self.view backgroundColor: %@",[self.view backgroundColor]);
    
    //self.navigationController.tabBarItem.image = [UIImage imageNamed:@"tabbar_item.png"];
    
    
}

- (void)saveTabOrder
{
	// store the tab-order to preferences
	//
	NSMutableArray *classNames = [[NSMutableArray alloc] init];
	for (UIViewController *controller in self.xTabBarController.viewControllers)
	{
		if ([controller isKindOfClass:[UINavigationController class]])
		{
			UINavigationController *navController = (UINavigationController *)controller;
			
			[classNames addObject:NSStringFromClass([navController.topViewController class])];
		}
		else
		{
			[classNames addObject:NSStringFromClass([controller class])];
		}
	}
	
	[[NSUserDefaults standardUserDefaults] setObject:classNames forKey:kTabBarOrderPrefKey];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)AirViewButtonClick:(id)sender {
    AirViewController *airViewController;
    if (airViewController == nil) {
        NSString *airViewNib = nil;
        //if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            airViewNib = @"AirView_iPhone";
        //}else {
        //    airViewNib = @"AirView_iPad";
        //}
        // Do any additional setup after loading the view from its nib.
        airViewController = [[AirViewController alloc] initWithNibName:airViewNib bundle:nil];
        //[airViewController.view setFrame: CGRectMake(0, 0, self.view p0.frame.size.width, self.view.frame.size.height)];
        //[self.view addSubview:airViewController.view];
    }
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:airViewController animated:NO];
    //[self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)WeatherViewButtonClick:(id)sender {
    WeatherViewController *weatherViewController;
    if(weatherViewController == nil){
        NSString *weatherViewNib = nil;
        //if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            weatherViewNib = @"WeatherView_iPhone";
        //}else {
        //    weatherViewNib = @"WeatherView_iPad";
        //}
        // Do any additional setup after loading the view from its nib.
        weatherViewController = [[WeatherViewController alloc] initWithNibName:weatherViewNib bundle:nil];
        //[weatherViewController.view setFrame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        //[self.view addSubview:weatherViewController.view];
    }
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:weatherViewController animated:NO];
    //[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITabBarControllerDelegate

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
	// store the selected tab for next time:
	//		normally we can do this at "applicationDidTerminate", but this is a convenient spot
	// note: if the user has the "More" tab selected, then the value stored is "NSNotFound"
	//
	[[NSUserDefaults standardUserDefaults] setInteger:[tabBarController selectedIndex] forKey:kWhichTabPrefKey];
    LocalizedString *localizedString = [LocalizedString getInstance];

    switch ([tabBarController selectedIndex]) {
       /* case 0:
            self.navigationItem.title = localizedString.PAGE_ACCOUNT;
            break;*/
        case 0:
            self.navigationItem.title =localizedString.PAGE_HEALTH_TEST;
            break;
        case 1:
            self.navigationItem.title = localizedString.PAGE_MAIN;
            break;
        case 2:
            self.navigationItem.title = localizedString.PAGE_HEALTH_EXERCISE;
            break;
        case 3:
            self.navigationItem.title = localizedString.PAGE_ONLINE_STORE;
            break;
        default:
            self.navigationItem.title = @"more";
            break;
    }
    //[self showView];
}


#pragma mark - UINavigationControllerDelegate (More screen)

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
	if (viewController == [self.xTabBarController.moreNavigationController.viewControllers objectAtIndex:0])
	{
		// returned to the More page
        NSLog(@"returned to the More page");
	}
    NSLog(@"willShowViewController");
}

-(void)showState
{
    NSLog(@"showState");
    //[self showView];
}
/*
PMInformationViewController *pmInformationViewController;
-(void)showView
{
    if (pmInformationViewController == nil) {
        NSString *pmInformationViewNib = nil;
        //if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            pmInformationViewNib = @"PMInformationView";
        //}else {
        //    pmInformationViewNib = @"PMInformationView";
        //}
        // Do any additional setup after loading the view from its nib.
        pmInformationViewController = [[PMInformationViewController alloc] initWithNibName:pmInformationViewNib bundle:nil];
    }
    [self.navigationController pushViewController:pmInformationViewController animated:YES];
}
*/
//背景图不旋转
- (BOOL)shouldAutorotate
{
    return  NO;
}
-(void)settingButtonClicked
{
    NSLog(@"settingButtonClicked");
}

@end
