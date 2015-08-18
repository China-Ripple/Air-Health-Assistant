//
//  MMLocationManager.m
//  MMLocationManager
//
//  Created by Chen Yaoqiang on 13-12-24.
//  Copyright (c) 2013年 Chen Yaoqiang. All rights reserved.
//

#import "MMLocationManager.h"
#import "HttpConnectionLogic.h"
#import "XBody.h"

@interface MMLocationManager ()

@property (nonatomic, strong) LocationBlock locationBlock;
@property (nonatomic, strong) NSStringBlock cityBlock;
@property (nonatomic, strong) NSStringBlock provinceBlock;
@property (nonatomic, strong) NSStringBlock addressBlock;
@property (nonatomic, strong) LocationErrorBlock errorBlock;

@end

@implementation MMLocationManager

@synthesize cityDelegate;


+ (MMLocationManager *)shareLocation;
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

- (id)init {
    self = [super init];
    if (self) {
        NSUserDefaults *standard = [NSUserDefaults standardUserDefaults];
        
        float longitude = [standard floatForKey:MMLastLongitude];
        float latitude = [standard floatForKey:MMLastLatitude];
        self.longitude = longitude;
        self.latitude = latitude;
        self.lastCoordinate = CLLocationCoordinate2DMake(longitude,latitude);
        self.lastCity = [standard objectForKey:MMLastCity];
        self.lastProvince = [standard objectForKey:MMLastProvince];
        self.lastAddress=[standard objectForKey:MMLastAddress];
    }
    return self;
}

- (void) getLocationCoordinate:(LocationBlock) locaiontBlock
{
    self.locationBlock = [locaiontBlock copy];
    [self startLocation];
}

- (void) getLocationCoordinate:(LocationBlock) locaiontBlock  withAddress:(NSStringBlock) addressBlock
{
    self.locationBlock = [locaiontBlock copy];
    self.addressBlock = [addressBlock copy];
    [self startLocation];
}

- (void) getAddress:(NSStringBlock)addressBlock
{
    self.addressBlock = [addressBlock copy];
    [self startLocation];
}

- (void) getCity:(NSStringBlock)cityBlock province:(NSStringBlock)provinceBlock
{
    self.provinceBlock = [provinceBlock copy];
    self.cityBlock = [cityBlock copy];
    [self startLocation];
}

- (void) getCity:(NSStringBlock)cityBlock error:(LocationErrorBlock) errorBlock
{
    self.cityBlock = [cityBlock copy];
    self.errorBlock = [errorBlock copy];
    [self startLocation];
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    CLLocation * newLocation = userLocation.location;
    self.lastCoordinate=mapView.userLocation.location.coordinate;
    
    NSUserDefaults *standard = [NSUserDefaults standardUserDefaults];
    
    [standard setObject:@(self.lastCoordinate.longitude) forKey:MMLastLongitude];
    [standard setObject:@(self.lastCoordinate.latitude) forKey:MMLastLatitude];
    
    CLGeocoder *clGeoCoder = [[CLGeocoder alloc] init];
    CLGeocodeCompletionHandler handle = ^(NSArray *placemarks,NSError *error)
    {
        for (CLPlacemark * placeMark in placemarks)
        {
            NSDictionary *addressDic=placeMark.addressDictionary;
            
            NSString *state=[addressDic objectForKey:@"State"];
            NSString *city=[addressDic objectForKey:@"City"];
            NSString *subLocality=[addressDic objectForKey:@"SubLocality"];
            NSString *street=[addressDic objectForKey:@"Street"];
            NSString *cityString;
            if (city == nil) {
                cityString = [NSString stringWithFormat:@"%@",state];
            }else{
                cityString = [NSString stringWithFormat:@"%@%@",state,city];
            }
            self.lastProvince = state;
            self.lastCity = cityString;
            self.lastAddress=[NSString stringWithFormat:@"%@%@%@%@",state,city,subLocality,street];
            
            [standard setObject:self.lastCity forKey:MMLastCity];
            [standard setObject:self.lastAddress forKey:MMLastAddress];
            NSLog(@"placeMark.addressDictionary:%@,%@,%@,%@",state,city,subLocality,street);
            [self stopLocation];
        }
        if (_provinceBlock) {
            _provinceBlock(_lastProvince);
            _provinceBlock = nil;
        }
        
        if (_cityBlock) {
            _cityBlock(_lastCity);
            _cityBlock = nil;
        }
        
        if (_locationBlock) {
            _locationBlock(_lastCoordinate);
            _locationBlock = nil;
        }
        
        if (_addressBlock) {
            _addressBlock(_lastAddress);
            _addressBlock = nil;
        }
    };
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [clGeoCoder reverseGeocodeLocation:newLocation completionHandler:handle];
}


