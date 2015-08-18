//
//  XBody.m
//  Air Health Assistant
//
//  Created by xu da on 14-6-9.
//  Copyright (c) 2014年 xu da. All rights reserved.
//

#import "XBody.h"
#import "XDetailEntity.h"
#import "MainViewController.h"
#import "PMInformationViewController.h"
#import "WeatherViewController.h"
#import "DeviceViewController.h"
#import "InformationViewController.h"
#import "LocalizedString.h"
#import "iGate.h"
#import "RtBleNvcService.h"
#import "WindowManager.h"

@implementation XBody
@synthesize timer;

@synthesize programVersion;
@synthesize powerState;
@synthesize airMotorState;
@synthesize anionState;
@synthesize totalRunTime;
//@synthesize aqGerneratorVoltage;
@synthesize airQualityDetector;

@synthesize currentCityCode_pm25;
@synthesize currentCityCode;
@synthesize currentCity;
@synthesize cityDic;
@synthesize pm25CityArray;
@synthesize currentProvince;
@synthesize pm25CurrentCityDataDic;

@synthesize warnSignal;
@synthesize pm25Data;

@synthesize gpsSwitch;

@synthesize backgroundColor;
@synthesize isLogined;
@synthesize pm25State;
@synthesize weatherState;
@synthesize bluetoothState;

@synthesize healthDetailArray;
@synthesize healthByFingerDetailArray;
@synthesize healthConsultantArray;

@synthesize healthExercise1Array;
@synthesize healthExercise2Array;
@synthesize healthExercise3Array;
@synthesize healthExercise4Array;
@synthesize healthExercise5Array;

@synthesize shouldUpdate_main_pm25;
@synthesize shouldUpdate_detail_pm25;
@synthesize shouldUpdate_main_weather;
@synthesize shouldUpdate_detail_weather;
@synthesize shouldUpdate_main_device;
@synthesize shouldUpdate_detail_device_for_state;
@synthesize shouldUpdate_detail_device_for_data;
@synthesize shouldUpdate_main_city;
@synthesize shouldUpdate_main_information;
@synthesize shouldUpdate_detail_information;

@synthesize currentDeviceType;

@synthesize navigatorFont;
@synthesize textFont;
@synthesize titleFont;
@synthesize midTextFont;
@synthesize bigTextFont;
@synthesize bigTitleFont;
@synthesize buttonFont;
@synthesize smallFont;
@synthesize tabbarFont;
@synthesize littleFont;

@synthesize pm25_level_1_color;
@synthesize pm25_level_2_color;
@synthesize pm25_level_3_color;
@synthesize pm25_level_4_color;
@synthesize pm25_level_5_color;
@synthesize pm25_level_6_color;
@synthesize dust_level_1_color;
@synthesize dust_level_2_color;
@synthesize dust_level_3_color;
@synthesize dust_level_4_color;
@synthesize detail_title_color;
@synthesize detail_line_color;
@synthesize detail_content_color;

@synthesize cities;

+(XBody *)getInstance
{
    static XBody *instance;
    if (instance == nil) {
        instance = [[XBody alloc]init];
        [instance initData];
    }
    return instance;
}

+(NSMutableDictionary *)getWeather
{
    static NSMutableDictionary *weatherDic;
    if (weatherDic == nil) {
        weatherDic = [[NSMutableDictionary alloc]init];
        //NSMutableDictionary * mutableDictionary = [NSMutableDictionary dictionaryWithCapacity:5];
    }
    return weatherDic;
}

