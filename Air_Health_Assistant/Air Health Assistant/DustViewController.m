//
//  DustViewController.m
//  Air Health Assistant
//
//  Created by xu da on 14-8-12.
//  Copyright (c) 2014年 xu da. All rights reserved.
//

#import "DustViewController.h"
#import "LocalizedString.h"
#import "XBody.h"

@interface DustViewController ()

@end

@implementation DustViewController
//烟气图形
@synthesize dustImage;
//烟气标题
@synthesize dustTitle;
//烟气数值
@synthesize dustValue;
//烟气文字展示
@synthesize dustDataTextLabel;
//烟气地址
@synthesize cityLabel;
//污染等级色条
@synthesize dustTextL1;
@synthesize dustTextL2;
@synthesize dustTextL3;
@synthesize dustTextL4;
//当前室内空气指数
@synthesize dustDetailTitle;
//改善建议
@synthesize dustSuggestTitle;
//建议内容
@synthesize dustSuggestContent;
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
    self.navigationItem.title = localizedString.PAGE_DUST_DETAIL;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //字体
    XBody *xbody = [XBody getInstance];
    //烟气标题
    [dustTitle setFont:xbody.bigTitleFont];
    //烟气数值
    [dustValue setFont:xbody.bigTextFont];
    //烟气文字展示
    [dustDataTextLabel setFont:xbody.titleFont];
    //烟气地址
    [cityLabel setFont:xbody.smallFont];
    //污染等级色条
    [dustTextL1 setFont:xbody.textFont];
    [dustTextL2 setFont:xbody.textFont];
    [dustTextL3 setFont:xbody.textFont];
    [dustTextL4 setFont:xbody.textFont];
    //当前室内空气指数
    [dustDetailTitle setFont:xbody.titleFont];
    //改善建议
    [dustSuggestTitle setFont:xbody.titleFont];
    //建议内容
    [dustSuggestContent setFont:xbody.textFont];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)refreshData
{
    XBody *xbody = [XBody getInstance];
    LocalizedString *localizedString = [LocalizedString getInstance];
    //烟气图形
    //烟气数值
    //烟气文字展示
    switch (xbody.airQualityDetector) {
        case 0:
            [dustImage setImage:[UIImage imageNamed:@"dust_icon0.png"]];
            [dustDataTextLabel setText:localizedString.DUST_LEVEL1];
            [dustValue setText:@"L0"];
            [dustValue setTextColor:xbody.dust_level_1_color];
            [dustDataTextLabel setTextColor:xbody.dust_level_1_color];
            break;
        case 1:
            [dustImage setImage:[UIImage imageNamed:@"dust_icon1.png"]];
            [dustDataTextLabel setText:localizedString.DUST_LEVEL2];
            [dustValue setText:@"L1"];
            [dustValue setTextColor:xbody.dust_level_2_color];
            [dustDataTextLabel setTextColor:xbody.dust_level_2_color];
            break;
        case 2:
            [dustImage setImage:[UIImage imageNamed:@"dust_icon2.png"]];
            [dustDataTextLabel setText:localizedString.DUST_LEVEL3];
            [dustValue setText:@"L2"];
            [dustValue setTextColor:xbody.dust_level_3_color];
            [dustDataTextLabel setTextColor:xbody.dust_level_3_color];
            break;
        case 3:
            [dustImage setImage:[UIImage imageNamed:@"dust_icon3.png"]];
            [dustDataTextLabel setText:localizedString.DUST_LEVEL4];
            [dustValue setText:@"L3"];
            [dustValue setTextColor:xbody.dust_level_4_color];
            [dustDataTextLabel setTextColor:xbody.dust_level_4_color];
            break;
    }
    /*
    //时间条
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-mm-dd HH:MM"];
    NSString* date = [formatter stringFromDate:[NSDate date]];*/
    //地点
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
    //污染等级色条
    [self setDustLevelDisp:xbody.airQualityDetector];
    //文字建议
    switch (xbody.airQualityDetector) {
        case 0:
            [dustSuggestContent setText:TEXT_SUGGESTION1];
            break;
        case 1:
            [dustSuggestContent setText:TEXT_SUGGESTION2];
            break;
        case 2:
            [dustSuggestContent setText:TEXT_SUGGESTION3];
            break;
        case 3:
            [dustSuggestContent setText:TEXT_SUGGESTION4];
            break;
        default:
            [dustSuggestContent setText:@"在空气污染状态下，使室内空气清新有两种方法：一是室外的空气通风，第二种是把室内污浊的空气通过过滤装置进行过滤。如果采用第二种方法使室内空气清新，虽然能通过过滤器进行脱臭，但不能过滤空气中但氢气。建议在环境允许的情况下采用第一种方法。"];
            break;
    }
}
-(void)setDustLevelDisp:(int)level
{
    [dustTextL1 setHidden:YES];
    [dustTextL2 setHidden:YES];
    [dustTextL3 setHidden:YES];
    [dustTextL4 setHidden:YES];
    switch (level) {
        case 1:
            [dustTextL1 setHidden:NO];
            //dustDataTextLabel.textColor = [UIColor colorWithRed:89/255 green:180/255 blue:52/255 alpha:1];
            //dustValue.textColor = [UIColor colorWithRed:89/255 green:180/255 blue:52/255 alpha:1];
            break;
        case 2:
            [dustTextL2 setHidden:NO];
            //dustDataTextLabel.textColor = [UIColor colorWithRed:234/255 green:215/255 blue:76/255 alpha:1];
            //dustValue.textColor = [UIColor colorWithRed:234/255 green:215/255 blue:76/255 alpha:1];
            break;
        case 3:
            [dustTextL3 setHidden:NO];
            //dustDataTextLabel.textColor = [UIColor colorWithRed:239/255 green:140/255 blue:75/255 alpha:1];
            //dustValue.textColor = [UIColor colorWithRed:239/255 green:140/255 blue:75/255 alpha:1];
            break;
        case 4:
            [dustTextL4 setHidden:NO];
            //dustDataTextLabel.textColor = [UIColor colorWithRed:232/255 green:61/255 blue:47/255 alpha:1];
            //dustValue.textColor = [UIColor colorWithRed:232/255 green:61/255 blue:47/255 alpha:1];
            break;
        default:
            [dustTextL1 setHidden:NO];
            //dustDataTextLabel.textColor = [UIColor colorWithRed:89/255 green:180/255 blue:52/255 alpha:1];
            //dustValue.textColor = [UIColor colorWithRed:89/255 green:180/255 blue:52/255 alpha:1];
            break;
    }
}
@end
