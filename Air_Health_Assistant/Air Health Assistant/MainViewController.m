//
//  MainViewController.m
//  Air Health Assistant
//
//  Created by xu da on 14-5-4.
//  Copyright (c) 2014年 xu da. All rights reserved.
//

#import "MainViewController.h"
#import "PMInformationViewController.h"
#import "WeatherViewController.h"
#import "DeviceViewController.h"
#import "CityViewController.h"
#import "InformationViewController.h"
#import "MainTabViewController.h"
#import "JSON.h"
#import "XBody.h"
#import "LocalizedString.h"
#import "HttpConnectionLogic.h"
#import "MMLocationManager.h"
#import "SettingViewController.h"
#import "WindowManager.h"
#import "MyBleService.h"
#import "CitySearchController.h"
#import "MyTableViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController
@synthesize mainTabViewController;
@synthesize pm25Button;
@synthesize weatherButton;
@synthesize deviceButton;
@synthesize citySelectButton;
@synthesize informationButton;
@synthesize dustButton;

@synthesize pm25ActivityIndicator;
@synthesize weatherActivityIndicator;

@synthesize pm25URLRequest;
@synthesize weatherURLRequest;

@synthesize frameView;

@synthesize pm25ButtonDes;
@synthesize weatherButtonDes;
@synthesize deviceButtonDes;
@synthesize citySelectButtonDes;
@synthesize informationButtonDes;
@synthesize dustButtonDes;

NSString *pm25String;
NSString *pm25CityString;
NSString *pm25TokenString;
//NSString *weatherString;
//NSString *weatherCityCode;

