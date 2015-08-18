//
//  HttpConnectionLogic.h
//  Air Health Assistant
//
//  Created by xu da on 14-6-19.
//  Copyright (c) 2014年 xu da. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "XBody.h"

@interface HttpConnectionLogic : NSObject

@property id httpConnectionDelegate;
@property UIViewController *mainViewController;
@property id<LocateCity> locateCity;
@property id<UpdateCitys> updateCitys;


//@property (strong, nonatomic) IBOutlet UILabel *cityLabel;

+(HttpConnectionLogic *)getInstance;
-(void)init:(id)delegate;
-(void)setPMDetailViewController:(UIViewController *)viewController;

///////////////////////////////////////http访问///////////////////////////////////////
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;
-(void)connection:(NSURLConnection *)connection didFailWithError: (NSError *)error;
-(void)connectionDidFinishLoading: (NSURLConnection*) connection;
-(void)loadWeather;
-(void)loadPM25;
-(void)httpCreate_PM25:(NSString *)URLString;
-(void)getCityName:(CLLocation*)locaion;
-(void)getCitys:(NSString*)cityName;
-(void)loadOverSeasWeather:(NSString*)woeid;
@end