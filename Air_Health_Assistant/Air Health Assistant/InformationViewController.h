//
//  InformationViewController.h
//  Air Health Assistant
//
//  Created by xu da on 14-5-21.
//  Copyright (c) 2014年 xu da. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InformationViewController : UIViewController
//建议图形
@property (strong, nonatomic) IBOutlet UIImageView *infImage;
//建议标题
@property (strong, nonatomic) IBOutlet UILabel *infTitle;
//温度
@property (strong, nonatomic) IBOutlet UILabel *infTempValue;
//PM2.5
@property (strong, nonatomic) IBOutlet UILabel *infPM25Value;
//周围烟气状况
@property (strong, nonatomic) IBOutlet UILabel *infDustValue;
//建议地址
@property (strong, nonatomic) IBOutlet UILabel *cityLabel;
//空气管理环境
@property (strong, nonatomic) IBOutlet UILabel *airSugguestTitle;
//建议对健康的影响
@property (strong, nonatomic) IBOutlet UILabel *affectLabel;
//建议采取的措施
@property (strong, nonatomic) IBOutlet UILabel *actionLabel;
//天气环境建议
@property (strong, nonatomic) IBOutlet UILabel *weatherSugguestTitle;
//建议天气运动指数
@property (strong, nonatomic) IBOutlet UILabel *sportIndex;
//缩放框架
@property (strong, nonatomic) IBOutlet UIView *frameView;

-(void)refreshData;

@end
