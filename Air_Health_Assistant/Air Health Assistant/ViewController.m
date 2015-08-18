//
//  ViewController.m
//  Air Health Assistant
//
//  Created by xu da on 14-5-5.
//  Copyright (c) 2014年 xu da. All rights reserved.
//

#import "ViewController.h"
#import "MainTabViewController.h"

#define START_ANIMATION_DURATION    2.5
#define START_ANIMATION_DELAY       0.2

@interface ViewController ()

@end

@implementation ViewController
MainTabViewController *mainTabViewController;

+ (id) sharedInstance
{
    return self;
}


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
    //NSLog(@"viewDidLoad");
    [super viewDidLoad];
    NSString *mainTabViewNib = nil;
    //if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        mainTabViewNib = @"MainTabView_iPhone";
    //}else {
    //    mainTabViewNib = @"MainTabView_iPad";
    //}
    // Do any additional setup after loading the view from its nib.
    if(mainTabViewController == nil)
    {
        mainTabViewController = [[MainTabViewController alloc] initWithNibName:mainTabViewNib bundle:nil];
    }
    self.view.alpha = 0.2;
    [UIView animateWithDuration:START_ANIMATION_DURATION
     
                          delay: START_ANIMATION_DELAY
     
                        options: UIViewAnimationOptionTransitionFlipFromRight
     
                     animations:^{
                         //调试中先取消
                         self.view.alpha = 1;
                         
                     }
     
                     completion:^(BOOL finished){
                         self.view.alpha = 1;
                         // Wait one second and then fade in the view
                         //从logo跳转下一个
                         //[self.navigationController pushViewController:mainTabViewController animated:NO];
                         [self.parentViewController.view addSubview:mainTabViewController.view];
                         [self removeFromParentViewController];
                     }];
    //NSLog(@"self.parentViewController: %@",self.parentViewController);
    //NSLog(@"viewcontroller: %@",self.navigationController);

}

-(void)viewDidAppear:(BOOL)animated
{

}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
}
-(void)viewDidDisappear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
}
-(void)viewDidUnload
{
    NSLog(@"viewDidUnload");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
