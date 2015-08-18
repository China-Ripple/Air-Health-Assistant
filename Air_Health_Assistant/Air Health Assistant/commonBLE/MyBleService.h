//
//  MyBleService.h
//  Air Health Assistant
//
//  Created by xu da on 14-8-7.
//  Copyright (c) 2014年 xu da. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BleDevice.h"

#define BLE_SERVICE_STATE_DISCONNECTED      0
#define BLE_SERVICE_STATE_CONNECTING        1
#define BLE_SERVICE_STATE_CONNECTED         2
#define INPUT_BUFFER_SIZE                   99

@interface MyBleService : NSObject<MyBleServiceDelegate>
{
    BleDevice* mc10;
}
//@property NSArray *deviceList;
//@property NSString *connectedDeviceName;
@property int state;
@property BleDevice* mc10;

+ (MyBleService *) getInstance;

-(void)initData;
-(NSArray *)getDeviceList;
-(NSString *)getConnectedDeviceName;
-(int)getState;
- (void)sendData:(NSData *)data;
-(void)close;

@end