-(void)startLocation
{
    if (_mapView) {
        _mapView = nil;
    }
    
    _mapView = [[MKMapView alloc] init];
    _mapView.delegate = self;
    _mapView.showsUserLocation = YES;
}

-(void)stopLocation
{
    _mapView.showsUserLocation = NO;
    _mapView = nil;
}

- (void)mapView:(MKMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    [self stopLocation];
}


- (void)gpsLocateCity
{
    [[MMLocationManager shareLocation] getCity:^(NSString *cityString){
        @try {
            //set city
            NSLog(@"cityString:%@",cityString);
            [XBody getInstance].currentCity = cityString;
            
            NSString * currentProvince = [XBody getInstance].currentProvince;
            NSString * currentProvinceNumber;
            //
            NSString *path = [[NSBundle mainBundle] pathForResource:@"City" ofType:@"plist"];
            NSDictionary *cityDic = [NSDictionary dictionaryWithContentsOfFile:path];
            NSString *path2 = [[NSBundle mainBundle] pathForResource:@"Province" ofType:@"plist"];
            NSDictionary *provinceDic = [NSDictionary dictionaryWithContentsOfFile:path2];
            NSLog(@"cityDic:%@",cityDic);
            NSLog(@"provinceDic:%@",provinceDic);
            //匹配省份
            NSArray *provinceArray = [provinceDic allValues];
            NSLog(@"provinceArray:%@",provinceArray);

            /*
             NSArray *cityInThisProvinceArray = [thisProvinceDic allKeys];
             
             NSComparator cmptr = ^(id obj1, id obj2){
             if ([obj1 integerValue] > [obj2 integerValue]) {
             return (NSComparisonResult)NSOrderedDescending;
             }
             
             if ([obj1 integerValue] < [obj2 integerValue]) {
             return (NSComparisonResult)NSOrderedAscending;
             }
             return (NSComparisonResult)NSOrderedSame;
             };
             cityInThisProvinceArray = [cityInThisProvinceArray sortedArrayUsingComparator:cmptr];

             */
            for (int i = 0; i < [provinceDic count]; i++) {
                currentProvinceNumber = [NSString stringWithFormat:@"%d",i];
                NSString * province = [provinceDic objectForKey:currentProvinceNumber];
                //NSLog(@"匹配省份 %@:%@",province,currentProvince);
                NSRange range1 = [province rangeOfString:currentProvince];
                NSRange range2 = [currentProvince rangeOfString:province];
                if(range1.location != NSNotFound || range2.location != NSNotFound){
                    [XBody getInstance].currentProvince = province;
                    NSLog(@"找到省份 currentProvinceNumber:%@",currentProvinceNumber);
                    break;
                }
            }
            //匹配城市
            NSString * currentCity = [XBody getInstance].currentCity;
            NSDictionary *citysInTheProvince = [cityDic objectForKey:currentProvinceNumber];
            NSArray * cityKeyArray = [citysInTheProvince allKeys];
            NSLog(@"cityKeyArray:%@",cityKeyArray);

            for (int i = 0; i < [cityKeyArray count]; i++) {
                NSString * cityKey = [cityKeyArray objectAtIndex:i];
                NSString * cityStr = [citysInTheProvince objectForKey:cityKey];
                NSLog(@"匹配城市 %@:%@",cityStr,currentCity);
                NSRange range1 = [cityStr rangeOfString:currentCity];
                NSRange range2 = [currentCity rangeOfString:cityStr];
                if(range1.location != NSNotFound || range2.location != NSNotFound){
                    [XBody getInstance].currentCity = cityStr;
                    [XBody getInstance].currentCityCode = cityKey;
                    NSLog(@"找到城市 %@:%@",[XBody getInstance].currentCity,[XBody getInstance].currentCityCode);
                    break;
                }
                
            }
            
            [cityDelegate cityChanged];
        }
        @catch (NSException *exception) {
            NSLog(@"city %@",exception);
        }
    } province:^(NSString *provinceString){
        NSLog(@"provinceString:%@",provinceString);
        
        [XBody getInstance].currentProvince = provinceString;
    }];
    
    NSLog(@"gpsLocateProvince:%@",[XBody getInstance].currentProvince);
    
    NSLog(@"gpsLocateCity:%@",[XBody getInstance].currentCity);
  
    /*
     [[MMLocationManager shareLocation] getCity:^(NSString *cityString){
     //set city
     NSLog(@"cityString:%@",cityString);
     [XBody getInstance].currentCity = cityString;
     //pm2.5
     
     //weather
     WeatherLogic *weatherLogic = [WeatherLogic getInstance];
     [weatherLogic loadWeather];
     } ];*/
}

@end
