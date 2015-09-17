//
//  PMInformationViewController.m
//  Air Health Assistant
//
//  Created by xu da on 14-5-17.
//  Copyright (c) 2014年 xu da. All rights reserved.
//

#import "PMInformationViewController.h"
#import "MainTabViewController.h"
#import "XBody.h"
#import "HttpConnectionLogic.h"
#import "LocalizedString.h"

@interface PMInformationViewController ()

@end

@implementation PMInformationViewController
//
@synthesize frameView;
//pm2.5图形
@synthesize titleImage;
//pm2.5标题
@synthesize titleLabel;
//pm2.5数值
@synthesize valueLabel;
//pm2.5单位
@synthesize unitLabel;
//城市
@synthesize cityLabel;
//pm2.5质量文字展示
@synthesize pm25TextLabel;
//pm2.5指示颜色对应
@synthesize colorBarTitle;
//pm2.5指示颜色 严重污染
@synthesize colorBarBadTitle;
//pm2.5影响
@synthesize affect;
//pm2.5空气质量详细参数
@synthesize dataDetailTitle;
//pm2.5参数－区域（title，内容，标题背景，内容背景）
@synthesize areaTitle;
@synthesize areaTitleImage;
@synthesize areaContent;
@synthesize areaContentImage;
//pm2.5参数－时间
@synthesize liveTimeTitle;
@synthesize liveTimeTitleImage;
@synthesize liveTimeContent;
@synthesize liveTimeContentImage;
//pm2.5参数－AQI
@synthesize aqiTitle;
@synthesize aqiTitleImage;
@synthesize aqiContent;
@synthesize aqiContentImage;
//pm2.5参数－PM2.5
@synthesize pm25Title;
@synthesize pm25TitleImage;
@synthesize pm25Content;
@synthesize pm25ContentImage;
//pm2.5参数－PM10
@synthesize pm10Title;
@synthesize pm10TitleImage;
@synthesize pm10Content;
@synthesize pm10ContentImage;
//pm2.5参数－CO
@synthesize co_1hTitle;
@synthesize co_1hTitleImage;
@synthesize co_1hContent;
@synthesize co_1hContentImage;
//pm2.5参数－NO2
@synthesize no2_1hTitle;
@synthesize no2_1hTitleImage;
@synthesize no2_1hContent;
@synthesize no2_1hContentImage;
//pm2.5参数－SO2
@synthesize so2_1hTitle;
@synthesize so2_1hTitleImage;
@synthesize so2_1hContent;
@synthesize so2_1hContentImage;
//pm2.5参数－O3/1h
@synthesize o3_1hTitle;
@synthesize o3_1hTitleImage;
@synthesize o3_1hContent;
@synthesize o3_1hContentImage;
//pm2.5参数－O3/8h
@synthesize o3_8hTitle;
@synthesize o3_8hTitleImage;
@synthesize o3_8hContent;
@synthesize o3_8hContentImage;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    XBody *xbody = [XBody getInstance];
    
    //pm2.5图形
    //pm2.5标题:pm2.5 17
    [titleLabel setFont:xbody.bigTitleFont];
    //pm2.5数值 60
    [valueLabel setFont:xbody.bigTextFont];
    //pm2.5单位 17
    [unitLabel setFont:xbody.midTextFont];
    //城市 14
    [cityLabel setFont:xbody.smallFont];
    //pm2.5质量文字展示 16
    [pm25TextLabel setFont:xbody.titleFont];
    //pm2.5指示颜色对应 15
    [colorBarTitle setFont:xbody.textFont];
    //严重污染
    [colorBarBadTitle setFont:xbody.buttonFont];
    //pm2.5影响 15
    [affect setFont:xbody.textFont];
    //pm2.5空气质量详细参数
    [dataDetailTitle setFont:xbody.textFont];
    //pm2.5参数－区域（title，内容，标题背景，内容背景）
    [areaTitle setFont:xbody.textFont];
    // areaTitleImage;
    [areaContent setFont:xbody.textFont];
    // areaContentImage;
    //pm2.5参数－时间
    [liveTimeTitle setFont:xbody.textFont];
    //liveTimeTitleImage;
    [liveTimeContent setFont:xbody.textFont];
    //liveTimeContentImage;
    //pm2.5参数－AQI
    [aqiTitle setFont:xbody.textFont];
    //aqiTitleImage;
    [aqiContent setFont:xbody.textFont];
    //aqiContentImage;
    //pm2.5参数－PM2.5
    [pm25Title setFont:xbody.textFont];
    //pm25TitleImage;
    [pm25Content setFont:xbody.textFont];
    //pm25ContentImage;
    //pm2.5参数－PM10
    [pm10Title setFont:xbody.textFont];
    //pm10TitleImage;
    [pm10Content setFont:xbody.textFont];
    //pm10ContentImage;
    //pm2.5参数－CO
    [co_1hTitle setFont:xbody.textFont];
    //co_1hTitleImage;
    [co_1hContent setFont:xbody.textFont];
    //co_1hContentImage;
    //pm2.5参数－NO2
    [no2_1hTitle setFont:xbody.textFont];
    //no2_1hTitleImage;
    [no2_1hContent setFont:xbody.textFont];
    //no2_1hContentImage;
    //pm2.5参数－SO2
    [so2_1hTitle setFont:xbody.textFont];
    //so2_1hTitleImage;
    [so2_1hContent setFont:xbody.textFont];
    //so2_1hContentImage;
    //pm2.5参数－O3/1h
    [o3_1hTitle setFont:xbody.textFont];
    //o3_1hTitleImage;
    [o3_1hContent setFont:xbody.textFont];
    //o3_1hContentImage;
    //pm2.5参数－O3/8h
    [o3_8hTitle setFont:xbody.textFont];
    //o3_8hTitleImage;
    [o3_8hContent setFont:xbody.textFont];
    //o3_8hContentImage;
    /*
    if (xbody.currentDeviceType == XDeviceTypeIPhone4) {
        [self.frameView setFrame:CGRectMake(0,IPHONE4_DETAIL_Y,320,IPHONE4_DETAIL_HEIGHT)];
    }else if(xbody.currentDeviceType == XDeviceTypeIPhone5) {
        [self.frameView setFrame:CGRectMake(0,IPHONE5_DETAIL_Y,320,IPHONE5_DETAIL_HEIGHT)];
    }else if(xbody.currentDeviceType == XDeviceTypeIPad) {
        [self.frameView setFrame:CGRectMake(IPAD_DETAIL_X,IPAD_DETAIL_Y,IPAD_DETAIL_WIDTH,IPAD_DETAIL_HEIGHT)];
    }*/
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    LocalizedString *localizedString = [LocalizedString getInstance];
    self.navigationItem.title = localizedString.PAGE_PM25_DETAIL;
    
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pm25DetailDataReceived:) name:PM25DataReceivedNotification object:nil];
    //[[HttpConnectionLogic getInstance] loadPM25];
    [self refreshData];
    //缩放
    XBody *xbody = [XBody getInstance];
    if (xbody.currentDeviceType == XDeviceTypeIPhone4) {
        [self.frameView setFrame:CGRectMake(0,IPHONE4_DETAIL_Y,320,IPHONE4_DETAIL_HEIGHT)];
    }else if(xbody.currentDeviceType == XDeviceTypeIPhone5) {
        [self.frameView setFrame:CGRectMake(0,IPHONE5_DETAIL_Y,320,IPHONE5_DETAIL_HEIGHT)];
    }else if(xbody.currentDeviceType == XDeviceTypeIPad) {
        [self.frameView setFrame:CGRectMake(IPAD_DETAIL_X,IPAD_DETAIL_Y,IPAD_DETAIL_WIDTH,IPAD_DETAIL_HEIGHT)];
    }
    [[self.tabBarController tabBar] setHidden:YES];
}
-(void)viewWillDisappear:(BOOL)animated
{
    //[[NSNotificationCenter defaultCenter] removeObserver:self name: PM25DataReceivedNotification object:nil];
}
/*
 -(void)pm25DetailDataReceived:(id)sender
 {
 NSLog(@"PM25DataReceivedNotification pm25DetailDataReceived");
 [self performSelectorOnMainThread:@selector(updateUI_refreshData)withObject:nil waitUntilDone:YES];
 }
 
 - (void)updateUI_refreshData
 {
 NSLog(@"updateUI_refreshData");
 [self refreshData];
 }*/

