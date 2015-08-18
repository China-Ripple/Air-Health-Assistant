//
//  WindowManager.h
//  Air Health Assistant
//
//  Created by xu da on 14-7-19.
//  Copyright (c) 2014年 xu da. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeatherViewController.h"
#import "InformationViewController.h"
#import "TestTextViewController.h"
#import "XBody.h"
#import "HealthConsultantTableViewController.h"
#import "ExerciseDetailViewController.h"
#import "Exercise4DetailViewController.h"
#import "LocalizedString.h"
#import "PMInformationViewController.h"
#import "DeviceViewController.h"
#import "HttpConnectionLogic.h"
#import "SettingViewController.h"
#import "DustViewController.h"

@interface WindowManager : NSObject

@property UIViewController<WeatherDelegate> *mainViewController;
@property WeatherViewController *weatherDetailViewController;
@property PMInformationViewController *pmInformationViewController;
@property DeviceViewController *deviceViewController;
@property InformationViewController *informationViewController;
@property DustViewController *dustViewController;
@property TestTextViewController *testTableViewController;
@property HealthConsultantTableViewController *healthConsultantTableViewController;
@property ExerciseDetailViewController *exerciseDetailViewController;
@property Exercise4DetailViewController *exercise4DetailViewController;
@property SettingViewController *settingViewController;

+(WindowManager *)getInstance;
-(void)initWithDelegate:(UIViewController*)mainViewController;
- (void)showPM25DetailView:(UIViewController*)theViewController;
- (void)showWeatherDetailView:(UIViewController*)theViewController;
- (void)showDeviceView:(UIViewController*)theViewController;
- (void)showInformationView:(UIViewController*)theViewController;
- (void)showDustView:(UIViewController*)theViewController;
- (void)showHealthExamingView:(UIViewController*)theViewController;
- (void)showHealthExamingByFingerView:(UIViewController*)theViewController;
- (void)showHealthConsularView:(UIViewController*)theViewController;

- (void)showFitnessExercise1:(UIViewController*)theViewController;
- (void)showFitnessExercise2:(UIViewController*)theViewController;
- (void)showFitnessExercise3:(UIViewController*)theViewController;
- (void)showFitnessExercise4:(UIViewController*)theViewController;
- (void)showFitnessExercise5:(UIViewController*)theViewController;
- (void)showSettingView:(UIViewController*)theViewController;

@end
