//
//  UserInformationViewController.h
//  Air Health Assistant
//
//  Created by xu da on 14-5-16.
//  Copyright (c) 2014年 xu da. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserInformationViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *loginButton;

- (IBAction)userInformationButtonClick:(id)sender;
- (IBAction)loginButtonClick:(id)sender;

@end
