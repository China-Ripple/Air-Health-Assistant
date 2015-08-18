//
//  HealthTestViewController.m
//  Air Health Assistant
//
//  Created by xu da on 14-5-16.
//  Copyright (c) 2014年 xu da. All rights reserved.
//

#import "HealthTestViewController.h"
#import "WindowManager.h"
#import "LocalizedString.h"
#import "SettingViewController.h"
@interface HealthTestViewController ()

@end

@implementation HealthTestViewController
@synthesize pageTest1;
@synthesize pageTest2;
@synthesize pageTest3;

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
    LocalizedString *localizedString = [LocalizedString getInstance];
    XBody *xbody = [XBody getInstance];
    //字体
    [pageTest1.titleLabel setFont:xbody.titleFont];
    [pageTest2.titleLabel setFont:xbody.titleFont];
    [pageTest3.titleLabel setFont:xbody.titleFont];
    [pageTest1 setTitle:localizedString.PAGE_TEST1 forState:UIControlStateNormal];
    [pageTest2 setTitle:localizedString.PAGE_TEST2 forState:UIControlStateNormal];
    [pageTest3 setTitle:localizedString.PAGE_TEST3 forState:UIControlStateNormal];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [button setBackgroundImage:[UIImage imageNamed:@"m_setting"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(settingButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = btn;
  
    /**
     * @zhongqihong
     **/
    self.navigationController.title=localizedString.PAGE_HEALTH_TEST;
    self.navigationItem.title =localizedString.PAGE_HEALTH_TEST;

    /**end**/
}
-(void)settingButtonClicked
{
    [[WindowManager getInstance]showSettingView:self];
}

-(void)viewWillAppear:(BOOL)animated
{
    [[self.tabBarController tabBar] setHidden:NO];
   //TODO [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:NAVIGATIONBAR_BACKGROUND] forBarMetrics:UIBarMetricsDefault];
    //[self.tabBarController.tabBar setBackgroundImage:[UIImage imageNamed:TABBAR_BACKGROUND]];
    //设置导航栏背景
    UIImage *image = [UIImage imageNamed:NAVIGATIONBAR_BACKGROUND];
    UIImage *stretchedImage = [image stretchableImageWithLeftCapWidth:10 topCapHeight:5];
    [self.navigationController.navigationBar setBackgroundImage:stretchedImage forBarMetrics:UIBarMetricsDefault];
    //导航栏字体颜色，back按钮的颜色
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
   
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)testBodyButtonClick:(id)sender{
    [[WindowManager getInstance]showHealthExamingView:self];
}

- (IBAction)healthConsularButtonClick:(id)sender{
    [[WindowManager getInstance]showHealthConsularView:self];
}

- (IBAction)healthTestByFingerButtonClick:(id)sender{
    [[WindowManager getInstance]showHealthExamingByFingerView:self];
}
@end
