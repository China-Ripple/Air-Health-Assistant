//
//  WeatherViewController.m
//  Air Health Assistant
//
//  Created by xu da on 14-5-21.
//  Copyright (c) 2014年 xu da. All rights reserved.
//

#import "WeatherViewController.h"
#import "XBody.h"
#import "Const.h"
#import "LocalizedString.h"
#import "HttpConnectionLogic.h"

@interface WeatherViewController ()

@end

@implementation WeatherViewController
@synthesize weatherDelegate;
//天气图形
@synthesize weatherImage;
//天气标题
@synthesize weatherTitle;
//天气数值
@synthesize weatherValue;
//天气单位
@synthesize weatherUnit;
//城市
@synthesize cityLabel;
//天气文字展示
@synthesize weatherDataTextLabel;
//当日天气详情
@synthesize weatherDetailDes;
//最高温度title，内容
@synthesize weatherTempHighTitle;
@synthesize weatherTempHighContent;
//最低温度
@synthesize weatherTempLowTitle;
@synthesize weatherTempLowContent;
//风力
@synthesize weatherWDTitle;
@synthesize weatherWDContent;
//风向
@synthesize weatherWSTitle;
@synthesize weatherWSContent;
//湿度
@synthesize weatherSDTitle;
@synthesize weatherSDContent;
//天气情况建议
@synthesize weatherSuggestTitle;
//穿衣指数
@synthesize weatherSuggestContent;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    LocalizedString *localizedString = [LocalizedString getInstance];
    //设置字体
    XBody *xbody = [XBody getInstance];
    //天气图形
    //天气标题
    [weatherTitle setFont:xbody.bigTitleFont];
    [weatherTitle setText:localizedString.WEATHER_TITLE];
    
    //天气数值
    [weatherValue setFont:xbody.bigTextFont];
    //天气单位
    [weatherUnit setFont:xbody.midTextFont];
    //城市
    [cityLabel setFont:xbody.smallFont];
    //天气文字展示
    [weatherDataTextLabel setFont:xbody.titleFont];
    //当日天气详情
    [weatherDetailDes setFont:xbody.titleFont];
    [weatherDetailDes setText:localizedString.PAGE_WEATHER_DETAIL];
    //最高温度title，内容
    [weatherTempHighTitle setFont:xbody.titleFont];
    [weatherTempHighTitle setText:localizedString.PAGE_TEMP_MAX];
    
    
    [weatherTempHighContent setFont:xbody.textFont];
    //最低温度
    [weatherTempLowTitle setFont:xbody.titleFont];
    [weatherTempLowTitle setText:localizedString.PAGE_TEMP_MIN];
    [weatherTempLowContent setFont:xbody.textFont];
    //风力
    [weatherWDTitle setFont:xbody.titleFont];
     [weatherWDTitle setText:localizedString.WIND_POWER];
    [weatherWDContent setFont:xbody.textFont];
    //风向
    [weatherWSTitle setFont:xbody.titleFont];
    [weatherWSTitle setText:localizedString.WIND_DIRECTION];
    [weatherWSContent setFont:xbody.textFont];
    
    //湿度
    [weatherSDTitle setFont:xbody.titleFont];
    [weatherSDTitle setText:localizedString.WEATHER_HUMIDITY];
    [weatherSDContent setFont:xbody.textFont];
    //天气情况建议
    [weatherSuggestTitle setFont:xbody.titleFont];
       [weatherSuggestTitle setText:localizedString.SUGGESTION];
    //穿衣指数
    [weatherSuggestContent setFont:xbody.textFont];
}

-(void)viewWillAppear:(BOOL)animated
{
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_sessionDataReceived:) name: WeatherDataReceivedNotification object:nil];
    //[[HttpConnectionLogic getInstance] loadPM25];
    [self refreshData];
    LocalizedString *localizedString = [LocalizedString getInstance];
    self.navigationItem.title = localizedString.PAGE_WEATHER_DETAIL;
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
    //[[NSNotificationCenter defaultCenter] removeObserver:self name: WeatherDataReceivedNotification object:nil];
}
/*
-(void)_sessionDataReceived:(id)sender
{
    [self refreshData];
}*/

UIImageView *imageView;
NSString *IMAGE_URL;

- (void)downloadImage
{
    NSURL *imageUrl = [NSURL URLWithString:IMAGE_URL];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
    imageView.image = image;
}