-(void)refreshData
{
    LocalizedString *localizedString = [LocalizedString getInstance];
    XBody *xbody = [XBody getInstance];
    //区域
    [areaContent setText: xbody.currentCity];
    //AQI
    [aqiContent setText:[ xbody.pm25CurrentCityDataDic objectForKey:PM_DATA_AQI]];
    //PM2.5
    [pm25Content setText:[ xbody.pm25CurrentCityDataDic objectForKey:PM_DATA_PM2_5_1H]];
    //PM10/1h
    [pm10Content setText:[ xbody.pm25CurrentCityDataDic objectForKey:PM_DATA_PM10_1H]];
    //CO/1h
    [co_1hContent setText:[ xbody.pm25CurrentCityDataDic objectForKey:PM_DATA_CO]];
    //NO2/1h
    [no2_1hContent setText:[ xbody.pm25CurrentCityDataDic objectForKey:PM_DATA_NO2]];
    //O3/1h
    [o3_1hContent setText:[ xbody.pm25CurrentCityDataDic objectForKey:PM_DATA_O3_1H]];
    //O3/8h
    [o3_8hContent setText:[ xbody.pm25CurrentCityDataDic objectForKey:PM_DATA_O3_8H]];
    //SO2/1h
    [so2_1hContent setText:[ xbody.pm25CurrentCityDataDic objectForKey:PM_DATA_SO2_1H]];
    //时间
    [liveTimeContent setText:[ xbody.pm25CurrentCityDataDic objectForKey:PM_DATA_TIME]];
    //pm2.5图形
    switch ([xbody getPM25Level]) {
        case 1:
        default:
            [titleImage setImage:[UIImage imageNamed:@"pm25_icon1.png"]];
            //[titleLabel setTextColor:xbody.pm25_level_1_color];
            [pm25TextLabel setTextColor:xbody.pm25_level_1_color];
            [affect setTextColor:xbody.pm25_level_1_color];
            [valueLabel setTextColor:xbody.pm25_level_1_color];
            [unitLabel setTextColor:xbody.pm25_level_1_color];
            break;
        case 2:
            [titleImage setImage:[UIImage imageNamed:@"pm25_icon2.png"]];
            //[titleLabel setTextColor:xbody.pm25_level_2_color];
            [pm25TextLabel setTextColor:xbody.pm25_level_2_color];
            [affect setTextColor:xbody.pm25_level_2_color];
            [valueLabel setTextColor:xbody.pm25_level_2_color];
            [unitLabel setTextColor:xbody.pm25_level_2_color];
            
            break;
        case 3:
            [titleImage setImage:[UIImage imageNamed:@"pm25_icon3.png"]];
            //[titleLabel setTextColor:xbody.pm25_level_3_color];
            [pm25TextLabel setTextColor:xbody.pm25_level_3_color];
            [affect setTextColor:xbody.pm25_level_3_color];
            [valueLabel setTextColor:xbody.pm25_level_3_color];
            [unitLabel setTextColor:xbody.pm25_level_3_color];
            
            break;
        case 4:
            [titleImage setImage:[UIImage imageNamed:@"pm25_icon4.png"]];
            //[titleLabel setTextColor:xbody.pm25_level_4_color];
            [pm25TextLabel setTextColor:xbody.pm25_level_4_color];
            [affect setTextColor:xbody.pm25_level_4_color];
            [valueLabel setTextColor:xbody.pm25_level_4_color];
            [unitLabel setTextColor:xbody.pm25_level_4_color];
            
            break;
        case 5:
            [titleImage setImage:[UIImage imageNamed:@"pm25_icon5.png"]];
            //[titleLabel setTextColor:xbody.pm25_level_5_color];
            [pm25TextLabel setTextColor:xbody.pm25_level_5_color];
            [affect setTextColor:xbody.pm25_level_5_color];
            [valueLabel setTextColor:xbody.pm25_level_5_color];
            [unitLabel setTextColor:xbody.pm25_level_5_color];
            
            break;
        case 6:
            [titleImage setImage:[UIImage imageNamed:@"pm25_icon6.png"]];
            //[titleLabel setTextColor:xbody.pm25_level_6_color];
            [pm25TextLabel setTextColor:xbody.pm25_level_6_color];
            [affect setTextColor:xbody.pm25_level_6_color];
            [valueLabel setTextColor:xbody.pm25_level_6_color];
            [unitLabel setTextColor:xbody.pm25_level_6_color];
            
            break;
    }
    //pm2.5标题
    //titleLabel;
    NSString *str = [xbody.pm25CurrentCityDataDic objectForKey:PM_DATA_PM2_5_1H];
    //pm2.5数值
    [valueLabel setText:str];
    //pm2.5单位
    //unitLabel;
    //日期
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString* date = [formatter stringFromDate:[NSDate date]];
    //城市
    //[cityLabel setText:xbody.currentCity];
    NSString* theCityStr = [xbody checkNull:xbody.currentCity];
    NSString* theProvinceStr = [xbody checkNull:xbody.currentProvince];
    
    if ([theProvinceStr isEqualToString: theCityStr]) {
        [cityLabel setText:[NSString stringWithFormat:@"%@ %@%@",date,localizedString.T_CURRENT_CITY,theCityStr]];
    }else{
        [cityLabel setText:[NSString stringWithFormat:@"%@ %@%@%@",date,localizedString.T_CURRENT_CITY,theProvinceStr,theCityStr]];
    }

    //pm2.5质量文字展示
    //pm25TextLabel;
    int value = str.intValue;
    NSString *str2;
    if (value == 0) {
        str2 = @"";
    }else if (value < 50) {
        str2 = localizedString.T_LEVEL1;
    }else if (value < 100) {
        str2 = localizedString.T_LEVEL2;
    }else if (value < 150) {
        str2 = localizedString.T_LEVEL3;
    }else if (value < 200) {
        str2 = localizedString.T_LEVEL4;
    }else if (value < 300) {
        str2 = localizedString.T_LEVEL5;
    }else{
        str2 = localizedString.T_LEVEL6;
    }
    
    if(str == nil || [str length] == 0)
    {
        [pm25TextLabel setText:localizedString.T_NO_DATA];
    }else
    {
        [pm25TextLabel setText:[NSString stringWithFormat:@"%@ %@",localizedString.T_AIR_QUALITY,str2]];
    }
    
    //pm2.5指示颜色对应
    //colorBarTitle;
    //pm2.5影响
//    [affect setText:[xbody.pm25CurrentCityDataDic objectForKey:PM_DATA_AFFECT]];
    //pm2.5空气质量详细参数
    //dataDetailTitle;
}
-(void)viewDidAppear:(BOOL)animated
{
    //self.navigationController.
    //self.navigationItem.prompt = @"self.navigationItem.promptself.navigationItem.promptself.navigationItem.promptself.navigationItem.promptself.navigationItem.prompt";
    
    //[MainTabViewController sharedInstance].navigationItem.title = @"sdfsdfsdfsdfsdf";
    //NSLog(@"PMInformationViewController: %@",self.navigationController);
}

- (IBAction)pm25ButtonClick:(id)sender {
    NSLog(@"pm25ButtonClick");
}
@end
