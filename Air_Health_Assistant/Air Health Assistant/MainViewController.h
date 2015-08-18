//
//  MainViewController.h
//  Air Health Assistant
//
//  Created by xu da on 14-5-4.
//  Copyright (c) 2014年 xu da. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainTabViewController.h"
#import "PrettyButton.h"
#import "XBody.h"

@interface MainViewController : UIViewController<WeatherDelegate,CityDelegate>{
    MainTabViewController *mainTabViewController;
    PrettyButton *pm25Button;
    PrettyButton *weatherButton;
    PrettyButton *deviceButton;
    PrettyButton *citySelectButton;
    PrettyButton *informationButton;
    PrettyButton *dustButton;
    UIActivityIndicatorView *pm25ActivityIndicator;
    UIActivityIndicatorView *weatherActivityIndicator;
}

//@property (strong, nonatomic) IBOutlet UITabBarController *xTabBarController;
@property (strong, nonatomic) IBOutlet MainTabViewController *mainTabViewController;
@property (strong, nonatomic) IBOutlet UIView *frameView;
@property (strong, nonatomic) IBOutlet PrettyButton *pm25Button;
@property (strong, nonatomic) IBOutlet PrettyButton *weatherButton;
@property (strong, nonatomic) IBOutlet PrettyButton *deviceButton;
@property (strong, nonatomic) IBOutlet PrettyButton *citySelectButton;
@property (strong, nonatomic) IBOutlet PrettyButton *informationButton;
@property (strong, nonatomic) IBOutlet PrettyButton *dustButton;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *pm25ActivityIndicator;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *weatherActivityIndicator;

@property (strong, nonatomic)NSMutableURLRequest *pm25URLRequest;
@property (strong, nonatomic)NSMutableURLRequest *weatherURLRequest;

@property (strong, nonatomic) IBOutlet UILabel *pm25ButtonDes;
@property (strong, nonatomic) IBOutlet UILabel *weatherButtonDes;
@property (strong, nonatomic) IBOutlet UILabel *deviceButtonDes;
@property (strong, nonatomic) IBOutlet UILabel *citySelectButtonDes;
@property (strong, nonatomic) IBOutlet UILabel *informationButtonDes;
@property (strong, nonatomic) IBOutlet UILabel *dustButtonDes;

- (IBAction)pm25ViewButtonClick:(id)sender;
- (IBAction)weatherViewButtonClick:(id)sender;
- (IBAction)deviceViewButtonClick:(id)sender;
- (IBAction)cityViewButtonClick:(id)sender;
- (IBAction)informationViewButtonClick:(id)sender;
- (IBAction)dustViewButtonClick:(id)sender;
//- (void)loadWeather;

@end
