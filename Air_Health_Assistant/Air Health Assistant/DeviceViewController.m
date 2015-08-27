//
//  DeviceViewController.m
//  Air Health Assistant
//
//  Created by xu da on 14-5-21.
//  Copyright (c) 2014年 xu da. All rights reserved.
//

#import "DeviceViewController.h"
#import "XBody.h"
#import "Const.h"
#import "LocalizedString.h"
#import "MyBleService.h"

@interface DeviceViewController ()

@end

@implementation DeviceViewController

//程序版本
@synthesize programVersionTitle;
@synthesize programVersionL;
//开关状态
@synthesize powerStateTitle;
@synthesize powerStateL;
@synthesize powerStateImage;
//风扇状态
@synthesize airMotorStateTitle;
@synthesize airMotorStateL;
@synthesize airMotorStateImage;
//负离子开关状态
@synthesize anionStateTitle;
@synthesize anionStateL;
@synthesize anionStateImage;
//总运行时间
@synthesize totalRunTimeTitle;
@synthesize totalRunTimeL;
/*
 //空气质量传感器输出电压
 @synthesize aqGerneratorVoltageTitle;
 @synthesize aqGerneratorVoltageL;*/
@synthesize dustLevelTitle;
@synthesize dustLevelL;
//连接状态
@synthesize connectionStateTitle;
@synthesize connectionStateL;
@synthesize connectionStateImage;
//负离子按钮
@synthesize anionTitle;
@synthesize anionOnButton;
@synthesize anionOffButton;
//风扇按钮
@synthesize airMotorTitle;
@synthesize airMotor0Button;
@synthesize airMotor1Button;
@synthesize airMotor2Button;
@synthesize airMotor3Button;
//缩放框架
@synthesize frameView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    LocalizedString *localizedString = [LocalizedString getInstance];
    self.navigationItem.title = localizedString.PAGE_DEVICE;
    [self refreshData];
    [self refreshState];
    //判断蓝牙链接
    MyBleService *myBleService = [MyBleService getInstance];
    if(myBleService.mc10.BLE_state == BLUETOOTH_STATE_DISCONNECT){
        [myBleService.mc10 findBLEPeripherals:1];
    }
    [[self.tabBarController tabBar] setHidden:YES];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    LocalizedString *localizedString = [LocalizedString getInstance];
    [programVersionTitle setText:localizedString.TITLE_PROGRAM_VERSION];
    [powerStateTitle setText:localizedString.TITLE_POWER_STATE];
    [airMotorStateTitle setText:localizedString.TITLE_FAN_SATE];
    [anionStateTitle setText:localizedString.TITLE_ANION_STATE];
    [totalRunTimeTitle setText:localizedString.TITLE_TOTAL_RUNTIME];
    [dustLevelTitle setText:localizedString.TITLE_DUST];
    
  
    
    //[aqGerneratorVoltageTitle setText:localizedString.TITLE_VOLTAGE];
    [connectionStateTitle setText:localizedString.TITLE_CONNECTION_STATE];
    //字体
    XBody *xbody = [XBody getInstance];
    //程序版本
    [programVersionTitle setFont:xbody.titleFont];
    [programVersionL setFont:xbody.textFont];
    //开关状态
    [powerStateTitle setFont:xbody.titleFont];
    [powerStateL setFont:xbody.textFont];
    //风扇状态
    [airMotorStateTitle setFont:xbody.titleFont];
    [airMotorStateL setFont:xbody.textFont];
    //负离子开关状态
    [anionStateTitle setFont:xbody.titleFont];
    [anionStateL setFont:xbody.textFont];
    //总运行时间
    [totalRunTimeTitle setFont:xbody.titleFont];
    [totalRunTimeL setFont:xbody.textFont];
    //烟气状态
    [dustLevelTitle setFont:xbody.titleFont];
    [dustLevelL setFont:xbody.textFont];
    //连接状态
    [connectionStateTitle setFont:xbody.titleFont];
    [connectionStateL setFont:xbody.textFont];
    //负离子按钮
    [anionTitle setFont:xbody.titleFont];
    [anionTitle setText:localizedString.ANION_STATE_TITLE];
    
    [anionOnButton.titleLabel setFont:xbody.bigTitleFont];
    [anionOnButton setTitle:localizedString.TEXT_ANION_ON forState:UIControlStateNormal];

    [anionOffButton.titleLabel setFont:xbody.bigTitleFont];
    [anionOffButton setTitle:localizedString.TEXT_ANION_OFF forState:UIControlStateNormal];
    //风扇按钮
    [airMotorTitle setFont:xbody.titleFont];
    [airMotorTitle setText:localizedString.TEXT_AIR_MOTOR_TITLE];
    
    [airMotor0Button.titleLabel setFont:xbody.bigTitleFont];
    [airMotor0Button setTitle:localizedString.TEXT_AIR_MOTOR_0 forState:UIControlStateNormal];
    
    
    [airMotor1Button.titleLabel setFont:xbody.bigTitleFont];
    [airMotor1Button setTitle:localizedString.TEXT_AIR_MOTOR_1 forState:UIControlStateNormal];
    
    [airMotor2Button.titleLabel setFont:xbody.bigTitleFont];
    [airMotor2Button setTitle:localizedString.TEXT_AIR_MOTOR_2 forState:UIControlStateNormal];
    
    [airMotor3Button.titleLabel setFont:xbody.bigTitleFont];
    [airMotor3Button setTitle:localizedString.TEXT_AIR_MOTOR_3 forState:UIControlStateNormal];
}
-(void)refreshState
{
    XBody *xbody = [XBody getInstance];
    LocalizedString *localizedString = [LocalizedString getInstance];
    NSString *str;
    //连接状态
    switch (xbody.bluetoothState) {
        case BLUETOOTH_STATE_CONNECTING:
            str = [NSString stringWithFormat:@"%@%@",localizedString.T_DEVICE,localizedString.T_CONNECTING];
            [connectionStateImage setImage:[UIImage imageNamed:@"device_bluetooth_connecting"]];
            [connectionStateL setText:localizedString.T_CONNECTING];
            break;
        case BLUETOOTH_STATE_CONNECTED:
            str = [NSString stringWithFormat:@"%@%@",localizedString.T_DEVICE,localizedString.T_CONNECTED];
            [connectionStateImage setImage:[UIImage imageNamed:@"device_bluetooth_connected"]];
            [connectionStateL setText:localizedString.T_CONNECTED];
            break;
        default:
            str = [NSString stringWithFormat:@"%@%@",localizedString.T_DEVICE,localizedString.T_DISCONNECTED];
            [connectionStateImage setImage:[UIImage imageNamed:@"device_bluetooth_disconnected"]];
            [connectionStateL setText:localizedString.T_DISCONNECTED];
            break;
    }
}
-(void)refreshData
{
    LocalizedString *localizedString = [LocalizedString getInstance];
    
    XBody *xbody = [XBody getInstance];
    //程序版本
    [programVersionL setText:[NSString stringWithFormat:@"V%d.0",xbody.programVersion]];
    //开关状态
    if (xbody.powerState == TRUE) {
        [powerStateImage setImage:[UIImage imageNamed:@"device_power_on"]];
        [powerStateL setText:localizedString.TEXT_POWER_ON];
    }else{
        [powerStateImage setImage:[UIImage imageNamed:@"device_power_off"]];
        [powerStateL setText:localizedString.TEXT_POWER_OFF];
    }

    //风扇状态
    switch (xbody.airMotorState) {
        default:
        case 0:
            //[airMotorStateTitle setText:[NSString stringWithFormat:@"%@:0",localizedString.TITLE_FAN_SATE]];
            [airMotorStateTitle setText:[NSString stringWithFormat:@"%@",localizedString.TITLE_FAN_SATE]];
            [airMotorStateImage setImage:[UIImage imageNamed:@"device_fan_off"]];
            [airMotorStateL setText:localizedString.TEXT_AIR_MOTOR_0];
            [airMotor0Button setBackgroundImage:[UIImage imageNamed:@"device_item2_on.png"] forState:UIControlStateNormal];
            [airMotor1Button setBackgroundImage:[UIImage imageNamed:@"device_item2_off.png"] forState:UIControlStateNormal];
            [airMotor2Button setBackgroundImage:[UIImage imageNamed:@"device_item2_off.png"] forState:UIControlStateNormal];
            [airMotor3Button setBackgroundImage:[UIImage imageNamed:@"device_item2_off.png"] forState:UIControlStateNormal];
            [airMotor0Button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [airMotor1Button setTitleColor:[UIColor colorWithRed:57/255.0 green:175/255.0 blue:205/255.0 alpha:1] forState:UIControlStateNormal];
            [airMotor2Button setTitleColor:[UIColor colorWithRed:57/255.0 green:175/255.0 blue:205/255.0 alpha:1] forState:UIControlStateNormal];
            [airMotor3Button setTitleColor:[UIColor colorWithRed:57/255.0 green:175/255.0 blue:205/255.0 alpha:1] forState:UIControlStateNormal];
            break;
        case 1:
            [airMotorStateTitle setText:[NSString stringWithFormat:@"%@",localizedString.TITLE_FAN_SATE]];
            //[airMotorStateTitle setText:[NSString stringWithFormat:@"%@:1",localizedString.TITLE_FAN_SATE]];
            [airMotorStateImage setImage:[UIImage imageNamed:@"device_fan_on"]];
            [airMotorStateL setText:localizedString.TEXT_AIR_MOTOR_1];
            [airMotor0Button setBackgroundImage:[UIImage imageNamed:@"device_item2_off.png"] forState:UIControlStateNormal];
            [airMotor1Button setBackgroundImage:[UIImage imageNamed:@"device_item2_on.png"] forState:UIControlStateNormal];
            [airMotor2Button setBackgroundImage:[UIImage imageNamed:@"device_item2_off.png"] forState:UIControlStateNormal];
            [airMotor3Button setBackgroundImage:[UIImage imageNamed:@"device_item2_off.png"] forState:UIControlStateNormal];
            [airMotor0Button setTitleColor:[UIColor colorWithRed:57/255.0 green:175/255.0 blue:205/255.0 alpha:1] forState:UIControlStateNormal];
            [airMotor1Button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [airMotor2Button setTitleColor:[UIColor colorWithRed:57/255.0 green:175/255.0 blue:205/255.0 alpha:1] forState:UIControlStateNormal];
            [airMotor3Button setTitleColor:[UIColor colorWithRed:57/255.0 green:175/255.0 blue:205/255.0 alpha:1] forState:UIControlStateNormal];
            break;
        case 2:
            [airMotorStateTitle setText:[NSString stringWithFormat:@"%@",localizedString.TITLE_FAN_SATE]];
            //[airMotorStateTitle setText:[NSString stringWithFormat:@"%@:2",localizedString.TITLE_FAN_SATE]];
            [airMotorStateImage setImage:[UIImage imageNamed:@"device_fan_on"]];
            [airMotorStateL setText:localizedString.TEXT_AIR_MOTOR_2];
            [airMotor0Button setBackgroundImage:[UIImage imageNamed:@"device_item2_off.png"] forState:UIControlStateNormal];
            [airMotor1Button setBackgroundImage:[UIImage imageNamed:@"device_item2_off.png"] forState:UIControlStateNormal];
            [airMotor2Button setBackgroundImage:[UIImage imageNamed:@"device_item2_on.png"] forState:UIControlStateNormal];
            [airMotor3Button setBackgroundImage:[UIImage imageNamed:@"device_item2_off.png"] forState:UIControlStateNormal];
            [airMotor0Button setTitleColor:[UIColor colorWithRed:57/255.0 green:175/255.0 blue:205/255.0 alpha:1] forState:UIControlStateNormal];
            [airMotor1Button setTitleColor:[UIColor colorWithRed:57/255.0 green:175/255.0 blue:205/255.0 alpha:1] forState:UIControlStateNormal];
            [airMotor2Button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [airMotor3Button setTitleColor:[UIColor colorWithRed:57/255.0 green:175/255.0 blue:205/255.0 alpha:1] forState:UIControlStateNormal];
            break;
        case 3:
            [airMotorStateTitle setText:[NSString stringWithFormat:@"%@",localizedString.TITLE_FAN_SATE]];
            //[airMotorStateTitle setText:[NSString stringWithFormat:@"%@:3",localizedString.TITLE_FAN_SATE]];
            [airMotorStateImage setImage:[UIImage imageNamed:@"device_fan_on"]];
            [airMotorStateL setText:localizedString.TEXT_AIR_MOTOR_3];
            [airMotor0Button setBackgroundImage:[UIImage imageNamed:@"device_item2_off.png"] forState:UIControlStateNormal];
            [airMotor1Button setBackgroundImage:[UIImage imageNamed:@"device_item2_off.png"] forState:UIControlStateNormal];
            [airMotor2Button setBackgroundImage:[UIImage imageNamed:@"device_item2_off.png"] forState:UIControlStateNormal];
            [airMotor3Button setBackgroundImage:[UIImage imageNamed:@"device_item2_on.png"] forState:UIControlStateNormal];
            [airMotor0Button setTitleColor:[UIColor colorWithRed:57/255.0 green:175/255.0 blue:205/255.0 alpha:1] forState:UIControlStateNormal];
            [airMotor1Button setTitleColor:[UIColor colorWithRed:57/255.0 green:175/255.0 blue:205/255.0 alpha:1] forState:UIControlStateNormal];
            [airMotor2Button setTitleColor:[UIColor colorWithRed:57/255.0 green:175/255.0 blue:205/255.0 alpha:1] forState:UIControlStateNormal];
            [airMotor3Button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            break;
    }
    //负离子开关状态
    if (xbody.anionState == TRUE) {
        [anionStateImage setImage:[UIImage imageNamed:@"device_anion_on"]];
        [anionStateL setText:localizedString.TEXT_ANION_ON];
        //[anionOnButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //[anionOffButton setTitleColor:[UIColor colorWithRed:56/255 green:84/255 blue:135/255 alpha:1] forState:UIControlStateNormal];
        //[anionOffButton setTitleColor:[UIColor colorWithRed:56/255 green:84/255 blue:135/255 alpha:1] forState:UIControlStateNormal];
        //[anionOffButton.titleLabel setTextColor:[UIColor colorWithRed:56/255 green:84/255 blue:135/255 alpha:1]];
        //[anionOffButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [anionOnButton setBackgroundImage:[UIImage imageNamed:@"device_item1_on.png"] forState:UIControlStateNormal];
        [anionOnButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [anionOffButton setBackgroundImage:[UIImage imageNamed:@"device_item1_off.png"] forState:UIControlStateNormal];
        [anionOffButton setTitleColor:[UIColor colorWithRed:57/255.0 green:175/255.0 blue:205/255.0 alpha:1] forState:UIControlStateNormal];
    }else{
        [anionStateImage setImage:[UIImage imageNamed:@"device_anion_off"]];
        [anionStateL setText:localizedString.TEXT_ANION_OFF];
        //[anionOnButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        //[anionOnButton.titleLabel setTextColor:[UIColor colorWithRed:56/255 green:84/255 blue:135/255 alpha:1]];

        [anionOnButton setBackgroundImage:[UIImage imageNamed:@"device_item1_off.png"] forState:UIControlStateNormal];
        [anionOnButton setTitleColor:[UIColor colorWithRed:57/255.0 green:175/255.0 blue:205/255.0 alpha:1] forState:UIControlStateNormal];
        [anionOffButton setBackgroundImage:[UIImage imageNamed:@"device_item1_on.png"] forState:UIControlStateNormal];
        [anionOffButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    }
    //总运行时间
    int timeH = xbody.totalRunTime / 3600;
    int timeM = (xbody.totalRunTime % 3600) / 60;
    int timeS = (xbody.totalRunTime % 60);
    [totalRunTimeL setText:[NSString stringWithFormat:@"%02d:%02d:%02d",timeH,timeM,timeS]];
    //烟气等级
    [dustLevelL setText:[NSString stringWithFormat:@"%ld",xbody.airQualityDetector]];
    //空气传感器电压
    //[aqGerneratorVoltageL setText:[NSString stringWithFormat:@"%ld",xbody.aqGerneratorVoltage]];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
 1 协议头 2 数据包标识3 控制命令4 协议尾
 01：负离子开
 02：负离子关
 03：风扇1
 04：风扇2
 05：风扇3
 */
-(void)sendData:(uint8_t)keyNumber{
    NSMutableData *data = [NSMutableData data];
    uint8_t tmp[4];
    tmp[0] = SOI;
    tmp[1]  = (0x02 << 4);//01显示，02控制
    tmp[1] |= keyNumber & 0xf;
    tmp[2] = EOI;
    //for (int i = 0; i < 99; i++) {
    [data appendBytes:(void *)(&tmp) length:3];
    
    //}
    //[data appendBytes:(void *)(&tmp) length:3];
    //[[RtBleNvcService sharedInstance] sendData:data];
    [[MyBleService getInstance]sendData:data];
    NSLog(@"sendData keyNumber:%@",data);
}
- (IBAction)anionOnButtonClick:(id)sender{
    NSLog(@"anionOnButtonClick");
    [self sendData:01];
}
- (IBAction)anionOffButtonClick:(id)sender{
    NSLog(@"anionOffButtonClick");
    [self sendData:02];
}
- (IBAction)airMoterLevel0ButtonClick:(id)sender{
    NSLog(@"airMoterLevel0ButtonClick");
    [self sendData:00];
}
- (IBAction)airMoterLevel1ButtonClick:(id)sender{
    NSLog(@"airMoterLevel1ButtonClick");
    [self sendData:03];
}
- (IBAction)airMoterLevel2ButtonClick:(id)sender{
    NSLog(@"airMoterLevel2ButtonClick");
    [self sendData:04];
}
- (IBAction)airMoterLevel3ButtonClick:(id)sender{
    NSLog(@"airMoterLevel3ButtonClick");
    [self sendData:05];
}

@end
