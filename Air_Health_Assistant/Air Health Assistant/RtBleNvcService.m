//
//  RtBleNvcService.m
//  BLE_TEST
//
//  Created by da xu on 13-8-26.
//  Copyright (c) 2013年 rongtai. All rights reserved.
//

#import "RtBleNvcService.h"
#import "Const.h"
#import "XBody.h"

@implementation RtBleNvcService

@synthesize state=_state;
@synthesize nBuzzerMode;
@synthesize isSessionOpened;
@synthesize isProgramming;
@synthesize isThreadStarted;
@synthesize timeCount;
@synthesize readLock;
/*
 @synthesize iGate;
 @synthesize iGate1;
 CiGateState _state;
 integer_t _rxFormat;
 uint32_t _totalBytesRead;
 */


+ (RtBleNvcService *) sharedInstance
{
	static RtBleNvcService	*this	= nil;
    
	if (!this){
		this = [[RtBleNvcService alloc] init];
        //[this initCiGate];
        [this createConnectedThread];
        this.timeCount = 0;
    }
    
    return this;
}

- (void)initCiGate{
    // Get the UUID from setting bundle
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    Boolean useCustomerUUID128 = [defaults boolForKey:@"switchUseUUID128"];
    NSString *serviceUUIDStr=@"1812";
    if(useCustomerUUID128)
    {
        serviceUUIDStr=[defaults stringForKey:@"customerUuid128"];
        if(serviceUUIDStr==nil)
            serviceUUIDStr=@"C14D2C0A-401F-B7A9-841F-E2E93B80F631";
        else
        {
            CFUUIDRef tmpUUID0=CFUUIDCreateFromString(kCFAllocatorDefault, (__bridge CFStringRef)serviceUUIDStr);
            CFStringRef aCFString=CFUUIDCreateString(kCFAllocatorDefault,tmpUUID0);
            if(kCFCompareEqualTo!=CFStringCompare(aCFString,(__bridge CFStringRef)serviceUUIDStr,0))
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:serviceUUIDStr message:@"The UUID128 in settings is not correct, default C14D2C0A-401F-B7A9-841F-E2E93B80F631 is used" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                
                [alert show];
                serviceUUIDStr=@"C14D2C0A-401F-B7A9-841F-E2E93B80F631";
            }
            CFRelease(tmpUUID0);
            CFRelease(aCFString);
        }
    }
    
    iGate = [[CiGate alloc] initWithDelegate:self autoConnectFlag:TRUE serviceUuidStr:serviceUUIDStr];
}

#pragma mark - CiGateDelegate methods
/*
 Invoked whenever the central manager's state is updated.
 */
- (void)iGateDidUpdateState:(CiGateState)iGateState
{
    int bluetoothState = BLUETOOTH_STATE_DISCONNECT;
    [self setState:iGateState];
    NSString *str;
    switch(iGateState)
    {
        case CiGateStateInit:
            str=@"Init";
            break;
        case CiGateStateIdle:
            str=@"Idle";
            break;
        case CiGateStatePoweredOff:
            str=@"Bluetooth power off";
            break;
        case CiGateStateUnknown:
            str=@"Bluetooth unknown";
            break;
        case CiGateStateUnsupported:
            str=@"BLE not supported";
            break;
        case CiGateStateSearching://7
            str=@"Searching";
            isSessionOpened = false;
            break;
        case CiGateStateConnecting://8
            if([iGate getConnectDevName])
                str=[@"Connecting " stringByAppendingString:[iGate getConnectDevName]];
            else
                str=@"Connecting iGate";
            bluetoothState = BLUETOOTH_STATE_CONNECTING;
            break;
        case CiGateStateConnected://9
            if([iGate getConnectDevName])
                str=[@"Connected " stringByAppendingString:[iGate getConnectDevName]];
            else
                str=@"Connected iGate";
            bluetoothState = BLUETOOTH_STATE_CONNECTING;
            break;
        case CiGateStateBonded://10
            if([iGate getConnectDevName])
                str=[@"Bonded " stringByAppendingString:[iGate getConnectDevName]];
            else
                str=@"Bonded iGate";
            isSessionOpened = true;
            bluetoothState = BLUETOOTH_STATE_CONNECTED;
            break;
    }
    NSLog(@"bluetoothState %d",bluetoothState);

    //UI signal
    [[XBody getInstance] setBluetoothState_2:bluetoothState];

    NSLog(@"%@, State %@",iGate,str);
}

