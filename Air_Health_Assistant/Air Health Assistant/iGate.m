//
//  iGate.h
//  iGate
//
//  Created by Zhan on 12-6-18.
//  Copyright (c) 2012年 Novacomm. All rights reserved.
//
#import "iGate.h"

@implementation CiGate


- (CiGate *)initWithDelegate:(id<CiGateDelegate>)aDelegate autoConnectFlag:(BOOL)aFlag serviceUuidStr:(NSString*)uuidStr{
    return nil;}

- (CiGate *)initWithDelegate:(id<CiGateDelegate>)aDelegate autoConnectFlag:(BOOL)aFlag BondDevUUID:(CFUUIDRef)bondDevUUID serviceUuidStr:(NSString*)uuidStr{return nil;}
- (void)startSearch{}
- (void)stopSearch{}
- (void)connectDevice:(CFUUIDRef)devUUID deviceName:(NSString *)name{}
- (BOOL) disconnectDevice:(CFUUIDRef)devUUID{return nil;}
- (NSString *) getConnectDevName{return nil;}
- (void) setConnectDevName:(NSString *)name{}
- (void) getConnectDevRSSI{}
- (CFUUIDRef) getConnectDevUUID{return nil;}
- (void) readConnectDevAddr{}
- (void) readConnectDevAioLevel:(integer_t)aioSelector{}
- (BOOL) setBondDevUUID:(CFUUIDRef)bondDevUUID{return nil;}
- (void)sendData:(NSData *)data{}

@end

