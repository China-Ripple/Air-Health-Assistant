//
//  rongtai_airHealthAppDelegate.h
//  Air Health Assistant
//
//  Created by xu da on 14-5-4.
//  Copyright (c) 2014年 xu da. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainTabViewController.h"

@class ViewController;
@class MainTabViewController;

@interface rongtai_airHealthAppDelegate : UIResponder <UIApplicationDelegate>
@property (weak, nonatomic) IBOutlet UITabBarController *myTabBarController;

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ViewController *viewController;
@property (strong, nonatomic) MainTabViewController *mainTabViewController;

@end