-(void)initData{
    
    
    //设备类型
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if([UIScreen mainScreen].bounds.size.height == 480){
            self.currentDeviceType = XDeviceTypeIPhone4;
        }else{
            self.currentDeviceType = XDeviceTypeIPhone5;
        }
    }else{
        self.currentDeviceType = XDeviceTypeIPad;
    }
    //NSLog(@"UIFont familyNames:%@",[UIFont familyNames]);

    //加载字体
    // Family name: Microsoft YaHei
    // Font name: CUSTOM_FONT
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        //[UIFont fontWithName:CUSTOM_FONT_TEXT size:20.0f];
        //55,25,17,15,15,13
        self.navigatorFont = [UIFont fontWithName:CUSTOM_FONT_TEXT size:20.0f];//[UIFont fontWithName:CUSTOM_FONT_TEXT size:20.0f];
        //城市
        self.smallFont = [UIFont fontWithName:CUSTOM_FONT_TEXT size:14.0f];
        //文本
        self.textFont = [UIFont fontWithName:CUSTOM_FONT_TEXT size:15.0f];
        //文本标题
        self.titleFont = [UIFont fontWithName:CUSTOM_FONT_TEXT size:16.0f];
        //醒目字
        self.bigTitleFont = [UIFont fontWithName:CUSTOM_FONT_TEXT size:17.0f];
        //按钮
        self.buttonFont = [UIFont fontWithName:CUSTOM_FONT_TEXT size:20.0f];
        //中字
        self.midTextFont = [UIFont fontWithName:CUSTOM_FONT_TEXT size:17.0f];
        //大字
        self.bigTextFont = [UIFont fontWithName:CUSTOM_FONT_NUMBER size:60.0f];
        //
        self.tabbarFont = [UIFont fontWithName:CUSTOM_FONT_TEXT size:17.0f];
        //
        self.littleFont = [UIFont fontWithName:CUSTOM_FONT_TEXT size:10.0f];
    }else{
        self.navigatorFont = [UIFont fontWithName:CUSTOM_FONT_TEXT size:30.0f];
        self.bigTitleFont = [UIFont fontWithName:CUSTOM_FONT_TEXT size:30.0f];
        self.textFont = [UIFont fontWithName:CUSTOM_FONT_TEXT size:25.0f];
        self.titleFont = [UIFont fontWithName:CUSTOM_FONT_TEXT size:28.0f];
        self.midTextFont = [UIFont fontWithName:CUSTOM_FONT_TEXT size:30.0f];
        self.bigTextFont = [UIFont fontWithName:CUSTOM_FONT_NUMBER size:70.0f];
        self.buttonFont = [UIFont fontWithName:CUSTOM_FONT_TEXT size:30.0f];
        self.smallFont = [UIFont fontWithName:CUSTOM_FONT_TEXT size:20.0f];
        self.tabbarFont = [UIFont fontWithName:CUSTOM_FONT_TEXT size:17.0f];
        self.littleFont = [UIFont fontWithName:CUSTOM_FONT_TEXT size:15.0f];
    }
    //加载颜色
     pm25_level_1_color = [UIColor colorWithRed:85/255.0 green:171/255.0 blue:52/255.0 alpha:1];
     pm25_level_2_color = [UIColor colorWithRed:229/255.0 green:175/255.0 blue:55/255.0 alpha:1];
     pm25_level_3_color = [UIColor colorWithRed:228/255.0 green:119/255.0 blue:32/255.0 alpha:1];
     pm25_level_4_color = [UIColor colorWithRed:216/255.0 green:32/255.0 blue:29/255.0 alpha:1];
     pm25_level_5_color = [UIColor colorWithRed:111/255.0 green:31/255.0 blue:112/255.0 alpha:1];
     pm25_level_6_color = [UIColor colorWithRed:115/255.0 green:23/255.0 blue:27/255.0 alpha:1];
    
    dust_level_1_color = [UIColor colorWithRed:87/255.0 green:170/255.0 blue:55/255.0 alpha:1];
    dust_level_2_color = [UIColor colorWithRed:229/255.0 green:175/255.0 blue:55/255.0 alpha:1];
    dust_level_3_color = [UIColor colorWithRed:229/255.0 green:136/255.0 blue:76/255.0 alpha:1];
    dust_level_4_color = [UIColor colorWithRed:217/255.0 green:64/255.0 blue:48/255.0 alpha:1];
    
    detail_title_color = [UIColor colorWithRed:57/255.0 green:175/255.0 blue:205/255.0 alpha:1];
    detail_line_color = [UIColor colorWithRed:57/255.0 green:175/255.0 blue:205/255.0 alpha:1];
    detail_content_color = [UIColor colorWithRed:36/255.0 green:36/255.0 blue:37/255.0 alpha:1];

    NSUserDefaults *standard = [NSUserDefaults standardUserDefaults];
    NSString *gpsSwitchString = [standard objectForKey:DATA_GPS_SWITCH];
    
    PM25DataReceivedNotification = @"PM25DataReceivedNotification";
    
    WeatherDataReceivedNotification = @"WeatherDataReceivedNotification";
    
    NSString *pm25CityPath = [[NSBundle mainBundle] pathForResource:@"PM25City" ofType:@"plist"];
    pm25CityArray = [[NSDictionary dictionaryWithContentsOfFile:pm25CityPath] allValues];
    
    WEATHER_CITY = @"city";
    WEATHER_TEMP = @"temp";
    WEATHER_WD = @"WD";
    WEATHER_WS = @"WS";
    WEATHER_SD = @"SD";
    WEATHER_CITYID = @"cityid";
    WEATHER_IMG1 = @"img1";
    WEATHER_IMG2 = @"img2";
    WEATHER_TEMP1 = @"temp1";
    WEATHER_TEMP2 = @"temp2";
    WEATHER_WEATHER = @"weather";
    
    currentCityCode_pm25 = [self checkNull:[standard objectForKey:DATA_CURRENT_CITY_CODE_PM25]];
    
    pm25CurrentCityDataDic = [NSMutableDictionary dictionary];
    
    //currentCity = @"上海";
    //currentCityCode = @"101020800";
    currentCity = [self checkNull:[standard objectForKey:DATA_CURRENT_CITY]];
    currentCityCode = [self checkNull:[standard objectForKey:DATA_CURRENT_CITY_CODE]];
    currentProvince = [self checkNull:[standard objectForKey:DATA_CURRENT_PROVINCE]];
    warnSignal = 0;
    pm25Data = 100;
    isLogined = NO;
    gpsSwitch = [gpsSwitchString intValue];
    NSLog(@"gpsSwitch:%d,currentCity %@,currentCityCode %@,currentProvince %@",gpsSwitch,currentCity,currentCityCode,currentProvince);
    
    //界面背景色
    backgroundColor = [UIColor colorWithRed:55.0/255 green:55.0/255 blue:99.0/255 alpha:1];
    //[standard setObject:@(self.lastCoordinate.longitude) forKey:MMLastLongitude];
    
    
    if (healthDetailArray == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"healthExamination" ofType:@"plist"];
        NSDictionary *healthExaminationDic = [NSDictionary dictionaryWithContentsOfFile:path];
        
        healthDetailArray = [[NSMutableArray alloc]init];
        NSArray * dicArray = [healthExaminationDic allKeys];
        for (int i = 0; i < [dicArray count]; i++) {
            XDetailEntity *detailEntity = [[XDetailEntity alloc]init];
            detailEntity.title = dicArray[i];
            detailEntity.content = [healthExaminationDic objectForKey:dicArray[i]];
            detailEntity.rowHeightP = [self getTextHeight:[UIScreen mainScreen].bounds.size.width text:detailEntity.content];
            detailEntity.rowHeightL = [self getTextHeight:[UIScreen mainScreen].bounds.size.height text:detailEntity.content];
            
            [healthDetailArray addObject:detailEntity];
        }
    }
    
    if (healthByFingerDetailArray == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"healthExaminationByFinger" ofType:@"plist"];
        NSDictionary *healthExaminationByFingerDic = [NSDictionary dictionaryWithContentsOfFile:path];
        
        healthByFingerDetailArray = [[NSMutableArray alloc]init];
        NSArray * dicArray = [healthExaminationByFingerDic allKeys];
        for (int i = 0; i < [dicArray count]; i++) {
            XDetailEntity *detailEntity = [[XDetailEntity alloc]init];
            detailEntity.title = dicArray[i];
            detailEntity.content = [healthExaminationByFingerDic objectForKey:dicArray[i]];
            detailEntity.rowHeightP = [self getTextHeight:[UIScreen mainScreen].bounds.size.width text:detailEntity.content];
            detailEntity.rowHeightL = [self getTextHeight:[UIScreen mainScreen].bounds.size.height text:detailEntity.content];
            
            [healthByFingerDetailArray addObject:detailEntity];
        }
    }
    
    if (healthConsultantArray == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"healthConsultant" ofType:@"plist"];
        NSDictionary *healthConsultantDic = [NSDictionary dictionaryWithContentsOfFile:path];
        healthConsultantArray = [[NSMutableArray alloc]initWithArray:[healthConsultantDic allKeys]];
    }
    NSString *pathHealthExercise = [[NSBundle mainBundle] pathForResource:@"healthExercise" ofType:@"plist"];
    NSDictionary *healthExerciseDic = [NSDictionary dictionaryWithContentsOfFile:pathHealthExercise];
    NSDictionary *healthExercise1Dic = [healthExerciseDic objectForKey:@"瑜伽呼吸法-胸式呼吸法"];
    NSDictionary *healthExercise2Dic = [healthExerciseDic objectForKey:@"瑜伽呼吸法-完全呼吸法"];
    NSDictionary *healthExercise3Dic = [healthExerciseDic objectForKey:@"瑜伽呼吸减肥操"];
    NSDictionary *healthExercise4Dic = [healthExerciseDic objectForKey:@"瑜伽呼吸减肥法 专瘦腹部"];
    NSDictionary *healthExercise5Dic = [healthExerciseDic objectForKey:@"能量治疗"];
    
    NSString *pathImage = [[NSBundle mainBundle] pathForResource:@"healthExerciseImage" ofType:@"plist"];
    NSDictionary *healthExerciseImageDic = [NSDictionary dictionaryWithContentsOfFile:pathImage];
    NSDictionary *healthExercise1ImageDic = [healthExerciseImageDic objectForKey:[NSString stringWithFormat:@"%d",1]];
    NSDictionary *healthExercise2ImageDic = [healthExerciseImageDic objectForKey:[NSString stringWithFormat:@"%d",2]];
    NSDictionary *healthExercise3ImageDic = [healthExerciseImageDic objectForKey:[NSString stringWithFormat:@"%d",3]];
    NSDictionary *healthExercise4ImageDic = [healthExerciseImageDic objectForKey:[NSString stringWithFormat:@"%d",4]];
    
    if (healthExercise1Array == nil) {
        healthExercise1Array = [[NSMutableArray alloc]init];
        NSArray * dicArray = [healthExercise1Dic allKeys];
        for (int i = 0; i < [dicArray count]; i++) {
            XDetailEntity *detailEntity = [[XDetailEntity alloc]init];
            NSString *key = [NSString stringWithFormat:@"%d",i+1];
            detailEntity.title = [[[healthExercise1Dic objectForKey:key] allKeys]objectAtIndex:0];
            detailEntity.content = [[[healthExercise1Dic objectForKey:key]allValues] objectAtIndex:0];
            detailEntity.rowHeightP = [self getTextHeight:[UIScreen mainScreen].bounds.size.width text:detailEntity.content];
            detailEntity.rowHeightL = [self getTextHeight:[UIScreen mainScreen].bounds.size.height text:detailEntity.content];
            detailEntity.image = [healthExercise1ImageDic objectForKey:key];
            [healthExercise1Array addObject:detailEntity];
        }
    }
    
    if (healthExercise2Array == nil) {
        healthExercise2Array = [[NSMutableArray alloc]init];
        NSArray * dicArray = [healthExercise2Dic allKeys];
        for (int i = 0; i < [dicArray count]; i++) {
            XDetailEntity *detailEntity = [[XDetailEntity alloc]init];
            NSString *key = [NSString stringWithFormat:@"%d",i+1];
            detailEntity.title = [[[healthExercise2Dic objectForKey:key] allKeys]objectAtIndex:0];
            detailEntity.content = [[[healthExercise2Dic objectForKey:key]allValues] objectAtIndex:0];
            detailEntity.rowHeightP = [self getTextHeight:[UIScreen mainScreen].bounds.size.width text:detailEntity.content];
            detailEntity.rowHeightL = [self getTextHeight:[UIScreen mainScreen].bounds.size.height text:detailEntity.content];
            detailEntity.image = [healthExercise2ImageDic objectForKey:key];
            [healthExercise2Array addObject:detailEntity];
        }
    }
    
    if (healthExercise3Array == nil) {
        healthExercise3Array = [[NSMutableArray alloc]init];
        NSArray * dicArray = [healthExercise3Dic allKeys];
        for (int i = 0; i < [dicArray count]; i++) {
            XDetailEntity *detailEntity = [[XDetailEntity alloc]init];
            NSString *key = [NSString stringWithFormat:@"%d",i+1];
            detailEntity.title = [[[healthExercise3Dic objectForKey:key] allKeys]objectAtIndex:0];
            detailEntity.content = [[[healthExercise3Dic objectForKey:key]allValues] objectAtIndex:0];
            detailEntity.rowHeightP = [self getTextHeight:[UIScreen mainScreen].bounds.size.width text:detailEntity.content];
            detailEntity.rowHeightL = [self getTextHeight:[UIScreen mainScreen].bounds.size.height text:detailEntity.content];
            detailEntity.image = [healthExercise3ImageDic objectForKey:key];
            [healthExercise3Array addObject:detailEntity];
        }
    }
    
    if (healthExercise4Array == nil) {
        healthExercise4Array = [[NSMutableArray alloc]init];
        NSArray * dicArray = [healthExercise4Dic allKeys];
        for (int i = 0; i < [dicArray count]; i++) {
            XDetailEntity *detailEntity = [[XDetailEntity alloc]init];
            NSString *key = [NSString stringWithFormat:@"%d",i+1];
            NSString *key1 = [NSString stringWithFormat:@"%d",i*2+1];
            NSString *key2 = [NSString stringWithFormat:@"%d",i*2+2];
            detailEntity.title = [[[healthExercise4Dic objectForKey:key] allKeys]objectAtIndex:0];
            detailEntity.content = [[[healthExercise4Dic objectForKey:key]allValues] objectAtIndex:0];
            detailEntity.rowHeightP = [self getTextHeight:[UIScreen mainScreen].bounds.size.width text:detailEntity.content];
            detailEntity.rowHeightL = [self getTextHeight:[UIScreen mainScreen].bounds.size.height text:detailEntity.content];
            detailEntity.image = [healthExercise4ImageDic objectForKey:key1];
            detailEntity.image2 = [healthExercise4ImageDic objectForKey:key2];
            [healthExercise4Array addObject:detailEntity];
        }
    }
    
    if (healthExercise5Array == nil) {
        healthExercise5Array = [[NSMutableArray alloc]init];
        NSArray * dicArray = [healthExercise5Dic allKeys];
        for (int i = 0; i < [dicArray count]; i++) {
            XDetailEntity *detailEntity = [[XDetailEntity alloc]init];
            NSString *key = [NSString stringWithFormat:@"%d",i+1];
            detailEntity.title = [[[healthExercise5Dic objectForKey:key] allKeys]objectAtIndex:0];
            detailEntity.content = [[[healthExercise5Dic objectForKey:key]allValues] objectAtIndex:0];
            detailEntity.rowHeightP = [self getTextHeight:[UIScreen mainScreen].bounds.size.width text:detailEntity.content];
            detailEntity.rowHeightL = [self getTextHeight:[UIScreen mainScreen].bounds.size.height text:detailEntity.content];
            [healthExercise5Array addObject:detailEntity];
        }
    }
    
    /*
     NSString *homePath = [[NSBundle mainBundle] bundlePath];
     NSString *libraryPath = [homePath stringByAppendingPathComponent:@"/Library.plist"];
     cityDic = [NSDictionary dictionaryWithContentsOfFile:libraryPath];
     */
    //主线程，刷新程序
    timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timelyTask:) userInfo:nil repeats:YES];
    [timer fire];
}
-(void)closeDelloc
{
    [timer invalidate];
}
-(int)getCurrentLanguage{
    
     NSArray *languages = [NSLocale preferredLanguages]; NSString *currentLanguage = [languages objectAtIndex:0];
     NSLog ( @"%@" , currentLanguage);
    
    if([currentLanguage isEqualToString: @"en"]) {
        NSLog(@"current Language:en");
        
        return 1 ;
    }
    else if([currentLanguage isEqualToString: @"cn"]) {
        NSLog(@"current Language:cn");
        
        return 0 ;
    }
    return -1;
}
//UI刷新函数
-(void)timelyTask:(id)sender
{
    //需要刷新的页面
    //---------------------------------主界面---------------------------------
    MainViewController *mainVC = (MainViewController*)[WindowManager getInstance].mainViewController;
    //---------------------------------pm2.5详细-------------------------------
    PMInformationViewController *pm25VC = (PMInformationViewController*)[WindowManager getInstance].pmInformationViewController;
    //---------------------------------天气详细---------------------------------
    WeatherViewController *weatherVC = (WeatherViewController*)[WindowManager getInstance].weatherDetailViewController;
    //---------------------------------设备连接界面------------------------------
    DeviceViewController *deviceVC = (DeviceViewController*)[WindowManager getInstance].deviceViewController;
    //----------------------------------信息详细--------------------------------
    InformationViewController *informationVC = (InformationViewController*)[WindowManager getInstance].informationViewController;
    
    XBody *xbody = [XBody getInstance];
    //---------------------------------主界面---------------------------------
    if (mainVC != nil) {
        //pm2.5数据
        if(xbody.shouldUpdate_main_pm25)
        {
            xbody.shouldUpdate_main_pm25 = NO;
            [self updatePM25];
            //周围烟气
            [self updateDust];
        }
        
        //天气数据
        if(xbody.shouldUpdate_main_weather)
        {
            xbody.shouldUpdate_main_weather = NO;
            [self updateWeather];
        }
        
        //设备数据
        if(xbody.shouldUpdate_main_device)
        {
            xbody.shouldUpdate_main_device = NO;
            [self updateDeviceState];
        }
        
        //城市数据
        if(xbody.shouldUpdate_main_city)
        {
            xbody.shouldUpdate_main_city = NO;
            [self updateCity];
        }
        
        //信息数据
        if(xbody.shouldUpdate_main_information)
        {
            xbody.shouldUpdate_main_information = NO;
            [self updateInformation];
        }
    }
    //---------------------------------pm2.5详细-------------------------------
    if(pm25VC != nil){
        if(xbody.shouldUpdate_detail_pm25)
        {
            xbody.shouldUpdate_detail_pm25 = NO;
            [self updatePM25Detail];
            //周围烟气详细
            [self updateDetailInformation];
        }
    }
    //---------------------------------天气详细---------------------------------
    if(weatherVC != nil){
        if(xbody.shouldUpdate_detail_weather)
        {
            xbody.shouldUpdate_detail_weather = NO;
            [self updateWeatherDetail];
        }
    }
    
    //---------------------------------设备连接界面------------------------------
    if(deviceVC != nil){
        if(xbody.shouldUpdate_detail_device_for_state){
            xbody.shouldUpdate_detail_device_for_state = NO;
            [self updateDeviceDetailForState];
        }
        if(xbody.shouldUpdate_detail_device_for_data){
            xbody.shouldUpdate_detail_device_for_data = NO;
            [self updateDeviceDetailForData];
        }
    }
    //----------------------------------信息详细--------------------------------
    if(informationVC != nil){
        if(xbody.shouldUpdate_detail_information){
            xbody.shouldUpdate_detail_information = NO;
            [self updateDetailInformation];
        }
    }
}
-(void)updatePM25
{
    LocalizedString *localizedString = [LocalizedString getInstance];
    
    MainViewController *mainVC = (MainViewController*)[WindowManager getInstance].mainViewController;
    XBody *xbody = [XBody getInstance];
    switch (xbody.pm25State) {
        case STATE_STOP:
            break;
        case STATE_START:
        {
            [mainVC.pm25Button.information setText:localizedString.T_SEARCHING];
            //[mainVC.informationButton.information setText:localizedString.T_WAITING];
        }
            break;
        case STATE_DATA_RECIEVED:
        {
            NSString *str = [xbody.pm25CurrentCityDataDic objectForKey:PM_DATA_PM2_5_1H];
            int value = str.intValue;
            NSString *str2;
            if (value == 0) {
                str2 = @"";
            }else if (value < 50) {
                str2 = localizedString.T_LEVEL1;
                [mainVC.pm25Button.smallImage setImage:[UIImage imageNamed:@"pm25_icon1.png"]];
            }else if (value < 100) {
                str2 = localizedString.T_LEVEL2;
                [mainVC.pm25Button.smallImage setImage:[UIImage imageNamed:@"pm25_icon2.png"]];
            }else if (value < 150) {
                str2 = localizedString.T_LEVEL3;
                [mainVC.pm25Button.smallImage setImage:[UIImage imageNamed:@"pm25_icon3.png"]];
            }else if (value < 200) {
                str2 = localizedString.T_LEVEL4;
                [mainVC.pm25Button.smallImage setImage:[UIImage imageNamed:@"pm25_icon4.png"]];
            }else if (value < 300) {
                str2 = localizedString.T_LEVEL5;
                [mainVC.pm25Button.smallImage setImage:[UIImage imageNamed:@"pm25_icon5.png"]];
            }else{
                str2 = localizedString.T_LEVEL6;
                [mainVC.pm25Button.smallImage setImage:[UIImage imageNamed:@"pm25_icon6.png"]];
            }
            
            if(str == nil || [str length] == 0)
            {
                [mainVC.pm25Button.information setText:localizedString.T_NO_DATA];
            }else
            {
                [mainVC.pm25Button.information setText:[NSString stringWithFormat:@"%@ %@",str,str2]];
            }
            /*
             NSString *str_a1 = [[XBody getInstance].pm25CurrentCityDataDic objectForKey:PM_DATA_AFFECT];
             NSString *str_a2 = [[XBody getInstance].pm25CurrentCityDataDic objectForKey:PM_DATA_ACTION];
             if(str_a1 == nil)str_a1 = @"";
             if(str_a2 == nil)str_a2 = @"";
             NSString *str_affect_action = [NSString stringWithFormat:@"%@: %@\n%@: %@",PM_DATA_AFFECT,str_a1,PM_DATA_ACTION,str_a2];
             [mainVC.informationButton.information setText:str_affect_action];
             */
        }
            break;
        case STATE_DATA_ERROR:
        default:
        {
            [mainVC.pm25Button.information setText:localizedString.T_NO_DATA];
            //[mainVC.informationButton.information setText:localizedString.T_NO_DATA];
        }
            break;
    }
    
    //indicator
    if (xbody.pm25State == STATE_START) {
        [mainVC.pm25ActivityIndicator startAnimating];
        [mainVC.pm25ActivityIndicator setHidden:NO];
    }else{
        [mainVC.pm25ActivityIndicator stopAnimating];
        [mainVC.pm25ActivityIndicator setHidden:YES];
    }
    
}
 UIImageView *imageView;
