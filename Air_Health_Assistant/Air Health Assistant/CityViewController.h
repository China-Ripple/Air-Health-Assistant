//
//  CityViewController.h
//  Air Health Assistant
//
//  Created by xu da on 14-5-21.
//  Copyright (c) 2014年 xu da. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBody.h"

//view 中选择clipsubview 则 子view 不会跳出框架

@interface CityViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property id <CityDelegate> cityDelegate;
@property NSDictionary *provinceDic;
@property NSDictionary *cityDic;

//缩放框架
@property (strong, nonatomic) IBOutlet UIView *frameView;
@property (strong, nonatomic) IBOutlet UIView *imageFrameView;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
