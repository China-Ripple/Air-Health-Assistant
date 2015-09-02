//
//  XBody.h
//  Air Health Assistant
//
//  Created by xu da on 14-6-9.
//  Copyright (c) 2014年 xu da. All rights reserved.
//
//////////////////////////////protocol//////////////////////////////
@protocol WeatherDelegate
@optional
-(void)loadWeather;
@end
@protocol CityDelegate
@optional
-(void)cityChanged;
@end
@protocol LocateCity
@optional
-(void) cityLocated:(NSString*)city cityCode:(NSString*)weiod;
@end

@protocol UpdateCitys
@optional
-(void) update;
@end

@protocol AlertButtonClicked

@optional
-(void)onButtonClicked:(int)buttonIndex;
@end

//PM2.5参数
#define PM_DATA_AQI             @"AQI"
#define PM_DATA_CO              @"CO/1h"
#define PM_DATA_NO2             @"NO2/1h"
#define PM_DATA_O3_1H           @"O3/1h"
#define PM_DATA_O3_8H           @"O3/8h"
#define PM_DATA_PM10_1H         @"PM10/1h"
#define PM_DATA_PM2_5_1H        @"PM2.5/1h"
#define PM_DATA_SO2_1H          @"SO2/1h"
#define PM_DATA_TIME            @"live_data_time"
#define PM_DATA_AFFECT          @"对健康影响情况"
#define PM_DATA_ACTION          @"建议采取的措施"
//首次使用
#define FIRST_USE                   @"FIRST_USE"
//账号
#define ACCOUNT_NAME                @"ACCOUNT_NAME"
//密码
#define ACCOUNT_PASSWORD            @"ACCOUNT_PASSWORD"
//GPS定位
#define DATA_GPS_SWITCH             @"DATA_GPS_SWITCH"
//当前城市
#define DATA_CURRENT_PROVINCE           @"DATA_CURRENT_PROVINCE"
#define DATA_CURRENT_CITY               @"DATA_CURRENT_CITY"
#define DATA_CURRENT_CITY_CODE          @"DATA_CURRENT_CITY_CODE"
#define DATA_CURRENT_CITY_CODE_PM25     @"DATA_CURRENT_CITY_CODE_PM25"
#define TEXT_FONT_SIZE              15
//界面空隙
#define VIEW_MARGIN                 10
#define TITLE_HEIGHT                30
#define LINE_GAP                    10
#define IMAGE_SIZE                  200
#define IMAGE_SIZE_SMALL_W          150
#define IMAGE_SIZE_SMALL_H          180
//界面空隙ipad
#define VIEW_MARGIN_IPAD                 15
#define TITLE_HEIGHT_IPAD                40
#define LINE_GAP_IPAD                    20
#define IMAGE_SIZE_IPAD                  300
#define IMAGE_SIZE_SMALL_W_IPAD          240
#define IMAGE_SIZE_SMALL_H_IPAD          288

#define STATE_DATA_ERROR        3
#define STATE_DATA_RECIEVED     2
#define STATE_START             1
#define STATE_STOP              0

#define BLUETOOTH_STATE_DISCONNECT              0
#define BLUETOOTH_STATE_CONNECTING              1
#define BLUETOOTH_STATE_CONNECTED               2

//导航栏背景
#define NAVIGATIONBAR_BACKGROUND    @"navigationbar_background.png"

#define BACKGROUND_640x960          @"background640x960.png"
#define BACKGROUND_640x1136         @"background640x1136.png"
#define BACKGROUND_1024x768         @"background1024x768.png"

#define NAVIGATIONBAR_MERGE_640x960   @"backTitle_iphone4_mask.png"
#define NAVIGATIONBAR_MERGE_640x1136  @"backTitle_iphone5_mask.png"
#define NAVIGATIONBAR_MERGE_1024x768  @"backTitle_ipad_mask.png"

//分页栏背景
#define TABBAR_BACKGROUND           @"tabbar_background 2.png"
//分页栏选择背景
#define TABBAR_SELECTION_IMAGE      @"tabbar_selected.png"
//文字建议
#define TEXT_SUGGESTION1            @"当前空气质量良好"
#define TEXT_SUGGESTION2            @"当前空气有轻微污染"
#define TEXT_SUGGESTION3            @"当前空气污染较重"
#define TEXT_SUGGESTION4            @"当前空气质量很差，请注意安全"

//-------------------------------------------------屏幕自适应相关---------------------------------------------------
#define IPHONE4_MAIN_Y              64
#define IPHONE4_MAIN_HEIGHT         378
#define IPHONE5_MAIN_Y                  108
#define IPHONE5_MAIN_HEIGHT             378
#define IPAD_MAIN_X                 64
#define IPAD_MAIN_Y                 138
#define IPAD_MAIN_WIDTH                 640
#define IPAD_MAIN_HEIGHT                756
#define IPHONE4_DETAIL_Y            64
#define IPHONE4_DETAIL_HEIGHT       436
#define IPHONE5_DETAIL_Y                64
#define IPHONE5_DETAIL_HEIGHT           504
//568
//#define IPAD_DETAIL_X               64
//#define IPAD_DETAIL_Y               98
//#define IPAD_DETAIL_WIDTH               640
//#define IPAD_DETAIL_HEIGHT              872
#define IPAD_DETAIL_X               0
#define IPAD_DETAIL_Y               64
#define IPAD_DETAIL_WIDTH               768
#define IPAD_DETAIL_HEIGHT              980
//-------------------------------------------------
#define TABLECELL_HIGHT             60
#define TABLECELL_HIGHT_IPAD        100

