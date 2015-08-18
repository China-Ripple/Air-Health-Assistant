//
//  FitnessViewController.m
//  Air Health Assistant
//
//  Created by xu da on 14-5-16.
//  Copyright (c) 2014年 xu da. All rights reserved.
//

#import "FitnessViewController.h"
#import "XBody.h"
#import "WindowManager.h"

@interface FitnessViewController ()

@end

@implementation FitnessViewController
@synthesize exercise1Button;
@synthesize exercise2Button;
@synthesize exercise3Button;
@synthesize exercise4Button;
@synthesize exercise5Button;

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
    XBody *xbody = [XBody getInstance];
    //字体
//    [exercise1Button.titleLabel setFont:xbody.titleFont];
//    [exercise2Button.titleLabel setFont:xbody.titleFont];
//    [exercise3Button.titleLabel setFont:xbody.titleFont];
//    [exercise4Button.titleLabel setFont:xbody.titleFont];
//    [exercise5Button.titleLabel setFont:xbody.titleFont];

    
   // UIScrollView * sView = (UIScrollView *)self.view;
   // [sView setContentSize:CGSizeMake(1320, 1000)];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [button setBackgroundImage:[UIImage imageNamed:@"m_setting"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(settingButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = btn;
    
    /***
     *@zhongqihong
     ***/
    LocalizedString *localizedString = [LocalizedString getInstance];
    self.navigationController.title =localizedString.PAGE_HEALTH_CONSULTANT;
    self.navigationItem.title =localizedString.PAGE_HEALTH_CONSULTANT;
    
    [exercise1Button setTitle:localizedString.PAGE_EXERCISE1 forState:UIControlStateNormal];
    
      [exercise2Button setTitle:localizedString.PAGE_EXERCISE2 forState:UIControlStateNormal];
     [exercise3Button setTitle:localizedString.PAGE_EXERCISE3 forState:UIControlStateNormal];

    [exercise4Button setTitle:localizedString.PAGE_EXERCISE4 forState:UIControlStateNormal];

     [exercise5Button setTitle:localizedString.PAGE_EXERCISE5 forState:UIControlStateNormal];
    
   /******/
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

-(void)viewDidAppear:(BOOL)animated
{
    /*
    UIScrollView * sView = (UIScrollView *)self.view;
    
    sView.frame = CGRectMake(0, 0, 320, 480);
    
    [sView setContentSize:CGSizeMake(1320, 1000)];
    
*/

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)exercise1ButtonClick:(id)sender
{
    [[WindowManager getInstance]showFitnessExercise1:self];
}
- (IBAction)exercise2ButtonClick:(id)sender
{
    [[WindowManager getInstance]showFitnessExercise2:self];
}
- (IBAction)exercise3ButtonClick:(id)sender
{
    [[WindowManager getInstance]showFitnessExercise3:self];
}
- (IBAction)exercise4ButtonClick:(id)sender
{
    [[WindowManager getInstance]showFitnessExercise4:self];
}
- (IBAction)exercise5ButtonClick:(id)sender
{
    [[WindowManager getInstance]showFitnessExercise5:self];
}

@end