NSString *IMAGE_URL;

- (void)downloadImage
{
    NSURL *imageUrl = [NSURL URLWithString:IMAGE_URL];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
    imageView.image = image;
}

-(void)updateWeather
{
    LocalizedString *localizedString = [LocalizedString getInstance];
    MainViewController *mainVC = (MainViewController*)[WindowManager getInstance].mainViewController;
    XBody *xbody = [XBody getInstance];
    switch (xbody.weatherState) {
        case STATE_STOP:
            break;
        case STATE_START:
        {
            [mainVC.weatherButton.information setText:localizedString.T_SEARCHING];
        }
            break;
        case STATE_DATA_RECIEVED:
        {
              int lan = [[XBody getInstance] getCurrentLanguage];
            LocalizedString * localizedString = [LocalizedString getInstance];
            NSMutableDictionary *weather = [XBody getWeather];
            NSString *temp = [weather objectForKey:WEATHER_TEMP];
            if(temp == nil)temp = localizedString.TEXT_NO_DATA;
            NSString *weatherStr = [weather objectForKey:WEATHER_WEATHER];
            if(weatherStr == nil)weatherStr = localizedString.TEXT_NO_DATA;
            //NSString *str = [NSString stringWithFormat:@"%@:%@℃ %@:%@",localizedString.WEATHER_TEMP,temp,localizedString.WEATHER_WEATHER,weatherStr];
            
            NSString *str = [NSString stringWithFormat:@"%@℃ %@",temp,weatherStr];
            [mainVC.weatherButton.information setText:str];
            
            //刷新图片
            NSString *path = [[NSBundle mainBundle] pathForResource:@"weatherImgMap" ofType:@"plist"];
            NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
            NSString *imgStrDay = [weather objectForKey:WEATHER_IMG1];
            NSString *imgStrNight = [weather objectForKey:WEATHER_IMG2];
          
            
            
            if (imgStrDay == nil) {
                imgStrDay = @"weather_d_31";
            }
            if (imgStrNight == nil) {
                imgStrNight = @"weather_n_31";
            }
            
            
         
            
            
      
            
            NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"HH"];
            NSString* date = [formatter stringFromDate:[NSDate date]];
            int dataInt = date.intValue;
            
            
          
            
            if(lan == 1){
                
                imageView = mainVC.weatherButton.smallImage;
                IMAGE_URL = imgStrDay;
                NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
                NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(downloadImage) object:nil];
                [operationQueue addOperation:op];

            }
            else{
                
                   //NSLog(@"date: %d,%@,%@",dataInt,date,[NSDate date]);
                   if (dataInt > 6 && dataInt < 18) {
                                //day
                
                
                        [mainVC.weatherButton.smallImage setImage:[UIImage imageNamed:[dic objectForKey:imgStrDay]]];
                    }else{
                                //night
                                [mainVC.weatherButton.smallImage setImage:[UIImage imageNamed:[dic objectForKey:imgStrNight]]];
                     }
            }
            

        }
            break;
        case STATE_DATA_ERROR:
        {
            [mainVC.weatherButton.information setText:localizedString.T_NO_DATA];
            NSLog(@"weatherButton STATE_DATA_ERROR");
        }
            break;
            
        default:
            break;
    }
    //indicator
    if (xbody.weatherState == STATE_START) {
        [mainVC.weatherActivityIndicator startAnimating];
        [mainVC.weatherActivityIndicator setHidden:NO];
    }else{
        [mainVC.weatherActivityIndicator stopAnimating];
        [mainVC.weatherActivityIndicator setHidden:YES];
    }
}
-(void)updateDeviceState
{
    LocalizedString * localizedString = [LocalizedString getInstance];
    MainViewController *mainVC = (MainViewController*)[WindowManager getInstance].mainViewController;
    NSString *str;
    switch (self.bluetoothState) {
        case BLUETOOTH_STATE_CONNECTING:
            str = [NSString stringWithFormat:@"%@%@",localizedString.T_DEVICE,localizedString.T_CONNECTING];
            break;
        case BLUETOOTH_STATE_CONNECTED:
            str = [NSString stringWithFormat:@"%@%@",localizedString.T_DEVICE,localizedString.T_CONNECTED];
            break;
        default:
            str = [NSString stringWithFormat:@"%@%@",localizedString.T_DEVICE,localizedString.T_DISCONNECTED];
            break;
    }
    [mainVC.deviceButton.information setText:str];
}
-(void)updateCity
{
    LocalizedString * localizedString = [LocalizedString getInstance];
    MainViewController *mainVC = (MainViewController*)[WindowManager getInstance].mainViewController;
    XBody *xbody = [XBody getInstance];
    NSString* theCityStr = [xbody checkNull:xbody.currentCity];
    NSString* theProvinceStr = [xbody checkNull:xbody.currentProvince];
    
    if ([theProvinceStr isEqualToString: theCityStr]) {
        [mainVC.citySelectButton.information setText:[NSString stringWithFormat:@"%@%@",localizedString.T_CURRENT_CITY,theCityStr]];
    }else{
        [mainVC.citySelectButton.information setText:[NSString stringWithFormat:@"%@%@%@",localizedString.T_CURRENT_CITY,theProvinceStr,theCityStr]];
    }
}
-(void)updateInformation
{
    LocalizedString *localizedString = [LocalizedString getInstance];
    
    MainViewController *mainVC = (MainViewController*)[WindowManager getInstance].mainViewController;
    XBody *xbody = [XBody getInstance];
    switch (xbody.pm25State) {
        case STATE_STOP:
            break;
        case STATE_START:
        {
            [mainVC.informationButton.information setText:localizedString.T_ANALYZATION];
        }
            break;
        case STATE_DATA_RECIEVED:
        {
            /*
             NSString *str_a1 = [[XBody getInstance].pm25CurrentCityDataDic objectForKey:PM_DATA_AFFECT];
             NSString *str_a2 = [[XBody getInstance].pm25CurrentCityDataDic objectForKey:PM_DATA_ACTION];
             if(str_a1 == nil)str_a1 = @"";
             if(str_a2 == nil)str_a2 = @"";
             //NSString *str_affect_action = [NSString stringWithFormat:@"%@: %@\n%@: %@",PM_DATA_AFFECT,str_a1,PM_DATA_ACTION,str_a2];
             NSString *str_affect_action = [NSString stringWithFormat:@"%@",str_a1];*/
            [mainVC.informationButton.information setText:localizedString.T_ANALYZATION];
        }
            break;
        case STATE_DATA_ERROR:
        default:
        {
            [mainVC.informationButton.information setText:localizedString.T_ANALYZATION];
        }
            break;
    }
}
-(void)updateDust
{
    MainViewController *mainVC = (MainViewController*)[WindowManager getInstance].mainViewController;
    XBody *xbody = [XBody getInstance];
    switch (xbody.airQualityDetector) {
        case 0:
            [mainVC.dustButton.smallImage setImage:[UIImage imageNamed:@"dust_icon0.png"]];
            break;
        case 1:
            [mainVC.dustButton.smallImage setImage:[UIImage imageNamed:@"dust_icon1.png"]];
            break;
        case 2:
            [mainVC.dustButton.smallImage setImage:[UIImage imageNamed:@"dust_icon2.png"]];
            break;
        case 3:
            [mainVC.dustButton.smallImage setImage:[UIImage imageNamed:@"dust_icon3.png"]];
            break;
    }
}
-(void)updatePM25Detail
{
    PMInformationViewController *pm25VC = (PMInformationViewController*)[WindowManager getInstance].pmInformationViewController;
    [pm25VC refreshData];
}
-(void)updateWeatherDetail
{
    [(WeatherViewController*)[WindowManager getInstance].weatherDetailViewController refreshData];
}
-(void)updateDeviceDetailForState
{
    [(DeviceViewController*)[WindowManager getInstance].deviceViewController refreshState];
}
-(void)updateDeviceDetailForData
{
    [(DeviceViewController*)[WindowManager getInstance].deviceViewController refreshData];
    [(DustViewController*)[WindowManager getInstance].dustViewController refreshData];
}
-(void)updateDetailInformation
{
    [(InformationViewController*)[WindowManager getInstance].informationViewController refreshData];
}
-(void)updateDetailDust
{
    [(DustViewController*)[WindowManager getInstance].dustViewController refreshData];
}

