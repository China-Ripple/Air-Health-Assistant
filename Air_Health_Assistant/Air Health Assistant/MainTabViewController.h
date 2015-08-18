//
//  TabViewController.h
//  Air Health Assistant
//
//  Created by xu da on 14-5-17.
//  Copyright (c) 2014年 xu da. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface MainTabViewController : UIViewController<UITabBarControllerDelegate, UINavigationControllerDelegate>{
    //ViewController *firstViewController;
}
@property (strong, nonatomic) IBOutlet UITabBarController *xTabBarController;
//@property (strong, nonatomic) IBOutlet ViewController *firstViewController;

//+ (MainTabViewController *)sharedInstance;

- (IBAction)AirViewButtonClick:(id)sender;
- (IBAction)WeatherViewButtonClick:(id)sender;
- (void)saveTabOrder;
- (void)showState;//显示状态 TODO
@end