-(void)refreshData
{
    NSLog(@"refreshData");
    XBody *xbody = [XBody getInstance];
    int lan = [xbody getCurrentLanguage];
    NSMutableDictionary *weather = [XBody getWeather];
    //LocalizedString * localizedString = [LocalizedString getInstance];
    //NSString *city = [NSString stringWithFormat:@"%@",/*localizedString.WEATHER_CITY,*/[xbody checkNull:[weather objectForKey:WEATHER_CITY]]];
    NSString *temp = [NSString stringWithFormat:@"%@",/*localizedString.WEATHER_TEMP,*/[xbody checkNull:[weather objectForKey:WEATHER_TEMP]]];
    NSString *wd = [NSString stringWithFormat:@"%@",/*localizedString.WEATHER_WD,*/[xbody checkNull:[weather objectForKey:WEATHER_WD]]];
    NSString *ws = [NSString stringWithFormat:@"%@",/*localizedString.WEATHER_WS,*/[xbody checkNull:[weather objectForKey:WEATHER_WS]]];
    NSString *sd = [NSString stringWithFormat:@"%@",/*localizedString.WEATHER_SD,*/[xbody checkNull:[weather objectForKey:WEATHER_SD]]];
    NSString *temp1 = [NSString stringWithFormat:@"%@",/*localizedString.WEATHER_TEMP1,*/[xbody checkNull:[weather objectForKey:WEATHER_TEMP1]]];
    NSString *temp2 = [NSString stringWithFormat:@"%@",/*localizedString.WEATHER_TEMP2,*/[xbody checkNull:[weather objectForKey:WEATHER_TEMP2]]];
    NSString *weatherStr = [NSString stringWithFormat:@"%@",/*localizedString.WEATHER_WEATHER,*/[xbody checkNull:[weather objectForKey:WEATHER_WEATHER]]];
    //-------------------------------------------------------------------------------------------------
    //刷新图片
    NSString *path = [[NSBundle mainBundle] pathForResource:@"weatherImgMap" ofType:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
    NSString *imgStrDay = [weather objectForKey:WEATHER_IMG1];
    NSString *imgStrNight = [weather objectForKey:WEATHER_IMG2];
    if (imgStrDay == nil) {
        imgStrDay = @"d31.gif";
    }
    if (imgStrNight == nil) {
        imgStrNight = @"n31.gif";
    }
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"HH"];
    NSString* date = [formatter stringFromDate:[NSDate date]];
    int dataInt = date.intValue;
    NSLog(@"date: %d,%@,%@,imgStrDay:%@",dataInt,date,[NSDate date],imgStrDay);
    
    
    if(lan == 1){
        
        imageView = weatherImage;
        IMAGE_URL = imgStrDay;
        NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
        NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(downloadImage) object:nil];
        [operationQueue addOperation:op];
        
    }
    else{
        if (dataInt > 6 && dataInt < 18) {
            //day
            [weatherImage setImage:[UIImage imageNamed:[dic objectForKey:imgStrDay]]];
        }else{
            //night
            [weatherImage setImage:[UIImage imageNamed:[dic objectForKey:imgStrNight]]];
        }
    }
    

    //------------------------------------------------------------------------------------------------------------
    NSLog(@"%@",[weather objectForKey:WEATHER_IMG1]);
    //[cityLabel setText:city];
    
    //日期
    NSDateFormatter* formatter2 = [[NSDateFormatter alloc]init];
    [formatter2 setDateFormat:@"yyyy-MM-dd"];
    NSString* date2 = [formatter2 stringFromDate:[NSDate date]];
    //城市
    //[cityLabel setText:xbody.currentCity];
    NSString* theCityStr = [xbody checkNull:xbody.currentCity];
    NSString* theProvinceStr = [xbody checkNull:xbody.currentProvince];
    LocalizedString * localizedString = [LocalizedString getInstance];

    if ([theProvinceStr isEqualToString: theCityStr]) {
        [cityLabel setText:[NSString stringWithFormat:@"%@ %@%@",date2,localizedString.T_CURRENT_CITY,theCityStr]];
    }else{
        [cityLabel setText:[NSString stringWithFormat:@"%@ %@%@%@",date2,localizedString.T_CURRENT_CITY,theProvinceStr,theCityStr]];
    }
    [weatherValue setText:temp];
    [weatherWDContent setText:wd];
    [weatherWSContent setText:ws];
    [weatherSDContent setText:sd];
    [weatherTempHighContent setText:temp1];
    [weatherTempLowContent setText:temp2];
    [weatherDataTextLabel setText:weatherStr];
    if(lan == 1){
         [weatherSuggestContent setText:@"Keep healthy"];
    }
    else{
        //穿衣指数
        switch ([xbody getDressingIndex]) {
            case 1:
                [weatherSuggestContent setText:@"夏季着装：短衫、短裙、短裤、薄型T恤衫、敞领短袖棉衫"];
                break;
            case 2:
                [weatherSuggestContent setText:@"夏季着装：短裙、短裤、短套装、T 恤,年老体弱者：单层薄衫裤、薄型棉衫"];
                break;
            case 3:
                [weatherSuggestContent setText:@"春秋过渡装：单层薄衫裤、薄型棉杉,年老体弱者：针织长袖衬衫+背心、长裤、薄型套装"];
                break;
            case 4:
                [weatherSuggestContent setText:@"春秋过渡装：针织长袖衬衫+背心、长裤、薄型套装、牛仔衫裤,年老体弱者，春秋着装：一件薄羊毛衫+夹衣或西服套装"];
                break;
            case 5:
                [weatherSuggestContent setText:@"春秋着装：一件羊毛衫、套装、夹克衫、西服套装、马甲衬衫+夹克衫配长裤,年老体弱者：一件厚羊毛衫+夹衣或风衣"];
                break;
            case 6:
                [weatherSuggestContent setText:@"春秋着装：毛衣、风衣、毛套装、西服套装。年老体弱者：一到两件羊毛衫+大衣或毛套装"];
                break;
            case 7:
                [weatherSuggestContent setText:@"春秋着装：一到两件羊毛衫、大衣、毛套装、皮夹克，年老体弱者，冬季着装：棉衣、冬大衣、皮夹克、内着衬衫或羊毛内衣+毛衣再外罩大衣"];
                break;
            case 8:
                [weatherSuggestContent setText:@"冬季着装：棉衣、冬大衣、皮夹克、内着衬衫或羊毛内衣+毛衣再外罩大衣, 年老体弱者尽量少外出"];
                break;
            default:
                [weatherSuggestContent setText:@""];
                break;
        }

    }
       if (temp == nil || [temp length] == 0) {
        [weatherSuggestContent setText:@""];
    }
}
-(void)viewDidAppear:(BOOL)animated
{
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
