//
//  BluetoothTransfer.m
//  UserPadDemo
//
//  Created by da xu on 12-7-25.
//  Copyright (c) 2012年 rongtai. All rights reserved.
//

#import "BluetoothTransfer.h"
@interface BluetoothTransfer(){
    
    Byte *messageBuffer;
    
}

@property Byte *messageBuffer;

//Object bluetoothReadLock = new Object();

@end

@implementation BluetoothTransfer 
@synthesize messageBuffer;
// 标识 1
// 按摩椅运行状态 1
@synthesize nChairRunState ; 

// 按摩手法 3
@synthesize nMaunalSubMode ;

// 按摩程序 3
@synthesize nBackSubRunMode ;

// 标识 1 加热1 保留 1 按摩机芯速度 3 揉捏头宽度位置 2
@synthesize bKeyWaistHeat ;

@synthesize nCurKneadKnockSpeed ;

@synthesize nKeyKneadWidth ;

// 标识 1 负离子开关 1 振动（或扭腰）强度 3 气压强度 3
@synthesize nKeySeatVibrateStrength ;

@synthesize airBagStrength ;

// 标识 1 机芯按摩部位 2 //运行时间高5位 5 运行时间低7位 7
@synthesize nKeyBackLocate ;

@synthesize timeSecond ;

// 标识 1 气阀 1 滚轮运行状态 1 滚轮速度 2 气囊按摩部位 3
@synthesize bValveFlag ;

@synthesize bRollerEnable ;

@synthesize nRollerPWM ;

@synthesize airbagAuto ;

@synthesize airbagHand ;
@synthesize airbagSeat ;
@synthesize airbagThigh ;
@synthesize airbagLeg ;
@synthesize airbagFoot ;
@synthesize airbagNeck ;
@synthesize airbagBackWaist ;
@synthesize airbagShoulder ;

// 标识 1 背部揉捏头位置 7
@synthesize WalkMotorPosition ;

// 标识 1 体型检测指示 1 肩位调节指示 1体型检测结果指示 2 体型检测位置 4
@synthesize bodyDetect ;

@synthesize bShoulderAdjust ;

@synthesize bDetectResult ;

@synthesize nFinalWalkMotorLocate ;

// 标识 1 运行指示 1 小腿电动缸运行方向指示 3 靠背电动缸运行方向指示 3
@synthesize zeroLocate ;

@synthesize nCurLegPadMotorState ;

@synthesize nCurBackPadMotorState ;

// 标识 1 运行指示 1 零重力电动缸运行方向指示 3
@synthesize bZLBMotorRunFlag ;

@synthesize nZLB_RunState ;

// 标识 1 蜂鸣器模式 2 音乐开关 1 音量 4
@synthesize nBuzzerMode ;

@synthesize bMP3_AD_Enable ;

@synthesize nAvrADResult ;

@synthesize airBagFunPartLeg;

@synthesize airBagFunPartBackWaist;

@synthesize airBagFunPartHandShoulder;

@synthesize airBagFunPartSeat;

@synthesize nKeySeatVibrateStrength2 ;

@synthesize nRollerPWM2 ;

@synthesize bRollerEnable2 ;

@synthesize nKeyAirBagLocate2 ;

@synthesize bKeyWaistHeat2 ;

@synthesize airBagStrength2 ;

@synthesize bValveFlag2 ;

-(void)initValue{
    
    
    // 标识 1
    // 按摩椅运行状态 1
    
    nChairRunState = 0;
    
    // 按摩手法 3
    nMaunalSubMode = 0;
    
    // 按摩程序 3
    nBackSubRunMode = 0;
    
    // 标识 1 加热1 保留 1 按摩机芯速度 3 揉捏头宽度位置 2
    bKeyWaistHeat = 0;
    
    nCurKneadKnockSpeed = 0;
    
    nKeyKneadWidth = 0;
    
    // 标识 1 负离子开关 1 振动（或扭腰）强度 3 气压强度 3
    nKeySeatVibrateStrength = 0;
    
    airBagStrength = 0;
    
    // 标识 1 机芯按摩部位 2 //运行时间高5位 5 运行时间低7位 7
    nKeyBackLocate = 0;
    
    timeSecond = 0;
    
    // 标识 1 气阀 1 滚轮运行状态 1 滚轮速度 2 气囊按摩部位 3
    bValveFlag = 0;
    
    bRollerEnable = 0;
    
    nRollerPWM = 0;
    
    airbagAuto = 0;
    
    // 标识 1 背部揉捏头位置 7
    WalkMotorPosition = 0;
    
    // 标识 1 体型检测指示 1 肩位调节指示 1体型检测结果指示 2 体型检测位置 4
    bodyDetect = 0;
    
    bShoulderAdjust = 0;
    
    bDetectResult = 0;
    
    nFinalWalkMotorLocate = 0;
    
    // 标识 1 运行指示 1 小腿电动缸运行方向指示 3 靠背电动缸运行方向指示 3
    zeroLocate = 0;
    
    nCurLegPadMotorState = 0;
    
    nCurBackPadMotorState = 0;
    
    // 标识 1 运行指示 1 零重力电动缸运行方向指示 3
    bZLBMotorRunFlag = 0;
    
    nZLB_RunState = 0;
    
    // 标识 1 蜂鸣器模式 2 音乐开关 1 音量 4
    nBuzzerMode = 0;
    
    bMP3_AD_Enable = 0;
    
    nAvrADResult = 0;
    
    airBagFunPartLeg = 0;
    
    airBagFunPartBackWaist = 0;
    
    airBagFunPartHandShoulder = 0;
    
    airBagFunPartSeat = 0;
    
    nKeySeatVibrateStrength2 = 0;
    
    nRollerPWM2 = 0;
    
    bRollerEnable2 = 0;
    
    nKeyAirBagLocate2 = 0;
    
    bKeyWaistHeat2 = 0;
    
    airBagStrength2 = 0;
    
    bValveFlag2 = 0;
 
}

+(BluetoothTransfer *)getReceivedData{
    static BluetoothTransfer *receivedData=nil;
    if (receivedData == nil) {
        receivedData = [[BluetoothTransfer alloc]init];
    }
    return receivedData;
}
@end