NSURLConnection *pm25Connection;
//NSURLConnection *weatherConnection1;
//NSURLConnection *weatherConnection2;
//WeatherViewController *weatherDetailViewController;
//PMInformationViewController *pmInformationViewController;
//DeviceViewController *deviceViewController;

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
    
    
    LocalizedString *localizedString = [LocalizedString getInstance];
    // Do any additional setup after loading the view from its nib.
    //[[RtBleNvcService sharedInstance]initCiGate];
    
    [MMLocationManager shareLocation].cityDelegate = self;

    // UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"background.png"]];
    
    // [self.view addSubview:imageView];
    
    //http连接
    HttpConnectionLogic *httpConnectionLogic = [HttpConnectionLogic getInstance];
    [httpConnectionLogic init:self];
    //窗口管理
    WindowManager *windowManager = [WindowManager getInstance];
    [windowManager initWithDelegate:self];
    
    //主体类
    XBody *xbody = [XBody getInstance];
    
    if([xbody gpsSwitch] == 0 && (xbody.currentCity == nil || [xbody.currentCity isEqual:@""])){
        xbody.currentCity = nil;
        //start gps location
        [self locateCity];
    }
    else
    {
        if (xbody.currentCityCode != nil) {
            [httpConnectionLogic loadWeather];
        }
        
        [self loadPM25];
    }
    [weatherActivityIndicator startAnimating];
    
    /*
    [pm25Button setBackgroundColor:[UIColor colorWithRed:55.0/255 green:55.0/255 blue:99.0/255 alpha:0.2]];
    [weatherButton setBackgroundColor:[UIColor colorWithRed:55.0/255 green:55.0/255 blue:99.0/255 alpha:0.2]];
    [deviceButton setBackgroundColor:[UIColor colorWithRed:55.0/255 green:55.0/255 blue:99.0/255 alpha:0.2]];
    [citySelectButton setBackgroundColor:[UIColor colorWithRed:55.0/255 green:55.0/255 blue:99.0/255 alpha:0.2]];
    [informationButton setBackgroundColor:[UIColor colorWithRed:55.0/255 green:55.0/255 blue:99.0/255 alpha:0.2]];
    */
    //6个按钮
    [pm25Button setBackgroundImage:[UIImage imageNamed:@"main_button_background.png"] forState:UIControlStateNormal];
    [weatherButton setBackgroundImage:[UIImage imageNamed:@"main_button_background.png"] forState:UIControlStateNormal];
    [deviceButton setBackgroundImage:[UIImage imageNamed:@"main_button_background.png"] forState:UIControlStateNormal];
    [citySelectButton setBackgroundImage:[UIImage imageNamed:@"main_button_background.png"] forState:UIControlStateNormal];
    [informationButton setBackgroundImage:[UIImage imageNamed:@"main_button_background.png"] forState:UIControlStateNormal];
    [dustButton setBackgroundImage:[UIImage imageNamed:@"main_button_background.png"] forState:UIControlStateNormal];
    
    [xbody setPm25State_2:STATE_START];
    [xbody setWeatherState_2:STATE_START];
    //[informationButton.information setText:@"信息：\n 上海荣泰 空气健康助手 app"];

    //self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"m_setting"] style:UIBarButtonItemStylePlain target:self action:@selector(settingButtonClicked)];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [button setBackgroundImage:[UIImage imageNamed:@"m_setting"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(settingButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = btn;
    
    //UI signal
    //xbody.shouldUpdate_main_pm25 = YES;
    //xbody.shouldUpdate_main_weather = YES;
    xbody.shouldUpdate_main_device = YES;
    xbody.shouldUpdate_main_city = YES;
    //xbody.shouldUpdate_main_information = YES;
    //蓝牙初始化
    [MyBleService getInstance];
    
    //test
    /*
    NSArray *familyNames = [[NSArray alloc] initWithArray:[UIFont familyNames]];
    NSArray *fontNames;
    NSInteger indFamily, indFont;
    for(indFamily=0;indFamily<[familyNames count];++indFamily)
    {
        NSLog(@"Family name: %@", [familyNames objectAtIndex:indFamily]);
        fontNames =[[NSArray alloc]initWithArray:[UIFont fontNamesForFamilyName:[familyNames objectAtIndex:indFamily]]];
        for(indFont=0; indFont<[fontNames count]; ++indFont)
        {
            NSLog(@" Font name: %@",[fontNames objectAtIndex:indFont]);
        }
    }*/
    
    //字体
    [pm25Button.information setFont:xbody.textFont];
    [weatherButton.information setFont:xbody.textFont];
    
    [deviceButton.information setFont:xbody.textFont];
    [citySelectButton.information setFont:xbody.textFont];
    [informationButton.information setFont:xbody.textFont];
    [dustButton.information setFont:xbody.textFont];
    [dustButton.information setText:@""];
    
    
  
    
    [pm25ButtonDes setFont:xbody.titleFont];
    [pm25ButtonDes setText:localizedString.PAGE_PM25_DETAIL];
    
    [weatherButtonDes setFont:xbody.titleFont];
    [weatherButtonDes setText:localizedString.PAGE_WEATHER_DETAIL];
    
    [deviceButtonDes setFont:xbody.titleFont];
    [deviceButtonDes setText:localizedString.PAGE_DEVICE];
    
    [citySelectButtonDes setFont:xbody.titleFont];
    [citySelectButtonDes setText:localizedString.PAGE_CITY_SELECT];
    
    [informationButtonDes setFont:xbody.titleFont];
    [informationButtonDes setText:localizedString.PAGE_INFORMATION];
    
    [dustButtonDes setFont:xbody.titleFont];
    [dustButtonDes setText:localizedString.PAGE_DUST_DETAIL];
    
    //self.navigationController.tabBarItem.image = [UIImage imageNamed:@"tabbar_item.png"];
    /*
    UIImage *image = [UIImage imageNamed:@"system_tabbar_bg.png"];
    //[self.tabBar setBackgroundImage:image];
    
    self.tabBarController.tabBar.backgroundImage = [UIImage imageNamed:@"navigationbar_background.png"];
    self.tabBarController.tabBar.selectionIndicatorImage = [UIImage imageNamed:@"tabbar_item.png"];*/
