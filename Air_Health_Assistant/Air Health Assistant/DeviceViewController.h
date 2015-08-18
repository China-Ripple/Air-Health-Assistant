//
//  DeviceViewController.h
//  Air Health Assistant
//
//  Created by xu da on 14-5-21.
//  Copyright (c) 2014年 xu da. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeviceViewController : UIViewController
//程序版本
@property (strong, nonatomic) IBOutlet UILabel *programVersionTitle;
@property (strong, nonatomic) IBOutlet UILabel *programVersionL;
//开关状态
@property (strong, nonatomic) IBOutlet UILabel *powerStateTitle;
@property (strong, nonatomic) IBOutlet UILabel *powerStateL;
@property (strong, nonatomic) IBOutlet UIImageView *powerStateImage;
//风扇状态
@property (strong, nonatomic) IBOutlet UILabel *airMotorStateTitle;
@property (strong, nonatomic) IBOutlet UILabel *airMotorStateL;
@property (strong, nonatomic) IBOutlet UIImageView *airMotorStateImage;
//负离子开关状态
@property (strong, nonatomic) IBOutlet UILabel *anionStateTitle;
@property (strong, nonatomic) IBOutlet UILabel *anionStateL;
@property (strong, nonatomic) IBOutlet UIImageView *anionStateImage;
//总运行时间
@property (strong, nonatomic) IBOutlet UILabel *totalRunTimeTitle;
@property (strong, nonatomic) IBOutlet UILabel *totalRunTimeL;
/*
//空气质量传感器输出电压
@property (strong, nonatomic) IBOutlet UILabel *aqGerneratorVoltageTitle;
@property (strong, nonatomic) IBOutlet UILabel *aqGerneratorVoltageL;
 */
//烟气状态
@property (strong, nonatomic) IBOutlet UILabel *dustLevelTitle;
@property (strong, nonatomic) IBOutlet UILabel *dustLevelL;

//连接状态
@property (strong, nonatomic) IBOutlet UILabel *connectionStateTitle;
@property (strong, nonatomic) IBOutlet UILabel *connectionStateL;
@property (strong, nonatomic) IBOutlet UIImageView *connectionStateImage;

//负离子按钮
@property (strong, nonatomic) IBOutlet UILabel *anionTitle;
@property (strong, nonatomic) IBOutlet UIButton *anionOnButton;
@property (strong, nonatomic) IBOutlet UIButton *anionOffButton;

//风扇按钮
@property (strong, nonatomic) IBOutlet UILabel *airMotorTitle;
@property (strong, nonatomic) IBOutlet UIButton *airMotor0Button;
@property (strong, nonatomic) IBOutlet UIButton *airMotor1Button;
@property (strong, nonatomic) IBOutlet UIButton *airMotor2Button;
@property (strong, nonatomic) IBOutlet UIButton *airMotor3Button;

//缩放框架
@property (strong, nonatomic) IBOutlet UIView *frameView;

/*
01：负离子开
02：负离子关
03：风扇1
04：风扇2
05：风扇3*/
- (IBAction)anionOnButtonClick:(id)sender;
- (IBAction)anionOffButtonClick:(id)sender;
- (IBAction)airMoterLevel0ButtonClick:(id)sender;
- (IBAction)airMoterLevel1ButtonClick:(id)sender;
- (IBAction)airMoterLevel2ButtonClick:(id)sender;
- (IBAction)airMoterLevel3ButtonClick:(id)sender;
//定时刷新函数
-(void)refreshData;
-(void)refreshState;
@end