- (void)iGateDidReceivedData:(NSData *)data
{
    NSLog(@"data received!");
    /* need to delegate function */
    timeCount = 0;
    isSessionOpened = true;
    if (_readData == nil) {
        _readData = [[NSMutableData alloc] init];
    }
    //@synchronized(readLock){
    [_readData appendData:data];
    while ([_readData length] > EAD_INPUT_BUFFER_SIZE * 2) {
        NSLog(@"iGateDidReceivedData: too fast to catch!");
        [_readData replaceBytesInRange:NSMakeRange(0, EAD_INPUT_BUFFER_SIZE) withBytes:NULL length:0];
    }
    //}
    //NSLog(@"iGateDidReceivedData: %@",_readData);
    [self processData];
}
#pragma 数据处理
uint8_t readData_index = 0;
uint8_t readData_temp_buffer[EAD_INPUT_BUFFER_SIZE];
//uint8_t readData_read_buffer[EAD_INPUT_BUFFER_SIZE];
-(void)processData
{
    uint8_t dataValue[1];
    for (int i = 0; i < [_readData length]; i++) {
        [_readData getBytes:dataValue length:1];
        [_readData replaceBytesInRange:NSMakeRange(0, 1) withBytes:NULL length:0];
        //get SOI
        if(dataValue[0] == SOI){
            readData_index = 0;
            readData_index++;
        } else if(dataValue[0] == EOI){
            //get EOI,save data
            if(readData_index > 0){
                [self processSaveData];
            }
            readData_index = 0;
        }else{
            //get Data
            if(readData_index < EAD_INPUT_BUFFER_SIZE){
                readData_temp_buffer[readData_index++] = dataValue[0];
            }
        }
    }
}
-(void)processSaveData
{
    NSLog(@"processSaveData");
    XBody *xbody = [XBody getInstance];
    
    //01显示，02控制
    if(((readData_temp_buffer[1] >> 4) & 0x7) == 1){
        //2程序版本号4
        xbody.programVersion = readData_temp_buffer[1] & 0xf;
        //3开关状态2  风扇状态3 负离子开关状态2
        xbody.powerState = (readData_temp_buffer[2] >> 5) & 0x3;
        xbody.airMotorState = (readData_temp_buffer[2] >> 2) & 0x7;
        xbody.anionState = (readData_temp_buffer[2]) & 0x3;
        //6总运行时间
        xbody.totalRunTime = readData_temp_buffer[3] & 0x7f;
        xbody.totalRunTime |= (readData_temp_buffer[4] & 0x7f) << 7;
        //空气质量传感器输出电压
        xbody.aqGerneratorVoltage = readData_temp_buffer[5] & 0x7f;
        xbody.aqGerneratorVoltage |= (readData_temp_buffer[6] & 0x7f) << 7;
    }
    //UI signal
    xbody.shouldUpdate_detail_device_for_data = YES;
}
//////////////////////
- (void)iGateDidUpdateConnectDevRSSI:(NSNumber *)rssi error:(NSError *)error
{
    NSLog(@"rssi updated");
}

-(void)iGateDidUpdateConnectDevAddr:(CBluetoothAddr *)addr
{
    NSLog(@"iGateDidUpdateConnectDevAddr: connected device address is %04x%02x%06x",addr->nap,addr->uap,addr->lap);
}

- (void)iGateDidUpdateConnectDevAIO:(integer_t)aioSelector level:(integer_t)aioLevel
{
    NSLog(@"iGateDidUpdateConnectDevAIO %04x %04x",aioSelector,aioLevel);
}

#pragma mark - Data transfer
- (void)sendData:(NSData *)data{
    //NSLog(@"sendData");
    [iGate sendData:data];
}

//connected thread,start once connected
-(void)createConnectedThread
{
    NSLog(@"createConnectedThread");
    isThreadStarted = true;
    //做线程是因为有的模块数据接收不过来,同时ios系统会被大数据流拖慢
    connectedThread = [[NSThread alloc]initWithTarget:self selector:@selector(connectedThreadMethod) object:nil];
    [connectedThread start];
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(connectTimelyTask:) userInfo:nil repeats:YES];
    [timer fire];
    
}
-(void)cancelConnectedThread
{
    NSLog(@"cancelConnectedThread");
    isThreadStarted = FALSE;
    isSessionOpened = false;
    connectedThread = nil;
    [timer invalidate];
}
-(void)connectTimelyTask:(id)sender
{
    timeCount++;
    if(timeCount > 10){
        NSLog(@"long time no data received!");
        //isSessionOpened = false;
        timeCount = 0;
        // reconnect
        NSLog(@"%@, State %ld",iGate,(long)[iGate state]);
    }
}
-(void)connectedThreadMethod
{
    while (isThreadStarted) {
        @try {
            //5秒
            sleep(5);
            XBody *xbody = [XBody getInstance];
            NSMutableData *data = [NSMutableData data];
            uint8_t tmp[4];
            tmp[0] = SOI;
            //数据包标识3,警告信息1,PM2.5数据低3位
            tmp[1]  = 0x01;//01显示，02控制
            tmp[1] |= (xbody.warnSignal << 3) & 0x1;
            tmp[1] |= (xbody.pm25Data >> 7) & 0x3;
            tmp[2] = xbody.pm25Data & 0x7f;
            tmp[3] = EOI;
            [data appendBytes:(void *)(&tmp) length:4];
            [[RtBleNvcService sharedInstance] sendData:data];
            //NSLog(@"显示包:%@",data);

        }
        @catch (NSException *exception) {
        }
    }
}
//check if session is connected
- (BOOL)isConnected
{
    if(!isSessionOpened){
        //[iGate disconnectDevice:[iGate getConnectDevUUID]];
    }
    return isSessionOpened;
}

-(void)sendDataForXmodem:(NSData*)data
{
    [self sendData:data];
}

-(bool)hasByteReceived
{
    if ([_readData length] > 0) {
        return true;
    }
    else {
        return false;
    }
}

-(NSData*)getReceivedData
{
    uint8_t inBuffer[1];
    if ([_readData length] > 0) {
        //@synchronized(readLock){
        [_readData getBytes:inBuffer length:1];
        [_readData replaceBytesInRange:NSMakeRange(0, 1) withBytes:NULL length:0];
        //}
    }
    NSData* data = [[NSData alloc]initWithBytes:inBuffer length:1];
    return data;
}

-(void)clearReadBlock
{
    Byte buf[1] = {'1'};
    NSData* data = [[NSData alloc]initWithBytes:buf length:1];
    [self sendData:data];
}

- (NSString *) getConnectDevName
{
    return [iGate getConnectDevName];
}

@end