/*
 UIView * selView = [tabBarSubviews objectAtIndex:index4SelView];
 
 NSArray * selViewSubviews = [selView subviews];
 
 for(UIView * v in selViewSubviews)
 {
 if(v && [NSStringFromClass([v class]) isEqualToString:@"UITabBarSelectionIndicatorView"])
 
 {//the v is the highlight view.
 [self.selectedItemBgImageView removeFromSuperview];
 [selView insertSubview:self.selectedItemBgImageView belowSubview:v];
 
 [v removeFromSuperview];
 */
    
    /**
     * @zhongqihong
     **/

    self.navigationController.title =localizedString.PAGE_MAIN;
     self.navigationItem.title =localizedString.PAGE_MAIN;
    
    
    
    int lan = [[XBody getInstance] getCurrentLanguage];
    
    if(lan == 1){

        [pm25Button setEnabled: false];
        [informationButton setEnabled:false];
        [dustButton setEnabled:false];
         [self disableOtherTabs];
    }
    
    
    
    /********/
}

#pragma CityDelegate
-(void)cityChanged
{
    NSLog(@"cityChanged");
    //匹配 [XBody getInstance].currentCity 设置 [XBody getInstance].currentCityCode_pm25
    XBody *xbody = [XBody getInstance];
    //如果为空，则当前城市无信息
    [xbody setCurrentCityCode_pm25_2:xbody.currentCity];
    //pm25 & weather
    HttpConnectionLogic *httpConnectionLogic = [HttpConnectionLogic getInstance];
    [httpConnectionLogic loadWeather];
    [self loadPM25];
    //在city处理类中操作数据(gps定位，手动选择)，UI更新信息在此设置
    xbody.shouldUpdate_main_city = YES;
    NSLog(@"code:%@,city:%@",xbody.currentCityCode,xbody.currentCity);
    //保存数据
    NSUserDefaults *standard = [NSUserDefaults standardUserDefaults];
    [standard setObject:[XBody getInstance].currentCityCode forKey:DATA_CURRENT_CITY_CODE];
    [standard setObject:[XBody getInstance].currentCity forKey:DATA_CURRENT_CITY];
    [standard setObject:[XBody getInstance].currentProvince forKey:DATA_CURRENT_PROVINCE];
    [standard setObject:[XBody getInstance].currentCityCode_pm25 forKey:DATA_CURRENT_CITY_CODE_PM25];
    [standard synchronize];
    
    
     NSLog(@"reset  city info ................code:%@,city:%@",xbody.currentCityCode,xbody.currentCity);
}

-(void)loadPM25{
    //get data
    if ([XBody getInstance].currentCityCode_pm25 != nil) {
        [[HttpConnectionLogic getInstance] loadPM25];
    }else{
        [[XBody getInstance] setPm25State_2:STATE_DATA_ERROR];
    }
}

#pragma City gps delegate
-(void)gpsDataRecieved
{
    NSLog(@"gpsDataRecieved");
}

