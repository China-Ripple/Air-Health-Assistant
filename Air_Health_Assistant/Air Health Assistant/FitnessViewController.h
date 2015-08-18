//
//  FitnessViewController.h
//  Air Health Assistant
//
//  Created by xu da on 14-5-16.
//  Copyright (c) 2014年 xu da. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FitnessViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *exercise1Button;
@property (strong, nonatomic) IBOutlet UIButton *exercise2Button;
@property (strong, nonatomic) IBOutlet UIButton *exercise3Button;
@property (strong, nonatomic) IBOutlet UIButton *exercise4Button;
@property (strong, nonatomic) IBOutlet UIButton *exercise5Button;

- (IBAction)exercise1ButtonClick:(id)sender;
- (IBAction)exercise2ButtonClick:(id)sender;
- (IBAction)exercise3ButtonClick:(id)sender;
- (IBAction)exercise4ButtonClick:(id)sender;
- (IBAction)exercise5ButtonClick:(id)sender;

@end
