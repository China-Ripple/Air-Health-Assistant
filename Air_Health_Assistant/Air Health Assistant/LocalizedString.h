//
//  LocalizedString.h
//  Air Health Assistant
//
//  Created by xu da on 14-6-9.
//  Copyright (c) 2014年 xu da. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalizedString : NSObject

@property NSString *WEATHER_CITY;
@property NSString *WEATHER_TEMP;
@property NSString *WEATHER_WD;
@property NSString *WEATHER_WS;
@property NSString *WEATHER_SD;
@property NSString *WEATHER_CITYID;
@property NSString *WEATHER_IMG1;
@property NSString *WEATHER_IMG2;
@property NSString *WEATHER_TEMP1;
@property NSString *WEATHER_TEMP2;
@property NSString *WEATHER_WEATHER;

@property NSString *TEXT_NO_DATA;
@property NSString *TEXT_LOGIN;
@property NSString *T_CANCEL;
@property NSString *T_OK;
@property NSString *SETTING_VIEW_TITLE;
@property NSString *T_SEARCHING;
@property NSString *T_DATA_ERROR;
@property NSString *T_NO_DATA;
@property NSString *T_WAITING;
@property NSString *T_LEVEL1;
@property NSString *T_LEVEL2;
@property NSString *T_LEVEL3;
@property NSString *T_LEVEL4;
@property NSString *T_LEVEL5;
@property NSString *T_LEVEL6;
@property NSString *T_DISCONNECTED;
@property NSString *T_CONNECTING;
@property NSString *T_CONNECTED;
@property NSString *T_DEVICE;
@property NSString *T_CURRENT_CITY;
@property NSString *PAGE_MAIN;
@property NSString *PAGE_HEALTH_TEST;
@property NSString *PAGE_HEALTH_EXERCISE;
@property NSString *PAGE_ACCOUNT;
@property NSString *PAGE_ONLINE_STORE;
@property NSString *PAGE_DUST_DETAIL;
@property NSString *PAGE_PM25_DETAIL;
@property NSString *PAGE_WEATHER_DETAIL;
@property NSString *PAGE_DEVICE;
@property NSString *PAGE_CITY_SELECT;
@property NSString *PAGE_INFORMATION;
@property NSString *PAGE_REGISTER;
@property NSString *PAGE_TEST1;
@property NSString *PAGE_TEST2;
@property NSString *PAGE_TEST3;
@property NSString *PAGE_EXERCISE1;
@property NSString *PAGE_EXERCISE2;
@property NSString *PAGE_EXERCISE3;
@property NSString *PAGE_EXERCISE4;
@property NSString *PAGE_EXERCISE5;
@property NSString *TITLE_PROGRAM_VERSION;
@property NSString *TITLE_POWER_STATE;
@property NSString *TITLE_FAN_SATE;
@property NSString *TITLE_ANION_STATE;
@property NSString *TITLE_TOTAL_RUNTIME;
@property NSString *TITLE_VOLTAGE;
@property NSString *TITLE_DUST;
@property NSString *TITLE_CONNECTION_STATE;
@property NSString *DUST_LEVEL1;
@property NSString *DUST_LEVEL2;
@property NSString *DUST_LEVEL3;
@property NSString *DUST_LEVEL4;
@property NSString *TEXT_POWER_ON;
@property NSString *TEXT_POWER_OFF;
@property NSString *TEXT_AIR_MOTOR_0;
@property NSString *TEXT_AIR_MOTOR_1;
@property NSString *TEXT_AIR_MOTOR_2;
@property NSString *TEXT_AIR_MOTOR_3;
@property NSString *TEXT_ANION_ON;
@property NSString *TEXT_ANION_OFF;
@property NSString *T_ANALYZATION;
@property NSString *T_AIR_QUALITY;
@property NSString *TEXT_AIR_MOTOR_TITLE;

/**
 * @ zhongqihong
 ****/
@property NSString *SETTING_GUIDE;
@property NSString *SETTING_AUTO_CONN;
@property NSString *PAGE_HEALTH_CONSULTANT;
@property NSString *WEATHER_TITLE;
@property NSString *PAGE_TEMP_MAX;
@property NSString *PAGE_TEMP_MIN;
@property NSString *WIND_POWER;
@property NSString *WEATHER_HUMIDITY;
@property NSString *SUGGESTION;
@property NSString *WIND_DIRECTION;
@property NSString *ANION_STATE_TITLE;
/******/
@property NSString *DUST_STATE;
@property NSString *IMPROVE;
@property NSString *AIR_ENVIRONMENT_PROPOSE;
@property NSString *HEALTHY_AFFECT_CONDITION;
@property NSString *PROPOSE_ACTION_MEASURES;
@property NSString *WEATHER_ENVIRONMENT_PROPOSE;
@property NSString *FLUE_EXAMINE;
@property NSString *PRESENT_INDOOR_AIR_INDEX;
@property NSString *AIR_CLEAN;
@property NSString *IMPROVE_PROPOSE;
@property NSString *PRESENT_AIR_QUALITY_WELL;

+(LocalizedString*)getInstance;
-(void)localize;
@end
