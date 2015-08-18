//
//  DustViewController.h
//  Air Health Assistant
//
//  Created by xu da on 14-8-12.
//  Copyright (c) 2014年 xu da. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DustViewController : UIViewController
//烟气图形
@property (strong, nonatomic) IBOutlet UIImageView *dustImage;
//烟气标题
@property (strong, nonatomic) IBOutlet UILabel *dustTitle;
//烟气数值
@property (strong, nonatomic) IBOutlet UILabel *dustValue;
//烟气文字展示
@property (strong, nonatomic) IBOutlet UILabel *dustDataTextLabel;
//烟气地址
@property (strong, nonatomic) IBOutlet UILabel *cityLabel;
//污染等级色条
@property (strong, nonatomic) IBOutlet UILabel *dustTextL1;
@property (strong, nonatomic) IBOutlet UILabel *dustTextL2;
@property (strong, nonatomic) IBOutlet UILabel *dustTextL3;
@property (strong, nonatomic) IBOutlet UILabel *dustTextL4;
//当前室内空气指数
@property (strong, nonatomic) IBOutlet UILabel *dustDetailTitle;
//改善建议
@property (strong, nonatomic) IBOutlet UILabel *dustSuggestTitle;
//建议内容
@property (strong, nonatomic) IBOutlet UILabel *dustSuggestContent;
//缩放框架
@property (strong, nonatomic) IBOutlet UIView *frameView;

-(void)refreshData;
@end
