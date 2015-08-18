//
//  PMInformationViewController.h
//  Air Health Assistant
//
//  Created by xu da on 14-5-17.
//  Copyright (c) 2014年 xu da. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PMInformationViewController : UIViewController

//缩放框架
@property (strong, nonatomic) IBOutlet UIView *frameView;
//pm2.5图形
@property (strong, nonatomic) IBOutlet UIImageView *titleImage;
//pm2.5标题
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
//pm2.5数值
@property (strong, nonatomic) IBOutlet UILabel *valueLabel;
//pm2.5单位
@property (strong, nonatomic) IBOutlet UILabel *unitLabel;
//pm2.5地点
@property (strong, nonatomic) IBOutlet UILabel *cityLabel;
//pm2.5质量文字展示
@property (strong, nonatomic) IBOutlet UILabel *pm25TextLabel;
//pm2.5指示颜色对应
@property (strong, nonatomic) IBOutlet UILabel *colorBarTitle;
//pm2.5指示条 严重污染
@property (strong, nonatomic) IBOutlet UILabel *colorBarBadTitle;
//pm2.5影响
@property (strong, nonatomic) IBOutlet UILabel *affect;
//pm2.5空气质量详细参数
@property (strong, nonatomic) IBOutlet UILabel *dataDetailTitle;
//pm2.5参数－区域（title，内容，标题背景，内容背景）
@property (strong, nonatomic) IBOutlet UILabel *areaTitle;
@property (strong, nonatomic) IBOutlet UIImageView *areaTitleImage;
@property (strong, nonatomic) IBOutlet UILabel *areaContent;
@property (strong, nonatomic) IBOutlet UIImageView *areaContentImage;
//pm2.5参数－时间
@property (strong, nonatomic) IBOutlet UILabel *liveTimeTitle;
@property (strong, nonatomic) IBOutlet UIImageView *liveTimeTitleImage;
@property (strong, nonatomic) IBOutlet UILabel *liveTimeContent;
@property (strong, nonatomic) IBOutlet UIImageView *liveTimeContentImage;
//pm2.5参数－AQI
@property (strong, nonatomic) IBOutlet UILabel *aqiTitle;
@property (strong, nonatomic) IBOutlet UIImageView *aqiTitleImage;
@property (strong, nonatomic) IBOutlet UILabel *aqiContent;
@property (strong, nonatomic) IBOutlet UIImageView *aqiContentImage;
//pm2.5参数－PM2.5
@property (strong, nonatomic) IBOutlet UILabel *pm25Title;
@property (strong, nonatomic) IBOutlet UIImageView *pm25TitleImage;
@property (strong, nonatomic) IBOutlet UILabel *pm25Content;
@property (strong, nonatomic) IBOutlet UIImageView *pm25ContentImage;
//pm2.5参数－PM10
@property (strong, nonatomic) IBOutlet UILabel *pm10Title;
@property (strong, nonatomic) IBOutlet UIImageView *pm10TitleImage;
@property (strong, nonatomic) IBOutlet UILabel *pm10Content;
@property (strong, nonatomic) IBOutlet UIImageView *pm10ContentImage;
//pm2.5参数－CO
@property (strong, nonatomic) IBOutlet UILabel *co_1hTitle;
@property (strong, nonatomic) IBOutlet UIImageView *co_1hTitleImage;
@property (strong, nonatomic) IBOutlet UILabel *co_1hContent;
@property (strong, nonatomic) IBOutlet UIImageView *co_1hContentImage;
//pm2.5参数－NO2
@property (strong, nonatomic) IBOutlet UILabel *no2_1hTitle;
@property (strong, nonatomic) IBOutlet UIImageView *no2_1hTitleImage;
@property (strong, nonatomic) IBOutlet UILabel *no2_1hContent;
@property (strong, nonatomic) IBOutlet UIImageView *no2_1hContentImage;
//pm2.5参数－SO2
@property (strong, nonatomic) IBOutlet UILabel *so2_1hTitle;
@property (strong, nonatomic) IBOutlet UIImageView *so2_1hTitleImage;
@property (strong, nonatomic) IBOutlet UILabel *so2_1hContent;
@property (strong, nonatomic) IBOutlet UIImageView *so2_1hContentImage;
//pm2.5参数－O3/1h
@property (strong, nonatomic) IBOutlet UILabel *o3_1hTitle;
@property (strong, nonatomic) IBOutlet UIImageView *o3_1hTitleImage;
@property (strong, nonatomic) IBOutlet UILabel *o3_1hContent;
@property (strong, nonatomic) IBOutlet UIImageView *o3_1hContentImage;
//pm2.5参数－O3/8h
@property (strong, nonatomic) IBOutlet UILabel *o3_8hTitle;
@property (strong, nonatomic) IBOutlet UIImageView *o3_8hTitleImage;
@property (strong, nonatomic) IBOutlet UILabel *o3_8hContent;
@property (strong, nonatomic) IBOutlet UIImageView *o3_8hContentImage;

-(void)refreshData;
@end
