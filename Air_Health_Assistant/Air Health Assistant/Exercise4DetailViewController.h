//
//  Exercise4DetailViewController.h
//  Air Health Assistant
//
//  Created by xu da on 14-7-24.
//  Copyright (c) 2014年 xu da. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Exercise4DetailViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *lastView;
@property NSMutableArray *detailArray;

@end