//-------------------------------------setter and getter-------------------------------------
-(void)setPm25State_2:(int)value
{
    self.pm25State = value;
    shouldUpdate_main_pm25 = YES;
    shouldUpdate_detail_pm25 = YES;
    shouldUpdate_main_information = YES;
}
-(int)pm25State2
{
    return self.pm25State;
}
-(void)setWeatherState_2:(int)value
{
    self.weatherState = value;
    shouldUpdate_main_weather = YES;
    shouldUpdate_detail_weather = YES;
}
-(int)weatherState2
{
    return self.weatherState;
}
-(void)setBluetoothState_2:(int)value
{
    self.bluetoothState = value;
    shouldUpdate_main_device = YES;
    shouldUpdate_detail_device_for_state = YES;
}
-(int)bluetoothState2
{
    return self.bluetoothState;
}
-(void)setCurrentCityCode_pm25_2:(NSString *)value
{
    NSLog(@"setCurrentCityCode_pm25_2:%@,%@",value,self.currentProvince);
    //模糊匹配
    XBody *xbody = [XBody getInstance];
    xbody.currentCityCode_pm25 = nil;
    BOOL found = NO;
    for (NSString *city in self.pm25CityArray) {
        NSRange range1 = [value rangeOfString:city];
        if(range1.location != NSNotFound){
            found = YES;
            xbody.currentCityCode_pm25 = city;
            break;
        }
    }
    if (!found) {
        for (NSString *city in self.pm25CityArray) {
            NSRange range1 = [city rangeOfString:self.currentProvince];
            if(range1.location != NSNotFound){
                found = YES;
                xbody.currentCityCode_pm25 = city;
                break;
            }
        }
        
    }
}
-(NSString *)currentCityCode_pm252
{
    return self.currentCityCode_pm25;
}
//-------------------------------------------------------------------------------------------
-(int)getTextHeight:(int)width text:(NSString*)textStr
{
    int viewMargin = VIEW_MARGIN;
    int titleHeight = TITLE_HEIGHT;
    int imageSize = IMAGE_SIZE;
    int imageSizeSmallW = IMAGE_SIZE_SMALL_W;
    int imageSizeSmallH = IMAGE_SIZE_SMALL_H;
    XBody *xbody = [XBody getInstance];
    if(xbody.currentDeviceType == XDeviceTypeIPad) {
        viewMargin = VIEW_MARGIN_IPAD;
        titleHeight = TITLE_HEIGHT_IPAD;
        imageSize = IMAGE_SIZE_IPAD;
        imageSizeSmallW = IMAGE_SIZE_SMALL_W_IPAD;
        imageSizeSmallH = IMAGE_SIZE_SMALL_H_IPAD;
    }
    CGSize sizeNameH = [textStr sizeWithFont:xbody.textFont
                           constrainedToSize:CGSizeMake(width - 2*viewMargin, MAXFLOAT)
                               lineBreakMode:NSLineBreakByWordWrapping];
    return sizeNameH.height +titleHeight+ 10;

/*
    CGSize sizeNameH = [textStr sizeWithFont:[UIFont fontWithName:CUSTOM_FONT_TEXT size:TEXT_FONT_SIZE]
                           constrainedToSize:CGSizeMake(width - 2*VIEW_MARGIN, MAXFLOAT)
                               lineBreakMode:NSLineBreakByWordWrapping];
    return sizeNameH.height +TITLE_HEIGHT+ 10;*/
}
/*
 NSLog(@"weatherURLRequest connection didReceiveData %@", weatherString);
 NSMutableDictionary *jsonoObj = [weatherString JSONValue];
 NSLog(@"weatherURLRequest jsonoObj %@", jsonoObj);
 NSMutableDictionary *jsonoSubObj = [jsonoObj objectForKey:@"weatherinfo"];
 NSString *cityid = [jsonoSubObj objectForKey:@"cityid"];
 NSString *img1 = [jsonoSubObj objectForKey:@"img1"];
 NSString *img2 = [jsonoSubObj objectForKey:@"img2"];
 NSString *temp1 = [jsonoSubObj objectForKey:@"temp1"];
 NSString *temp2 = [jsonoSubObj objectForKey:@"temp2"];
 NSString *weather = [jsonoSubObj objectForKey:@"weather"];
 [weatherActivityIndicator stopAnimating];
 */
