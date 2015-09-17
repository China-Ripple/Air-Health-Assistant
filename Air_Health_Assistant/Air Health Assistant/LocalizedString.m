//
//  LocalizedString.m
//  Air Health Assistant
//
//  Created by xu da on 14-6-9.
//  Copyright (c) 2014年 xu da. All rights reserved.
//

#import "LocalizedString.h"

@implementation LocalizedString

@synthesize WEATHER_CITY;
@synthesize WEATHER_TEMP;
@synthesize WEATHER_WD;
@synthesize WEATHER_WS;
@synthesize WEATHER_SD;
@synthesize WEATHER_CITYID;
@synthesize WEATHER_IMG1;
@synthesize WEATHER_IMG2;
@synthesize WEATHER_TEMP1;
@synthesize WEATHER_TEMP2;
@synthesize WEATHER_WEATHER;
@synthesize TEXT_NO_DATA;
@synthesize TEXT_LOGIN;
@synthesize T_CANCEL;
@synthesize T_OK;
@synthesize SETTING_VIEW_TITLE;
@synthesize T_SEARCHING;
@synthesize T_DATA_ERROR;
@synthesize T_NO_DATA;
@synthesize T_WAITING;
@synthesize T_LEVEL1;
@synthesize T_LEVEL2;
@synthesize T_LEVEL3;
@synthesize T_LEVEL4;
@synthesize T_LEVEL5;
@synthesize T_LEVEL6;
@synthesize T_DISCONNECTED;
@synthesize T_CONNECTING;
@synthesize T_CONNECTED;
@synthesize T_DEVICE;
@synthesize T_CURRENT_CITY;
@synthesize PAGE_MAIN;
@synthesize PAGE_HEALTH_TEST;
@synthesize PAGE_HEALTH_EXERCISE;
@synthesize PAGE_ACCOUNT;
@synthesize PAGE_ONLINE_STORE;
@synthesize PAGE_DUST_DETAIL;
@synthesize PAGE_PM25_DETAIL;
@synthesize PAGE_WEATHER_DETAIL;
@synthesize PAGE_DEVICE;
@synthesize PAGE_CITY_SELECT;
@synthesize PAGE_INFORMATION;
@synthesize PAGE_REGISTER;
@synthesize PAGE_TEST1;
@synthesize PAGE_TEST2;
@synthesize PAGE_TEST3;
@synthesize PAGE_EXERCISE1;
@synthesize PAGE_EXERCISE2;
@synthesize PAGE_EXERCISE3;
@synthesize PAGE_EXERCISE4;
@synthesize PAGE_EXERCISE5;
@synthesize TITLE_PROGRAM_VERSION;
@synthesize TITLE_POWER_STATE;
@synthesize TITLE_FAN_SATE;
@synthesize TITLE_ANION_STATE;
@synthesize TITLE_TOTAL_RUNTIME;
@synthesize TITLE_VOLTAGE;
@synthesize TITLE_DUST;
@synthesize TITLE_CONNECTION_STATE;
@synthesize DUST_LEVEL1;
@synthesize DUST_LEVEL2;
@synthesize DUST_LEVEL3;
@synthesize DUST_LEVEL4;
@synthesize TEXT_POWER_ON;
@synthesize TEXT_POWER_OFF;
@synthesize TEXT_AIR_MOTOR_0;
@synthesize TEXT_AIR_MOTOR_1;
@synthesize TEXT_AIR_MOTOR_2;
@synthesize TEXT_AIR_MOTOR_3;
@synthesize TEXT_ANION_ON;
@synthesize TEXT_ANION_OFF;
@synthesize T_ANALYZATION;
@synthesize T_AIR_QUALITY;
@synthesize SETTING_GUIDE;
@synthesize SETTING_AUTO_CONN;
@synthesize PAGE_HEALTH_CONSULTANT;
@synthesize WEATHER_TITLE;
@synthesize PAGE_TEMP_MAX;
@synthesize PAGE_TEMP_MIN;
@synthesize WIND_POWER;
@synthesize WEATHER_HUMIDITY;
@synthesize SUGGESTION;
@synthesize WIND_DIRECTION;
@synthesize ANION_STATE_TITLE;
@synthesize TEXT_AIR_MOTOR_TITLE;
@synthesize DUST_STATE;
@synthesize IMPROVE;
@synthesize AIR_ENVIRONMENT_PROPOSE;
@synthesize HEALTHY_AFFECT_CONDITION;
@synthesize PROPOSE_ACTION_MEASURES;
@synthesize WEATHER_ENVIRONMENT_PROPOSE;
@synthesize FLUE_EXAMINE;
@synthesize PRESENT_INDOOR_AIR_INDEX;
@synthesize AIR_CLEAN;
@synthesize IMPROVE_PROPOSE;
@synthesize PRESENT_AIR_QUALITY_WELL;