-(void)viewDidAppear:(BOOL)animated
{
    // NSLog(@"mainViewController: %@",self.navigationController);
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [[self.tabBarController tabBar] setHidden:NO];
    
    
    
    LocalizedString *localizedString = [LocalizedString getInstance];
    self.navigationItem.title = localizedString.PAGE_MAIN;
    //[self.navigationController.navigationBar setBackgroundImage:image forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    //[self.tabBarController.tabBar setBackgroundImage:[UIImage imageNamed:TABBAR_BACKGROUND]];
    //self.tabBarController.tabBar.selectionIndicatorImage = [UIImage imageNamed:TABBAR_SELECTION_IMAGE];
    //分页栏
    UIImage *imageTB = [UIImage imageNamed:TABBAR_BACKGROUND];
    UIImage *stretchedImageTB = [imageTB stretchableImageWithLeftCapWidth:1 topCapHeight:1];
    [self.tabBarController.tabBar setBackgroundImage:imageTB];
    
  
    
    UIImage *imageS = [UIImage imageNamed:TABBAR_SELECTION_IMAGE];
    //UIImage *stretchedImageS = [imageS stretchableImageWithLeftCapWidth:1 topCapHeight:1];
    self.tabBarController.tabBar.selectionIndicatorImage = imageS;
    self.tabBarController.tabBar.tintColor = [UIColor whiteColor];
    //无效 self.tabBarController.tabBar.selectedImageTintColor = [UIColor greenColor];
    //无效 self.tabBarController.tabBar.barTintColor = [UIColor redColor];
    //设置导航栏背景
    UIImage *image = [UIImage imageNamed:NAVIGATIONBAR_BACKGROUND];
    UIImage *stretchedImage = [image stretchableImageWithLeftCapWidth:10 topCapHeight:5];
    [self.navigationController.navigationBar setBackgroundImage:stretchedImage forBarMetrics:UIBarMetricsDefault];
    //导航栏字体颜色，back按钮的颜色
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    //-------------------------------test-----------------------------------------
    /*
     还是会改变,开放类不好用
    //自定义标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0 , 100, 44)];
    titleLabel.backgroundColor = [UIColor redColor];  //设置Label背景透明
    titleLabel.font = [UIFont boldSystemFontOfSize:20];  //设置文本字体与大小
    titleLabel.textColor = [UIColor colorWithRed:(0.0/255.0) green:(255.0 / 255.0) blue:(0.0 / 255.0) alpha:1];  //设置文本颜色
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"自定义标题";  //设置标题
    self.navigationItem.titleView = titleLabel;*/
    //------------------------------------------------------------------------
    /*
    [self.navigationController.navigationBar  setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                     [UIColor colorWithRed:0 green:0.7 blue:0.8 alpha:1], UITextAttributeTextColor,
                                                                      nil]];*/
    
    //self.navigationController.navigationBar
    //[self.navigationController.navigationBar.backItem.titleView setTintColor:[UIColor whiteColor]];
    //缩放
    XBody *xbody = [XBody getInstance];
    if (xbody.currentDeviceType == XDeviceTypeIPhone4) {
        [self.frameView setFrame:CGRectMake(0,IPHONE4_MAIN_Y,320,IPHONE4_MAIN_HEIGHT)];
    }else if(xbody.currentDeviceType == XDeviceTypeIPhone5) {
        [self.frameView setFrame:CGRectMake(0,IPHONE5_MAIN_Y,320,IPHONE5_MAIN_HEIGHT)];
    }else if(xbody.currentDeviceType == XDeviceTypeIPad) {
        [self.frameView setFrame:CGRectMake(IPAD_MAIN_X,IPAD_MAIN_Y,IPAD_MAIN_WIDTH,IPAD_MAIN_HEIGHT)];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    //[[NSNotificationCenter defaultCenter] removeObserver:self name:WeatherDataReceivedNotification object:nil];
    //[[NSNotificationCenter defaultCenter] removeObserver:self name:PM25DataReceivedNotification object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-------------------------------------天气类http处理响应，UI更新相关-------------------------------------
#pragma connection delegate
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [[HttpConnectionLogic getInstance] connection:connection didReceiveData:data];
    //[self showWeather];
}

- (void)connection:(NSURLConnection *)connection
  didFailWithError: (NSError *)error {
    [[HttpConnectionLogic getInstance] connection:connection didFailWithError:error];
}

- (void)connectionDidFinishLoading: (NSURLConnection*) connection {
    [[HttpConnectionLogic getInstance] connectionDidFinishLoading:connection];
}
//-----------------------------------------------------------------------------------------------------


-(void)pm25DataReceived:(id)sender
{
    //发送收到数据通知,关闭pm25ActivityIndicator动画
    //[self.pm25ActivityIndicator stopAnimating];

    //[self performSelectorOnMainThread:@selector(updateUI_showPM25)withObject:nil waitUntilDone:YES];
    [[XBody getInstance] setPm25State_2:STATE_STOP];
}

- (void)updateUI_showPM25
{
    NSLog(@"updateUI_showPM25");
}

/*
 “weatherinfo”: {
 “city”: “北京”, // 城市中文名
 “cityid”: “101010100″, // 城市 ID
 “temp”: “24″, // 温度
 “WD”: “西南风”, // 风向
 “WS”: “1级”, // 风力
 “SD”: “92%”, // 湿度
 “WSE”: “1″, // ?
 “time”: “19:15″, // 发布时间
 “isRadar”: “1″, // 是否有雷达图
 “Radar”: “JC_RADAR_AZ9010_JB” // 雷达图编号，雷达图的地址在 http://www.weather.com.cn/html/radar/雷达图编号.shtml
 }
 }
 还有一个接口http://www.weather.com.cn/data/cityinfo/101010100.html 这个接口返回的数据如下。
 
 {
 “weatherinfo”: {
 “city”: “北京”, // 城市中文名
 “cityid”: “101010100″, // 城市 ID
 “temp1″: “22℃”, // ?
 “temp2″: “31℃”, // ?
 “weather”: “阴转晴”, // 天气
 “img1″: “n2.gif”, // ? 天气图标编号
 “img2″: “d0.gif”, // ? 天气图标编号
 “ptime”: “18:00″ // 发布时间
 */
#pragma button click
- (IBAction)pm25ViewButtonClick:(id)sender {
    NSLog(@"pm25ViewButtonClick");
    
    //获取数据为空时,重新获取数据
    NSString *str = [[XBody getInstance].pm25CurrentCityDataDic objectForKey:PM_DATA_PM2_5_1H];
    if(str == nil || [str length] == 0){
        NSLog(@"retry loadPM25");
        [self loadPM25];
    }
    [[WindowManager getInstance] showPM25DetailView:self];
/*
    if (pmInformationViewController == nil) {
        NSString *pmInformationViewNib = nil;
        //if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        pmInformationViewNib = @"PMInformationView";
        //}else {
        //    pmInformationViewNib = @"PMInformationView";
        //}
        // Do any additional setup after loading the view from its nib.
        pmInformationViewController = [[PMInformationViewController alloc] initWithNibName:pmInformationViewNib bundle:nil];
    }
    //隐藏tabbar
    [[self.tabBarController tabBar] setHidden:YES];
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:pmInformationViewController animated:YES];
 */
    //[mainTabViewController showState];
}
- (IBAction)weatherViewButtonClick:(id)sender{
    NSLog(@"weatherViewButtonClick");
    //获取数据为空时,重新获取数据
    XBody *xbody = [XBody getInstance];
    if(xbody.weatherState == STATE_DATA_ERROR)
    {
        NSLog(@"retry loadWeather");
        [[HttpConnectionLogic getInstance] loadWeather];
    }

    [[WindowManager getInstance] showWeatherDetailView:self];

    /*
    //WeatherViewController *weatherDetailViewController;
    if (weatherDetailViewController == nil) {
        NSString *weatherViewNib = nil;
        //if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        weatherViewNib = @"WeatherViewController";
        //}else {
        //    weatherDetailViewNib = @"WeatherViewController";
        //}
        weatherDetailViewController = [[WeatherViewController alloc] initWithNibName:weatherViewNib bundle:nil];
        //set delegate
        weatherDetailViewController.weatherDelegate = self;
    }
    [[self.tabBarController tabBar] setHidden:YES];
    [self.navigationController pushViewController:weatherDetailViewController animated:YES];*/
}
- (IBAction)deviceViewButtonClick:(id)sender{
    NSLog(@"deviceViewButtonClick");
    [[WindowManager getInstance] showDeviceView:self];
}
- (IBAction)cityViewButtonClick:(id)sender{
    NSLog(@"cityViewButtonClick");
    
    int rel =[[XBody getInstance] getCurrentLanguage];
    if(rel != 1){
        
            CityViewController *cityViewController;
            if (cityViewController == nil) {
                NSString *cityViewNib = nil;
                //if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
                cityViewNib = @"CityViewController";
                //}else {
                //    cityViewNib = @"CityViewController";
                //}
                cityViewController = [[CityViewController alloc] initWithNibName:cityViewNib bundle:nil];
                cityViewController.cityDelegate = self;
            }
            [[self.tabBarController tabBar] setHidden:YES];
            [self.navigationController pushViewController:cityViewController animated:YES];

    }
    
    else{
        
        
        MyTableViewController *cityViewController ;
        //=[[MyTableViewController alloc]init];
        if (cityViewController == nil) {
            NSString *cityViewNib = nil;
            //if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            cityViewNib = @"MyTableViewController";
            //}else {
            //    cityViewNib = @"CityViewController";
            //}
            cityViewController = [[MyTableViewController alloc] initWithNibName:cityViewNib bundle:nil];
            cityViewController.cityDelegate = self;
        }
        [[self.tabBarController tabBar] setHidden:YES];
        [self.navigationController pushViewController:cityViewController animated:YES];
        
        
//        GlobalCityViewController *cityViewController ;
//        //=[[MyTableViewController alloc]init];
//        if (cityViewController == nil) {
//            NSString *cityViewNib = nil;
//            //if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
//            cityViewNib = @"GlobalCityViewController";
//            //}else {
//            //    cityViewNib = @"CityViewController";
//            //}
//            cityViewController = [[GlobalCityViewController alloc] initWithNibName:cityViewNib bundle:nil];
//            cityViewController.globalCitySearchCtrl. cityDelegate = self;
//        }
//        [[self.tabBarController tabBar] setHidden:YES];
//        [self.navigationController pushViewController:cityViewController animated:YES];
//
//        NSLog(@"self.navigationController==%@",self.navigationController);

        
    }
    
    
    
    
}
- (IBAction)informationViewButtonClick:(id)sender{
    NSLog(@"informationViewButtonClick");
    [[WindowManager getInstance] showInformationView:self];
/*
    InformationViewController *informationViewController;
    if (informationViewController == nil) {
        NSString *informationViewNib = nil;
        //if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        informationViewNib = @"InformationViewController";
        //}else {
        //    pmInformationViewNib = @"PMInformationView";
        //}
        informationViewController = [[InformationViewController alloc] initWithNibName:informationViewNib bundle:nil];
    }
    [[self.tabBarController tabBar] setHidden:YES];
    [self.navigationController pushViewController:informationViewController animated:YES];*/
}
- (IBAction)dustViewButtonClick:(id)sender{
    NSLog(@"dustViewButtonClick");
    [[WindowManager getInstance] showDustView:self];
}
- (void)settingButtonClicked
{
    [[WindowManager getInstance]showSettingView:self];
}
#pragma locateCity
- (void)locateCity
{
    NSLog(@"locateCity");
    [[MMLocationManager shareLocation]gpsLocateCity];
}
-(void)disableOtherTabs{
    
    UITabBar *myTb=self.tabBarController.tabBar;
    for(UITabBarItem *utb in myTb.items)
    {
        if( ![utb.title isEqualToString:@"Main"] )
        {
            utb.enabled=NO;
        }
        else {
            utb.enabled=YES;
            self.tabBarController.selectedIndex=0;
        }
    }
    


}
/*
#define SR_TIME_OUT_INTERVAL 10
//pm25的连接方式
-(void)httpCreate_PM25:(NSString *)URLString
{
    [pm25ActivityIndicator startAnimating];
    //STEP 1： 创建URL
    NSURL *finalURL = [NSURL URLWithString:[URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    //STEP 2：创建URLRequest
    pm25URLRequest = [[NSMutableURLRequest alloc]initWithURL:finalURL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:SR_TIME_OUT_INTERVAL];
    //如果是GET
    [pm25URLRequest setHTTPMethod:@"GET"];
    //STEP 3：通过NSURLConnection实现请求
    //一般有两种方式，如果不需要知道请求的进度，比如文字上传，那么用简单的异步请求。如下：
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    NSLog(@"sendAsynchronousRequest URLRequest URL %@",[pm25URLRequest URL]);
    [NSURLConnection sendAsynchronousRequest:self.pm25URLRequest queue:queue completionHandler:^(NSURLResponse*response,NSData *data,NSError *error)
     {
         //NSLog(@"sendAsynchronousRequest,response:%@,data:%@",response,data);
         pm25String = [[NSString alloc] initWithData:data encoding: NSUTF8StringEncoding];
         //pm25String = @"{\"city\":\"北京\",\"cityid\":\"101010100\"}";
         NSLog(@"sendAsynchronousRequest connection didReceiveData %@", pm25String);
         //
         @try {
             //初始化变量
             NSRegularExpression *reg_space = [NSRegularExpression regularExpressionWithPattern:@"[\\s]" options:NSRegularExpressionCaseInsensitive error:nil];
             
             //获取PM2.5参数数据
             NSString * patten_value = [NSString stringWithFormat:@"<div class\\s?=\\s?\"value\">(.|[\r\n])*?</div>"];
             NSString * patten_tagName = [NSString stringWithFormat:@"<div class\\s?=\\s?\"caption\">(.|[\r\n])*?</div>"];
             NSString * patten = [NSString stringWithFormat:@"%@\\s*?%@",patten_value,patten_tagName];
             NSString * patten_value_data = [NSString stringWithFormat:@"(?<=<div class\\s?=\\s?\"value\">)(.|[\r\n])*?(?=\\n*</div>)"];
             NSString * patten_tagName_data = [NSString stringWithFormat:@"(?<=<div class\\s?=\\s?\"caption\">)(.|[\r\n])*?(?=\\n*</div>)"];
             NSArray *arr = [[XBody getInstance]regularMatch:pm25String patten:patten];
             for (NSString* str in arr) {
                 NSArray *arr_value = [[XBody getInstance]regularMatch:str patten:patten_value_data];
                 NSArray *arr_tagName = [[XBody getInstance]regularMatch:str patten:patten_tagName_data];
                 NSMutableString * value = [[NSMutableString alloc]initWithString:[arr_value objectAtIndex:0]];
                 NSMutableString * tagName = [[NSMutableString alloc]initWithString:[arr_tagName objectAtIndex:0]];
                 [reg_space replaceMatchesInString:value options:NSMatchingReportCompletion range:NSMakeRange(0, [value length]) withTemplate:@""];
                 [reg_space replaceMatchesInString:tagName options:NSMatchingReportCompletion range:NSMakeRange(0, [tagName length]) withTemplate:@""];
                 [[XBody getInstance].pm25CurrentCityDataDic setValue:value forKey:tagName];
                 
             }
             //获取时间
             NSString * patten_live_data_time = [NSString stringWithFormat:@"<div class\\s?=\\s?\"live_data_time\">(.|[\r\n])*?</div>"];
             NSString * patten_live_time_str = [NSString stringWithFormat:@"([\\d]{4})-([\\d]{2})-([\\d]{2}) ([\\d]{2}):([\\d]{2})"];
             NSArray *arr_time = [[XBody getInstance]regularMatch:pm25String patten:patten_live_data_time];
             NSArray *arr_time_str = [[XBody getInstance]regularMatch:[arr_time objectAtIndex:0] patten:patten_live_time_str];
             [[XBody getInstance].pm25CurrentCityDataDic setValue:[arr_time_str objectAtIndex:0] forKey:@"live_data_time"];
             //<p>对健康影响情况：
             NSString * patten_health_affect = [NSString stringWithFormat:@"(?<=<p>对健康影响情况：)(.|[\r\n])*?(?=\\n*</p>)"];
             NSArray *arr_health_affect = [[XBody getInstance]regularMatch:pm25String patten:patten_health_affect];
             NSMutableString * health_affect = [[NSMutableString alloc]initWithString:[arr_health_affect objectAtIndex:0]];
             [reg_space replaceMatchesInString:health_affect options:NSMatchingReportCompletion range:NSMakeRange(0, [health_affect length]) withTemplate:@""];
             [[XBody getInstance].pm25CurrentCityDataDic setValue:health_affect forKey:PM_DATA_AFFECT];
             //<p>建议采取的措施：
             NSString * patten_health_action = [NSString stringWithFormat:@"(?<=<p>建议采取的措施：)(.|[\r\n])*?(?=\\n*</p>)"];
             NSArray *arr_health_action = [[XBody getInstance]regularMatch:pm25String patten:patten_health_action];
             NSMutableString * health_action = [[NSMutableString alloc]initWithString:[arr_health_action objectAtIndex:0]];
             
             [reg_space replaceMatchesInString:health_action options:NSMatchingReportCompletion range:NSMakeRange(0, [health_action length]) withTemplate:@""];
             [[XBody getInstance].pm25CurrentCityDataDic setValue:health_action forKey:PM_DATA_ACTION];
             
         }
         @catch (NSException *exception) {
             NSLog(@"match exception");
         }
         NSLog(@"pm25CurrentCityDic:%@",[XBody getInstance].pm25CurrentCityDataDic);
     }];
}*/
@end