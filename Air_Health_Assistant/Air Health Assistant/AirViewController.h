//
//  AirViewController.h
//  Air Health Assistant
//
//  Created by xu da on 14-5-4.
//  Copyright (c) 2014年 xu da. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainTabViewController.h"

@interface AirViewController : UIViewController{
    //MainTabViewController *mainTabViewController;
}
@property (strong, nonatomic) MainTabViewController *mainTabViewController;
- (IBAction)cancelButtonClick:(id)sender;
- (IBAction)showAirViewButtonClick:(id)sender;
@end
