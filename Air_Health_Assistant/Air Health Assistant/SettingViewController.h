//
//  SettingViewController.h
//  Air Health Assistant
//
//  Created by xu da on 14-7-19.
//  Copyright (c) 2014年 xu da. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingViewController : UIViewController
@property (strong, nonatomic) IBOutlet UISegmentedControl *gpsSelection;
- (IBAction)gpsSelectionChanged:(id)sender;


@property (weak, nonatomic) IBOutlet UILabel *gpslabel;

@property (weak, nonatomic) IBOutlet UILabel *autoConnLabel;
@end