-(NSString *)checkNull:(NSString *)str
{
    if(str == nil)
    {
        return @"";
    }else{
        return str;
    }
}
-(NSArray*)regularMatch:(NSString*)str patten:(NSString*)patten
{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    //    NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:patten options:NSRegularExpressionDotMatchesLineSeparators error:nil];
    NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:patten options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray* match = [reg matchesInString:str options:NSMatchingReportCompletion range:NSMakeRange(0, [str length])];
    if (match.count != 0)
    {
        for (NSTextCheckingResult *matc in match)
        {
            NSRange range = [matc range];
            [arr addObject:[str substringWithRange:range]];
        }
    }
    return arr;
}
/*
 运动指数 - 计算方法
 户外体育运动指数采用因子相乘法，以天气现象、气温、相对湿度、风速、能见度作为A、B、C、D、E 5个因子。户外运动指数K的计算公式为：
 K=A×B×C×D×E
 式中各项因子的取值标准为：
 （1）A值：预报天空状况为晴、少云、多云时为2，阴天时为1，有雨雪、霜、冰雹、冻雨等天气时为0。
 （2）B值：5 ℃<日最低气温≤24 ℃时为2，－4 ℃<日最低气温≤5 ℃或24 ℃<日最低气温≤27 ℃时为1，日最低气温≤－4 ℃或日最低气温>27 ℃时为0。
 （3）C值：50％≤相对湿度< 65％时为2，10%≤相对湿度<50％或 65％≤相对湿度<85％时为1，相对湿度<10%或相对湿度≥85％时为 0。
 （4）D值：风力在3级或以下时为2，4～6级时为1，7级或以上时为0。
 （5）E值：能见度≥1 000 m时为1；能见度<1 000 m，且同时伴有大雾、沙尘暴等天气时为 0。
 运动指数 - 指数分级
 根据计算结果，户外运动指数可分成以下5个等级：
 （1）K=0时为1级，表示气象条件很差，不适宜户外体育运动，可适当进行户内体育运动，如篮球、网球、乒乓球等；
 （2）K=1时为2级，表示气象条件较差，不太适宜户外体育运动，可进行户内体育运动，如篮球、网球、乒乓球等；
 （3）K=2或K=4时为3级，表示气象条件一般，比较适宜户外体育运动，可增加户外体育运动，如球类运动、田赛、径赛等；
 （4）K=8时为4级，表示气象条件好，适宜户外体育运动，如球类运动、田赛、径赛、射击等；
 （5）K=16时为5级，表示气象条件非常好，为最佳户外体育运动时期，适宜各种户外体育运动。
 */
