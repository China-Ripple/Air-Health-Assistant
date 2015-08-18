//
//  HealthTestViewController.h
//  Air Health Assistant
//
//  Created by xu da on 14-5-16.
//  Copyright (c) 2014年 xu da. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HealthTestViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *pageTest1;
@property (strong, nonatomic) IBOutlet UIButton *pageTest2;
@property (strong, nonatomic) IBOutlet UIButton *pageTest3;

- (IBAction)testBodyButtonClick:(id)sender;
- (IBAction)healthConsularButtonClick:(id)sender;
- (IBAction)healthTestByFingerButtonClick:(id)sender;
@end
