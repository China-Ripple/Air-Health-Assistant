//
//  InformationViewController.m
//  Air Health Assistant
//
//  Created by xu da on 14-5-21.
//  Copyright (c) 2014年 xu da. All rights reserved.
//

#import "InformationViewController.h"
#import "LocalizedString.h"
#import "XBody.h"

@interface InformationViewController ()

@end

@implementation InformationViewController
//建议图形
@synthesize infImage;
//建议标题
@synthesize infTitle;
//温度
@synthesize infTempValue;
//PM2.5
@synthesize infPM25Value;
//周围烟气状况
@synthesize infDustValue;
//建议地址
@synthesize cityLabel;
//建议空气管理贴士
@synthesize airSugguestTitle;
//建议对健康的影响
@synthesize affectLabel;
//建议采取的措施
@synthesize actionLabel;
//建议环境建议
@synthesize weatherSugguestTitle;
//建议天气运动指数
@synthesize sportIndex;
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
    LocalizedString *localizedString = [LocalizedString getInstance];
    // Do any additional setup after loading the view from its nib.
    XBody *xbody = [XBody getInstance];
    //字体
    //建议图形
    //建议标题
    [infTitle setFont:xbody.bigTitleFont];
    [infTitle setText:localizedString.IMPROVE];
    

    //温度
    [infTempValue setFont:xbody.textFont];
    
    //PM2.5
    [infPM25Value setFont:xbody.textFont];
    //周围烟气状况
    [infDustValue setFont:xbody.textFont];
    [infDustValue setText:localizedString.DUST_STATE];
   
    //建议地址
    [cityLabel setFont:xbody.smallFont];
    //建议空气管理贴士
    [airSugguestTitle setFont:xbody.titleFont];
    [airSugguestTitle setText:localizedString.AIR_ENVIRONMENT_PROPOSE];
    //建议对健康的影响
    [affectLabel setFont:xbody.textFont];
    [affectLabel setText:localizedString.HEALTHY_AFFECT_CONDITION];
    //建议采取的措施
    [actionLabel setFont:xbody.textFont];
    [actionLabel setText:localizedString.PROPOSE_ACTION_MEASURES];
    
    //建议环境建议
    [weatherSugguestTitle setFont:xbody.titleFont];
    [weatherSugguestTitle setText:localizedString.AIR_ENVIRONMENT_PROPOSE];
    
    //建议天气运动指数
    [sportIndex setFont:xbody.textFont];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    LocalizedString *localizedString = [LocalizedString getInstance];
    self.navigationItem.title = localizedString.PAGE_INFORMATION;
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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)refreshData
{
    XBody *xbody = [XBody getInstance];
    NSMutableDictionary *weather = [XBody getWeather];
    LocalizedString * localizedString = [LocalizedString getInstance];
    //建议图形
    //建议标题
    //温度
    NSString *temp = [NSString stringWithFormat:@"%@: %@ ℃",localizedString.WEATHER_TEMP,[xbody checkNull:[weather objectForKey:WEATHER_TEMP]]];
    [infTempValue setText:temp];
    //PM2.5
    NSString *pm25Value = [xbody checkNull:[xbody.pm25CurrentCityDataDic objectForKey:PM_DATA_PM2_5_1H]];
    [infPM25Value setText:[NSString stringWithFormat:@"PM2.5: %@ ug/m³",pm25Value]];
    //周围烟气状况
    [infDustValue setText:[NSString stringWithFormat:@"周围烟气状况: Level %ld",xbody.airQualityDetector]];
    //建议地址
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
    //建议空气管理贴士
    //建议对健康的影响
    NSString *str_a1 = [xbody checkNull:[xbody.pm25CurrentCityDataDic objectForKey:PM_DATA_AFFECT]];
    NSString *str_a2 = [xbody checkNull:[xbody.pm25CurrentCityDataDic objectForKey:PM_DATA_ACTION]];

    [affectLabel setText:[NSString stringWithFormat:@"%@: \n%@",localizedString.HEALTHY_AFFECT_CONDITION,str_a1]];
    //建议采取的措施
    [actionLabel setText:[NSString stringWithFormat:@"%@: \n%@",localizedString.PROPOSE_ACTION_MEASURES,str_a2]];
    //建议环境建议
    //建议天气运动指数
    /*
     （1）K=0时为1级，表示气象条件很差，不适宜户外体育运动，可适当进行户内体育运动，如篮球、网球、乒乓球等；
     （2）K=1时为2级，表示气象条件较差，不太适宜户外体育运动，可进行户内体育运动，如篮球、网球、乒乓球等；
     （3）K=2或K=4时为3级，表示气象条件一般，比较适宜户外体育运动，可增加户外体育运动，如球类运动、田赛、径赛等；
     （4）K=8时为4级，表示气象条件好，适宜户外体育运动，如球类运动、田赛、径赛、射击等；
     （5）K=16时为5级，表示气象条件非常好，为最佳户外体育运动时期，适宜各种户外体育运动。
     */
    switch ([xbody getSportLevel]) {
        case 1:
            [sportIndex setText:@"当前气象条件很差，不适宜户外体育运动，可适当进行户内体育运动，如篮球、网球、乒乓球等"];
            break;
        case 2:
            [sportIndex setText:@"当前气象条件较差，不太适宜户外体育运动，可进行户内体育运动，如篮球、网球、乒乓球等"];
            break;
        case 3:
            [sportIndex setText:@"当前气象条件一般，比较适宜户外体育运动，可增加户外体育运动，如球类运动、田赛、径赛等"];
            break;
        case 4:
            [sportIndex setText:@"当前气象条件好，适宜户外体育运动，如球类运动、田赛、径赛、射击等"];
            break;
        case 5:
            [sportIndex setText:@"当前气象条件非常好，为最佳户外体育运动时期，适宜各种户外体育运动"];
            break;
        default:
            break;
    }
}
@end