-(int)getSportLevel
{
    NSMutableDictionary *weather = [XBody getWeather];
    
    int valueA = 0,valueB = 0,valueC = 0,valueD = 0,valueE = 0;
    int valueK = 0;
    NSString *valueAStr = [weather objectForKey:WEATHER_IMG1];
    if([valueAStr isEqualToString:@"d0.gif"] || [valueAStr isEqualToString:@"d1.gif"]
       )
    {
        valueA = 2;
    }
    else if([valueAStr isEqualToString:@"d2.gif"]||[valueAStr isEqualToString:@"d3.gif"]
            || [valueAStr isEqualToString:@"d7.gif"] || [valueAStr isEqualToString:@"d8.gif"]
            ||[valueAStr isEqualToString:@"d14.gif"] || [valueAStr isEqualToString:@"d21.gif"]
            ){
        valueA = 1;
    }
    int valueBData = [[weather objectForKey:WEATHER_TEMP2]intValue];
    if(valueBData > 5 && valueBData <= 24)
    {
        valueB = 2;
    }else if ((valueBData > -4 && valueBData <= 5) || (valueBData > 24 && valueBData <= 27))
    {
        valueB = 1;
    }else{
        valueB = 0;
    }
    int valueCData = [[weather objectForKey:WEATHER_SD]intValue];
    if(valueCData >= 50 && valueCData < 65)
    {
        valueC = 2;
    }else if ((valueCData >= 10 && valueCData < 50) || (valueCData >= 65 && valueCData < 85))
    {
        valueC = 1;
    }else{
        valueC = 0;
    }
    //（4）D值：风力在3级或以下时为2，4～6级时为1，7级或以上时为0。
    int valueDData = [[weather objectForKey:WEATHER_WD]intValue];
    
    if (valueDData <= 3)
    {
        valueD = 2;
    }else if(valueDData >= 4 && valueDData <= 6)
    {
        valueD = 1;
    }else{
        valueD = 0;
    }
    //E项改称佩戴指数参数
    int valueEData = [[[XBody getInstance].pm25CurrentCityDataDic objectForKey:PM_DATA_PM2_5_1H]intValue];
    if (valueEData > 200) {
        valueE = 0;
    }else{
        valueE = 1;
    }
    NSLog(@"valueBData:%d,valueA %d, valueB %d, valueC %d, valueD %d, valueE %d",valueBData,valueA , valueB , valueC , valueD , valueE);
    switch (valueA * valueB * valueC * valueD * valueE) {
        case 0:
            valueK = 1;
            break;
        case 1:
            valueK = 2;
            break;
        case 2:
        case 4:
            valueK = 3;
            break;
        case 8:
            valueK = 4;
            break;
        case 16:
            valueK = 5;
            break;
        default:
            break;
    }
    return valueK;
}
/*
 1 炎热 >28.0 0 夏季着装：短衫、短裙、短裤、薄型T恤衫、敞领短袖棉衫
 2 热舒适 24.0~27.9 0~2.40 夏季着装：短裙、短裤、短套装、T 恤年老体弱者：单层薄衫裤、薄型棉衫
 3 舒适 21.0~23.9 2.41~4.00 春秋过渡装：单层薄衫裤、薄型棉杉年老体弱者：针织长袖衬衫+背心、长裤、薄型套装
 4 凉舒适 18.0~20.9 4.01~6.00 春秋过渡装：针织长袖衬衫+背心、长裤、薄型套装、牛仔衫裤,年老体弱者，春秋着装：一件薄羊毛衫+夹衣或西服套装
 5 温凉 15.0~17.9 6.01~8.00 春秋着装：一件羊毛衫、套装、夹克衫、西服套装、马甲衬衫+夹克衫配长裤年老体弱者：一件厚羊毛衫+夹衣或风衣
 6 凉 11.0~14.9 8.01~10.00 春秋着装：毛衣、风衣、毛套装、西服套装。年老体弱者：一到两件羊毛衫+大衣或毛套装
 7 冷 6.0~10.9 10.01~13.00 春秋着装：一到两件羊毛衫、大衣、毛套装、皮夹克，老年体弱者，冬季着装：棉衣、冬大衣、皮夹克、内着衬衫或羊毛内衣+毛衣再外罩大衣
 8 寒冷 <6.0 >13.00 冬季着装：棉衣、冬大衣、皮夹克、内着衬衫或羊毛内衣+毛衣再外罩大衣, 年老体弱者尽量少外出
 */
