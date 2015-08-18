//
//  RtBleNvcService.h
//  BLE_TEST
//
//  Created by da xu on 13-8-26.
//  Copyright (c) 2013年 rongtai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "iGate.h"

@interface RtBleNvcService : NSObject<CiGateDelegate>{
    CiGate *iGate;
    CiGateState _state;
    integer_t _rxFormat;
    uint32_t _totalBytesRead;
    NSMutableData *_readData;
    NSThread *connectedThread;
    
    int nBuzzerMode;
    BOOL isSessionOpened;
    BOOL isProgramming;
    BOOL isThreadStarted;
    NSTimer *timer;
    UInt32 timeCount;
    NSObject *readLock;
}
@property CiGateState state;

@property int nBuzzerMode;
@property BOOL isSessionOpened;
@property BOOL isProgramming;
@property BOOL isThreadStarted;
@property UInt32 timeCount;
@property (readonly)    NSObject *readLock;

+ (RtBleNvcService *) sharedInstance;
- (void)initCiGate;
- (void)iGateDidReceivedData:(NSData *)data;
- (void)sendData:(NSData *)data;
- (void)cancelConnectedThread;
- (BOOL)isConnected;
- (void)sendDataForXmodem:(NSData*)data;
- (bool)hasByteReceived;
- (NSData*)getReceivedData;
- (void)clearReadBlock;
- (NSString*)getConnectDevName;

@end
