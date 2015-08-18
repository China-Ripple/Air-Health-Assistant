//
//  BluetoothTransfer.h
//  UserPadDemo
//
//  Created by da xu on 12-7-25.
//  Copyright (c) 2012年 rongtai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BluetoothTransfer : NSObject{
    //Object bluetoothReadLock = new Object();
    
    
    // 标识 1
    // 按摩椅运行状态 1
    int nChairRunState ; 
    
    // 按摩手法 3
    int nMaunalSubMode ;
    
    // 按摩程序 3
    int nBackSubRunMode ;
    
    // 标识 1 加热1 保留 1 按摩机芯速度 3 揉捏头宽度位置 2
    int bKeyWaistHeat ;
    
    int nCurKneadKnockSpeed ;
    
    int nKeyKneadWidth ;
    
    // 标识 1 负离子开关 1 振动（或扭腰）强度 3 气压强度 3
    int nKeySeatVibrateStrength ;
    
    int airBagStrength ;
    
    // 标识 1 机芯按摩部位 2 //运行时间高5位 5 运行时间低7位 7
    int nKeyBackLocate ;
    
    int timeSecond ;
    
    // 标识 1 气阀 1 滚轮运行状态 1 滚轮速度 2 气囊按摩部位 3
    
    int bRollerEnable ;
    
    int nRollerPWM ;
    
    int airbagAuto ;
    int airbagHand ;
    int airbagSeat ;
    int airbagThigh ;
    int airbagLeg ;
    int airbagFoot ;
    int airbagNeck ;
    int airbagBackWaist ;
    int airbagShoulder ;
    
    // 标识 1 背部揉捏头位置 7
    int WalkMotorPosition ;
    
    // 标识 1 体型检测指示 1 肩位调节指示 1体型检测结果指示 2 体型检测位置 4
    int bodyDetect ;
    
    int bShoulderAdjust ;
    
    int bDetectResult ;
    
    int nFinalWalkMotorLocate ;
    
    // 标识 1 运行指示 1 小腿电动缸运行方向指示 3 靠背电动缸运行方向指示 3
    int zeroLocate ;
    
    int nCurLegPadMotorState ;
    
    int nCurBackPadMotorState ;
    
    // 标识 1 运行指示 1 零重力电动缸运行方向指示 3
    int bZLBMotorRunFlag ;
    
    int nZLB_RunState ;
    
    // 标识 1 蜂鸣器模式 2 音乐开关 1 音量 4
    int nBuzzerMode ;
    
    int bMP3_AD_Enable ;
    
    int nAvrADResult ;
    
    int airBagFunPartLeg;
    
    int airBagFunPartBackWaist;
    
    int airBagFunPartHandShoulder;
    
    int airBagFunPartSeat;
}
// 标识 1
// 按摩椅运行状态 1
@property(atomic) int nChairRunState ; 

// 按摩手法 3
@property int nMaunalSubMode ;

// 按摩程序 3
@property int nBackSubRunMode ;

// 标识 1 加热1 保留 1 按摩机芯速度 3 揉捏头宽度位置 2
@property int bKeyWaistHeat ;

@property int nCurKneadKnockSpeed ;

@property int nKeyKneadWidth ;

// 标识 1 负离子开关 1 振动（或扭腰）强度 3 气压强度 3
@property int nKeySeatVibrateStrength ;

@property int airBagStrength ;

// 标识 1 机芯按摩部位 2 //运行时间高5位 5 运行时间低7位 7
@property int nKeyBackLocate ;

@property int timeSecond ;

// 标识 1 气阀 1 滚轮运行状态 1 滚轮速度 2 气囊按摩部位 3
@property int bValveFlag ;

@property int bRollerEnable ;

@property int nRollerPWM ;

@property int airbagAuto ;
@property int airbagHand ;
@property int airbagSeat ;
@property int airbagThigh ;
@property int airbagLeg ;
@property int airbagFoot ;
@property int airbagNeck ;
@property int airbagBackWaist ;
@property int airbagShoulder ;

// 标识 1 背部揉捏头位置 7
@property int WalkMotorPosition ;

// 标识 1 体型检测指示 1 肩位调节指示 1体型检测结果指示 2 体型检测位置 4
@property int bodyDetect ;

@property int bShoulderAdjust ;

@property int bDetectResult ;

@property int nFinalWalkMotorLocate ;

// 标识 1 运行指示 1 小腿电动缸运行方向指示 3 靠背电动缸运行方向指示 3
@property int zeroLocate ;

@property int nCurLegPadMotorState ;

@property int nCurBackPadMotorState ;

// 标识 1 运行指示 1 零重力电动缸运行方向指示 3
@property int bZLBMotorRunFlag ;

@property int nZLB_RunState ;

// 标识 1 蜂鸣器模式 2 音乐开关 1 音量 4
@property int nBuzzerMode ;

@property int bMP3_AD_Enable ;

@property int nAvrADResult ;

@property int airBagFunPartLeg;

@property int airBagFunPartBackWaist;

@property int airBagFunPartHandShoulder;

@property int airBagFunPartSeat;

@property int nKeySeatVibrateStrength2 ;

@property int nRollerPWM2 ;

@property int bRollerEnable2 ;

@property int nKeyAirBagLocate2 ;

@property int bKeyWaistHeat2 ;

@property int airBagStrength2 ;

@property int bValveFlag2 ;

-(void)initValue;
+(BluetoothTransfer*)getReceivedData;
@end