#define STORE_TABLECELL_IMAGE_WIDTH             90
#define STORE_TABLECELL_HIGHT                   100
#define STORE_TABLECELL_IMAGE_WIDTH_IPAD     180
#define STORE_TABLECELL_HIGHT_IPAD           200

//高度
/*
 2.导航栏
 在纵向模式下导航栏为44像素高，在横向模式下为32像素高，导航栏提供了一个很少用的提示模式，该模式将高度扩展了30像素，在纵向模式下为320*74像素，在横向模式下为480*74像素。
 
选项卡为48像素高，工具栏为44像素高。此两个UI元素通长不用于横向模式。
 */
NSString* PM25DataReceivedNotification;
NSString* WeatherDataReceivedNotification;

NSString* WEATHER_CITY;
NSString* WEATHER_TEMP;
NSString* WEATHER_WD;
NSString* WEATHER_WS;
NSString* WEATHER_SD;
NSString* WEATHER_CITYID;
NSString* WEATHER_IMG1;
NSString* WEATHER_IMG2;
NSString* WEATHER_TEMP1;
NSString* WEATHER_TEMP2;
NSString* WEATHER_WEATHER;

@interface XBody : NSObject{
}
//主线程刷新计时器
@property NSTimer *timer;

//系统参数
@property BOOL gpsSwitch;
@property BOOL isLogined;
@property int pm25State;
@property int weatherState;
@property int bluetoothState;
//UI 更新标志
@property int shouldUpdate_main_pm25;
@property int shouldUpdate_detail_pm25;
@property int shouldUpdate_main_weather;
@property int shouldUpdate_detail_weather;
@property int shouldUpdate_main_device;
@property int shouldUpdate_detail_device_for_state;
@property int shouldUpdate_detail_device_for_data;
@property int shouldUpdate_main_city;
@property int shouldUpdate_main_information;
@property int shouldUpdate_detail_information;

//系统变量
@property NSDictionary *cityDic;
@property NSArray *pm25CityArray;
@property NSString *currentCityCode_pm25;
@property NSString *currentCityCode;
@property NSString *currentCity;
@property NSString *currentProvince;
@property NSDictionary *pm25CurrentCityDataDic;
//从单片机发出的数据
@property int programVersion;
@property int powerState;
@property int airMotorState;
@property int anionState;
@property long totalRunTime;
//@property long aqGerneratorVoltage;
@property long airQualityDetector;
//发出到单片机的数据
@property int warnSignal;
@property int pm25Data;

//固定常数
@property UIColor *backgroundColor;
//健康测试 dic转详细数组
@property NSMutableArray *healthDetailArray;
//指甲测试 dic转详细数组
@property NSMutableArray *healthByFingerDetailArray;
//健康顾问 dic转详细数组
@property NSMutableArray *healthConsultantArray;
//健康锻炼 dic转详细数组
@property NSMutableArray *healthExercise1Array;
//健康锻炼 dic转详细数组
@property NSMutableArray *healthExercise2Array;
//健康锻炼 dic转详细数组
@property NSMutableArray *healthExercise3Array;
//健康锻炼 dic转详细数组
@property NSMutableArray *healthExercise4Array;
//健康锻炼 dic转详细数组
@property NSMutableArray *healthExercise5Array;

@property  NSMutableArray *cities;

#define CUSTOM_FONT             @"HelveticaNeueInterface-M3"
#define CUSTOM_FONT_TEXT        @"Microsoft YaHei"
#define CUSTOM_FONT_NUMBER      @"STXihei"

//自定义字体
//导航栏
//文本标题
//文本
//大标题
//按钮
//分页栏
@property UIFont *navigatorFont;
@property UIFont *textFont;
@property UIFont *titleFont;
@property UIFont *midTextFont;
@property UIFont *bigTextFont;
@property UIFont *buttonFont;
@property UIFont *smallFont;
@property UIFont *tabbarFont;
@property UIFont *bigTitleFont;
@property UIFont *littleFont;

//颜色
//pm2.5 57,175,205
@property UIColor *pm25_level_1_color;
@property UIColor *pm25_level_2_color;
@property UIColor *pm25_level_3_color;
@property UIColor *pm25_level_4_color;
@property UIColor *pm25_level_5_color;
@property UIColor *pm25_level_6_color;

@property UIColor *dust_level_1_color;
@property UIColor *dust_level_2_color;
@property UIColor *dust_level_3_color;
@property UIColor *dust_level_4_color;

//健康监测，健康锻炼
//标题
@property UIColor *detail_title_color;
//线条
@property UIColor *detail_line_color;
//文本
@property UIColor *detail_content_color;

//--------------------------------------------------------屏幕适配--------------------------------------------------------
enum{
    XDeviceTypeIPhone4,
    XDeviceTypeIPhone5,
    XDeviceTypeIPad
};
@property int currentDeviceType;

+(XBody *)getInstance;
+(NSMutableDictionary *)getWeather;
//获得文本高度
-(int)getTextHeight:(int)width text:(NSString*)textStr;
//公共方法
-(NSString *)checkNull:(NSString *)str;
-(NSArray*)regularMatch:(NSString*)str patten:(NSString*)patten;
-(void)closeDelloc;

-(void)setPm25State_2:(int)value;
-(void)setWeatherState_2:(int)value;
-(void)setBluetoothState_2:(int)value;
-(void)setCurrentCityCode_pm25_2:(NSString *)value;
-(int)getSportLevel;
-(int)getDressingIndex;
-(int)getPM25Level;
-(int)getCurrentLanguage;


@end
