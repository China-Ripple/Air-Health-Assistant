//
//  MyTableViewController.h
//  SearchController
//
//  Created by 曦炽 朱 on 14/10/27.
//  Copyright (c) 2014年 mirroon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLLocationManagerDelegate.h>
#import "XBody.h"
@interface MyTableViewController : UITableViewController<UISearchResultsUpdating,CLLocationManagerDelegate,UISearchBarDelegate,LocateCity,UpdateCitys>
    {
       // CLLocationManager* locationMgr;
    }

  @property(nonatomic,retain)  XBody * body;
  

   //@property (nonatomic, strong) CLLocationManager* locationMgr;
  // @property (nonatomic, strong) CLGeocoder* clGeocoder;// iso 5.0及5.0以上SDK版本使

   @property id <CityDelegate> cityDelegate;

   @property UIAlertView *alter;

   

@end
