//
//  JPNetwork.m
//  yyqpush
//
//  Created by YYQ on 13-12-26.
//  Copyright (c) 2013年 JPGK. All rights reserved.
//

#import "JPNetwork.h"
#import <netinet/in.h>
#import <SystemConfiguration/SCNetworkReachability.h>
// 如果上面代码报错 说明你没有导入   SystemConfiguration.framework


@implementation JPNetwork


static id <AlertButtonClicked> alertBtnClickedDelegate;

+(void) setAlertDelegate:(id<AlertButtonClicked>)dele{
    
    alertBtnClickedDelegate = dele;
}

+ (BOOL) connectedToNetwork {
	struct sockaddr_in zeroAddress;
	bzero(&zeroAddress, sizeof(zeroAddress));
	zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
	SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
	SCNetworkReachabilityFlags flags;
	BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
	CFRelease(defaultRouteReachability);
	if (!didRetrieveFlags) {
		return NO;
	}
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
	BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
	BOOL isWWAN = flags & kSCNetworkReachabilityFlagsIsWWAN;
	return (isReachable && (!needsConnection || isWWAN)) ? YES : NO;
}

+ (void)networkBreak:(id<AlertButtonClicked>)dele
{
    UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"Warning" message:@"network is unreachable" delegate:dele cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alter show];
   // [alter release];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(buttonIndex == 0){
        [alertBtnClickedDelegate onButtonClicked:0];
    }
}



@end
