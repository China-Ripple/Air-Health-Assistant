//
//  WeatherDelegate1.m
//  Air Health Assistant
//
//  Created by xu da on 14-6-10.
//  Copyright (c) 2014年 xu da. All rights reserved.
//

#import "WeatherDelegate1.h"

@implementation WeatherDelegate1
#pragma connection delegate
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSLog(@"WeatherDelegate1 didFailWithError %@",data);
}

-(void) connection:(NSURLConnection *)connection
  didFailWithError: (NSError *)error {
    NSLog(@"WeatherDelegate1 didFailWithError");
    
}

@end