@synthesize DQQXTJHC;
@synthesize DQQXTJJC;
@synthesize DQQXTJYB;
@synthesize DQQXTJH;
@synthesize DQQXTJFCH;
@synthesize DQKQZLLH;
@synthesize CYZS;
@synthesize LYZS;
@synthesize YDZS;
@synthesize GMZS;
@synthesize ZKQWRZTX;
@synthesize KNDJY;
@synthesize XJZZ;
@synthesize XJCZ;
@synthesize CQGDZ;
@synthesize CQGDC;
@synthesize CQCZ;
@synthesize CQCC;
@synthesize CHUNQIUZHUOZ;
@synthesize DJCZ;

@synthesize TEXT_SUGGESTION1;
@synthesize TEXT_SUGGESTION2;
@synthesize TEXT_SUGGESTION3;
@synthesize TEXT_SUGGESTION4;













@synthesize YGRQ;
@synthesize ERLNR;





+(LocalizedString*)getInstance{
    static LocalizedString *localizedString = nil;
    if (localizedString == nil) {
        localizedString = [[LocalizedString alloc] init];
    }
    return localizedString;
}

-(void)localize{
    WEATHER_CITY = NSLocalizedStringFromTable(@"WEATHER_CITY",@"Localization",nil);
    WEATHER_TEMP = NSLocalizedStringFromTable(@"WEATHER_TEMP",@"Localization",nil);
    WEATHER_WD = NSLocalizedStringFromTable(@"WEATHER_WD",@"Localization",nil);
    WEATHER_WS = NSLocalizedStringFromTable(@"WEATHER_WS",@"Localization",nil);
    WEATHER_SD = NSLocalizedStringFromTable(@"WEATHER_SD",@"Localization",nil);
    WEATHER_CITYID = NSLocalizedStringFromTable(@"WEATHER_CITYID",@"Localization",nil);
    WEATHER_IMG1 = NSLocalizedStringFromTable(@"WEATHER_IMG1",@"Localization",nil);
    WEATHER_IMG2 = NSLocalizedStringFromTable(@"WEATHER_IMG2",@"Localization",nil);
    WEATHER_TEMP1 = NSLocalizedStringFromTable(@"WEATHER_TEMP1",@"Localization",nil);
    WEATHER_TEMP2 = NSLocalizedStringFromTable(@"WEATHER_TEMP2",@"Localization",nil);
    WEATHER_WEATHER = NSLocalizedStringFromTable(@"WEATHER_WEATHER",@"Localization",nil);
    TEXT_NO_DATA = NSLocalizedStringFromTable(@"TEXT_NO_DATA",@"Localization",nil);
    TEXT_LOGIN = NSLocalizedStringFromTable(@"TEXT_LOGIN",@"Localization",nil);
    T_CANCEL = NSLocalizedStringFromTable(@"T_CANCEL",@"Localization",nil);
    T_OK = NSLocalizedStringFromTable(@"T_OK",@"Localization",nil);
    SETTING_VIEW_TITLE = NSLocalizedStringFromTable(@"SETTING_VIEW_TITLE",@"Localization",nil);
    T_SEARCHING = NSLocalizedStringFromTable(@"T_SEARCHING",@"Localization",nil);
    T_DATA_ERROR = NSLocalizedStringFromTable(@"T_DATA_ERROR",@"Localization",nil);
    T_NO_DATA = NSLocalizedStringFromTable(@"T_NO_DATA",@"Localization",nil);
    T_WAITING = NSLocalizedStringFromTable(@"T_WAITING",@"Localization",nil);
    T_LEVEL1 = NSLocalizedStringFromTable(@"T_LEVEL1",@"Localization",nil);
    T_LEVEL2 = NSLocalizedStringFromTable(@"T_LEVEL2",@"Localization",nil);
    T_LEVEL3 = NSLocalizedStringFromTable(@"T_LEVEL3",@"Localization",nil);
    T_LEVEL4 = NSLocalizedStringFromTable(@"T_LEVEL4",@"Localization",nil);
    T_LEVEL5 = NSLocalizedStringFromTable(@"T_LEVEL5",@"Localization",nil);
    T_LEVEL6 = NSLocalizedStringFromTable(@"T_LEVEL6",@"Localization",nil);
    T_DISCONNECTED = NSLocalizedStringFromTable(@"T_DISCONNECTED",@"Localization",nil);
    T_CONNECTING = NSLocalizedStringFromTable(@"T_CONNECTING",@"Localization",nil);
    T_CONNECTED = NSLocalizedStringFromTable(@"T_CONNECTED",@"Localization",nil);
    T_DEVICE = NSLocalizedStringFromTable(@"T_DEVICE",@"Localization",nil);
    T_CURRENT_CITY = NSLocalizedStringFromTable(@"T_CURRENT_CITY",@"Localization",nil);
    PAGE_MAIN = NSLocalizedStringFromTable(@"PAGE_MAIN",@"Localization",nil);
    PAGE_HEALTH_TEST = NSLocalizedStringFromTable(@"PAGE_HEALTH_TEST",@"Localization",nil);
    PAGE_HEALTH_EXERCISE = NSLocalizedStringFromTable(@"PAGE_HEALTH_EXERCISE",@"Localization",nil);
    PAGE_ACCOUNT = NSLocalizedStringFromTable(@"PAGE_ACCOUNT",@"Localization",nil);
    PAGE_ONLINE_STORE = NSLocalizedStringFromTable(@"PAGE_ONLINE_STORE",@"Localization",nil);
    PAGE_DUST_DETAIL = NSLocalizedStringFromTable(@"PAGE_DUST_DETAIL",@"Localization",nil);
    PAGE_PM25_DETAIL = NSLocalizedStringFromTable(@"PAGE_PM25_DETAIL",@"Localization",nil);
    PAGE_WEATHER_DETAIL = NSLocalizedStringFromTable(@"PAGE_WEATHER_DETAIL",@"Localization",nil);
    PAGE_DEVICE = NSLocalizedStringFromTable(@"PAGE_DEVICE",@"Localization",nil);
    PAGE_CITY_SELECT = NSLocalizedStringFromTable(@"PAGE_CITY_SELECT",@"Localization",nil);
    PAGE_INFORMATION = NSLocalizedStringFromTable(@"PAGE_INFORMATION",@"Localization",nil);
    PAGE_REGISTER = NSLocalizedStringFromTable(@"PAGE_REGISTER",@"Localization",nil);
    PAGE_TEST1 = NSLocalizedStringFromTable(@"PAGE_TEST1",@"Localization",nil);
    PAGE_TEST2 = NSLocalizedStringFromTable(@"PAGE_TEST2",@"Localization",nil);
    PAGE_TEST3 = NSLocalizedStringFromTable(@"PAGE_TEST3",@"Localization",nil);
    PAGE_EXERCISE1 = NSLocalizedStringFromTable(@"PAGE_EXERCISE1",@"Localization",nil);
    PAGE_EXERCISE2 = NSLocalizedStringFromTable(@"PAGE_EXERCISE2",@"Localization",nil);
    PAGE_EXERCISE3 = NSLocalizedStringFromTable(@"PAGE_EXERCISE3",@"Localization",nil);
    PAGE_EXERCISE4 = NSLocalizedStringFromTable(@"PAGE_EXERCISE4",@"Localization",nil);
    PAGE_EXERCISE5 = NSLocalizedStringFromTable(@"PAGE_EXERCISE5",@"Localization",nil);
    TITLE_PROGRAM_VERSION = NSLocalizedStringFromTable(@"TITLE_PROGRAM_VERSION",@"Localization",nil);
    TITLE_POWER_STATE = NSLocalizedStringFromTable(@"TITLE_POWER_STATE",@"Localization",nil);
    TITLE_FAN_SATE = NSLocalizedStringFromTable(@"TITLE_FAN_SATE",@"Localization",nil);
    TITLE_ANION_STATE = NSLocalizedStringFromTable(@"TITLE_ANION_STATE",@"Localization",nil);
    TITLE_TOTAL_RUNTIME = NSLocalizedStringFromTable(@"TITLE_TOTAL_RUNTIME",@"Localization",nil);
    TITLE_VOLTAGE = NSLocalizedStringFromTable(@"TITLE_VOLTAGE",@"Localization",nil);
    TITLE_DUST = NSLocalizedStringFromTable(@"TITLE_DUST",@"Localization",nil);
    TITLE_CONNECTION_STATE = NSLocalizedStringFromTable(@"TITLE_CONNECTION_STATE",@"Localization",nil);
    DUST_LEVEL1 = NSLocalizedStringFromTable(@"DUST_LEVEL1",@"Localization",nil);
    DUST_LEVEL2 = NSLocalizedStringFromTable(@"DUST_LEVEL2",@"Localization",nil);
    DUST_LEVEL3 = NSLocalizedStringFromTable(@"DUST_LEVEL3",@"Localization",nil);
    DUST_LEVEL4 = NSLocalizedStringFromTable(@"DUST_LEVEL4",@"Localization",nil);
    TEXT_POWER_ON = NSLocalizedStringFromTable(@"TEXT_POWER_ON",@"Localization",nil);
    TEXT_POWER_OFF = NSLocalizedStringFromTable(@"TEXT_POWER_OFF",@"Localization",nil);
    TEXT_AIR_MOTOR_0 = NSLocalizedStringFromTable(@"TEXT_AIR_MOTOR_0",@"Localization",nil);
    TEXT_AIR_MOTOR_1 = NSLocalizedStringFromTable(@"TEXT_AIR_MOTOR_1",@"Localization",nil);
    TEXT_AIR_MOTOR_2 = NSLocalizedStringFromTable(@"TEXT_AIR_MOTOR_2",@"Localization",nil);
    TEXT_AIR_MOTOR_3 = NSLocalizedStringFromTable(@"TEXT_AIR_MOTOR_3",@"Localization",nil);
    TEXT_ANION_ON = NSLocalizedStringFromTable(@"TEXT_ANION_ON",@"Localization",nil);
    TEXT_ANION_OFF = NSLocalizedStringFromTable(@"TEXT_ANION_OFF",@"Localization",nil);
    T_ANALYZATION = NSLocalizedStringFromTable(@"T_ANALYZATION",@"Localization",nil);
    T_AIR_QUALITY = NSLocalizedStringFromTable(@"T_AIR_QUALITY",@"Localization",nil);
    SETTING_GUIDE = NSLocalizedStringFromTable(@"SETTING_GUIDE",@"Localization",nil);
    SETTING_AUTO_CONN =
    NSLocalizedStringFromTable(@"SETTING_AUTO_CONN",@"Localization",nil);
    
    PAGE_HEALTH_CONSULTANT=
    NSLocalizedStringFromTable(@"PAGE_HEALTH_CONSULTANT",@"Localization",nil);
    
    PAGE_TEMP_MAX=
    NSLocalizedStringFromTable(@"PAGE_TEMP_MAX",@"Localization",nil);
    
    PAGE_TEMP_MIN=
    NSLocalizedStringFromTable(@"PAGE_TEMP_MIN",@"Localization",nil);
    
    WIND_POWER=
    NSLocalizedStringFromTable(@"WIND_POWER",@"Localization",nil);
    

    WEATHER_HUMIDITY=
    NSLocalizedStringFromTable(@"WEATHER_HUMIDITY",@"Localization",nil);
    
    SUGGESTION= NSLocalizedStringFromTable(@"SUGGESTION",@"Localization",nil);
    

    WEATHER_TITLE= NSLocalizedStringFromTable(@"WEATHER_TITLE",@"Localization",nil);
    
    WIND_DIRECTION=NSLocalizedStringFromTable(@"WIND_DIRECTION",@"Localization",nil);
    
    ANION_STATE_TITLE =NSLocalizedStringFromTable(@"ANION_STATE_TITLE",@"Localization",nil);
    
    TEXT_AIR_MOTOR_TITLE = NSLocalizedStringFromTable(@"TEXT_AIR_MOTOR_TITLE",@"Localization",nil);
    
    DUST_STATE = NSLocalizedStringFromTable(@"DUST_STATE",@"Localization",nil);
    IMPROVE =  NSLocalizedStringFromTable(@"IMPROVE",@"Localization",nil);
    AIR_ENVIRONMENT_PROPOSE = NSLocalizedStringFromTable(@"AIR_ENVIRONMENT_PROPOSE",@"Localization",nil);
    HEALTHY_AFFECT_CONDITION = NSLocalizedStringFromTable(@"HEALTHY_AFFECT_CONDITION",@"Localization",nil);
    
    PROPOSE_ACTION_MEASURES = NSLocalizedStringFromTable(@"PROPOSE_ACTION_MEASURES",@"Localization",nil);
    
    WEATHER_ENVIRONMENT_PROPOSE = NSLocalizedStringFromTable(@"WEATHER_ENVIRONMENT_PROPOSE",@"Localization",nil);
    
    
    
    FLUE_EXAMINE = NSLocalizedStringFromTable(@"FLUE_EXAMINE",@"Localization",nil);
    PRESENT_INDOOR_AIR_INDEX = NSLocalizedStringFromTable(@"PRESENT_INDOOR_AIR_INDEX",@"Localization",nil);
    AIR_CLEAN = NSLocalizedStringFromTable(@"AIR_CLEAN",@"Localization",nil);
    IMPROVE_PROPOSE = NSLocalizedStringFromTable(@"IMPROVE_PROPOSE",@"Localization",nil);
    PRESENT_AIR_QUALITY_WELL = NSLocalizedStringFromTable(@"PRESENT_AIR_QUALITY_WELL",@"Localization",nil);
    
    
    
    
    
    
    
    
    
    
    
    DQQXTJHC = NSLocalizedStringFromTable(@"DQQXTJHC",@"Localization",nil);
    
    DQQXTJJC = NSLocalizedStringFromTable(@"DQQXTJJC",@"Localization",nil);
    
    DQQXTJYB = NSLocalizedStringFromTable(@"DQQXTJYB",@"Localization",nil);
    
    DQQXTJH = NSLocalizedStringFromTable(@"DQQXTJH",@"Localization",nil);
    
    DQQXTJFCH = NSLocalizedStringFromTable(@"DQQXTJFCH",@"Localization",nil);
    
    DQKQZLLH =  NSLocalizedStringFromTable(@"DQKQZLLH",@"Localization",nil);
    
    CYZS =  NSLocalizedStringFromTable(@"CYZS",@"Localization",nil);
    
    LYZS = NSLocalizedStringFromTable(@"LYZS",@"Localization",nil);
    
    YDZS = NSLocalizedStringFromTable(@"YDZS",@"Localization",nil);
    
    GMZS = NSLocalizedStringFromTable(@"GMZS",@"Localization",nil);
    
    ZKQWRZTX =  NSLocalizedStringFromTable(@"ZKQWRZTX",@"Localization",nil);
    
    KNDJY =  NSLocalizedStringFromTable(@"KNDJY",@"Localization",nil);

    XJZZ =  NSLocalizedStringFromTable(@"XJZZ",@"Localization",nil);
    
    XJCZ =  NSLocalizedStringFromTable(@"XJCZ",@"Localization",nil);
    
    CQGDZ = NSLocalizedStringFromTable(@"CQGDZ",@"Localization",nil);
    
    CQGDC = NSLocalizedStringFromTable(@"CQGDC",@"Localization",nil);
    
    CQCZ = NSLocalizedStringFromTable(@"CQCZ",@"Localization",nil);
    
    CQCC =  NSLocalizedStringFromTable(@"CQCC",@"Localization",nil);
    
    CHUNQIUZHUOZ =  NSLocalizedStringFromTable(@"CHUNQIUZHUOZ",@"Localization",nil);
    
    DJCZ =  NSLocalizedStringFromTable(@"DJCZ",@"Localization",nil);
    
    
    
    TEXT_SUGGESTION1 = NSLocalizedStringFromTable(@"TEXT_SUGGESTION1",@"Localization",nil);
    TEXT_SUGGESTION2 = NSLocalizedStringFromTable(@"TEXT_SUGGESTION2",@"Localization",nil);
    TEXT_SUGGESTION3 = NSLocalizedStringFromTable(@"TEXT_SUGGESTION3",@"Localization",nil);
    TEXT_SUGGESTION4 = NSLocalizedStringFromTable(@"TEXT_SUGGESTION4",@"Localization",nil);
    
    
    
   
    
    
    
    
    
    
    YGRQ =  NSLocalizedStringFromTable(@"YGRQ",@"Localization",nil);
    ERLNR =  NSLocalizedStringFromTable(@"ERLNR",@"Localization",nil);

   

}

@end
