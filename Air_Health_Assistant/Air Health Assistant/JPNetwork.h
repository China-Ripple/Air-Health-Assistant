//
//  JPNetwork.h
//  yyqpush
//
//  Created by YYQ on 13-12-26.
//  Copyright (c) 2013年 JPGK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XBody.h"

@interface JPNetwork : NSObject<UIAlertViewDelegate>



+ (BOOL) connectedToNetwork;

+ (void) networkBreak:(id<AlertButtonClicked>)dele;
+ (void) setAlertDelegate:(id<AlertButtonClicked>) dele;



@end
