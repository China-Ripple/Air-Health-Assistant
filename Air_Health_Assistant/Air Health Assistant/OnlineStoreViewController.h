//
//  OnlineStoreViewController.h
//  Air Health Assistant
//
//  Created by xu da on 14-5-16.
//  Copyright (c) 2014年 xu da. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreItemCell.h"

@interface OnlineStoreViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,StoreItemCellDelegate>
- (IBAction)onlineStoreButtonClick:(id)sender;
@end