-(int)getDressingIndex
{
    int level = 0;
    NSMutableDictionary *weather = [XBody getWeather];
    int value = [[weather objectForKey:WEATHER_TEMP]intValue];
    if(value > 28)
    {
        level = 1;
    }else if (value >= 24)
    {
        level = 2;
    }else if (value >= 21)
    {
        level = 3;
    }else if (value >= 18)
    {
        level = 4;
    }else if (value >= 15)
    {
        level = 5;
    }else if (value >= 11)
    {
        level = 6;
    }else if (value >= 6)
    {
        level = 7;
    }else
    {
        level = 8;
    }
    return level;
}
-(int)getPM25Level
{
    NSString *str = [[XBody getInstance].pm25CurrentCityDataDic objectForKey:PM_DATA_PM2_5_1H];
    int value = str.intValue;
    int level;
    if (value == 0) {
        level = 0;
    }else if (value < 50) {
        level = 1;
    }else if (value < 100) {
        level = 2;
    }else if (value < 150) {
        level = 3;
    }else if (value < 200) {
        level = 4;
    }else if (value < 300) {
        level = 5;
    }else{
        level = 6;
    }
    return level;
}
/*
 感冒指数
 1级：少发
 2级：较易发
 3级：易发
 4级：极易发[3]
 */
@end
