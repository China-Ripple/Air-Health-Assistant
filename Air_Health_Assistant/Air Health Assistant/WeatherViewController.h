//
//  WeatherViewController.h
//  Air Health Assistant
//
//  Created by xu da on 14-5-21.
//  Copyright (c) 2014年 xu da. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBody.h"

@interface WeatherViewController : UIViewController

@property id <WeatherDelegate> weatherDelegate;
/*
@property (strong, nonatomic) IBOutlet UILabel *cityLabel;
@property (strong, nonatomic) IBOutlet UILabel *tempLabel;
@property (strong, nonatomic) IBOutlet UILabel *wdLabel;
@property (strong, nonatomic) IBOutlet UILabel *wsLabel;
@property (strong, nonatomic) IBOutlet UILabel *sdLabel;
@property (strong, nonatomic) IBOutlet UILabel *temp1Label;
@property (strong, nonatomic) IBOutlet UILabel *temp2Label;
@property (strong, nonatomic) IBOutlet UILabel *weatherLabel;*/
//天气图形
@property (strong, nonatomic) IBOutlet UIImageView *weatherImage;
//天气标题
@property (strong, nonatomic) IBOutlet UILabel *weatherTitle;
//天气数值
@property (strong, nonatomic) IBOutlet UILabel *weatherValue;
//天气单位
@property (strong, nonatomic) IBOutlet UILabel *weatherUnit;
//天气地点
@property (strong, nonatomic) IBOutlet UILabel *cityLabel;
//天气文字展示
@property (strong, nonatomic) IBOutlet UILabel *weatherDataTextLabel;
//当日天气详情
@property (strong, nonatomic) IBOutlet UILabel *weatherDetailDes;
//最高温度title，内容
@property (strong, nonatomic) IBOutlet UILabel *weatherTempHighTitle;
@property (strong, nonatomic) IBOutlet UILabel *weatherTempHighContent;
//最低温度
@property (strong, nonatomic) IBOutlet UILabel *weatherTempLowTitle;
@property (strong, nonatomic) IBOutlet UILabel *weatherTempLowContent;
//风力
@property (strong, nonatomic) IBOutlet UILabel *weatherWDTitle;
@property (strong, nonatomic) IBOutlet UILabel *weatherWDContent;
//风向
@property (strong, nonatomic) IBOutlet UILabel *weatherWSTitle;
@property (strong, nonatomic) IBOutlet UILabel *weatherWSContent;
//湿度
@property (strong, nonatomic) IBOutlet UILabel *weatherSDTitle;
@property (strong, nonatomic) IBOutlet UILabel *weatherSDContent;
//天气情况建议
@property (strong, nonatomic) IBOutlet UILabel *weatherSuggestTitle;
//穿衣指数
@property (strong, nonatomic) IBOutlet UILabel *weatherSuggestContent;
//缩放框架
@property (strong, nonatomic) IBOutlet UIView *frameView;

-(void)refreshData;
@end
