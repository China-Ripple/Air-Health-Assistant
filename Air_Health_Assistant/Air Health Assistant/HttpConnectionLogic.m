//
//  HttpConnectionLogic.m
//  Air Health Assistant
//
//  Created by xu da on 14-6-19.
//  Copyright (c) 2014年 xu da. All rights reserved.
//

#import "HttpConnectionLogic.h"
#import "JSON.h"
#import "XBody.h"

@implementation HttpConnectionLogic

@synthesize httpConnectionDelegate;
@synthesize mainViewController;
@synthesize locateCity;
@synthesize updateCitys;
NSURLConnection *pm25Connection;
NSURLConnection *weatherConnection1;
NSURLConnection *weatherConnection2;
NSURLConnection *weatherConnection3;
NSURLConnection *getCityConnection;
NSURLConnection *getCitysConnection;
NSURLConnection *weatherOverSeasConnection;


static NSString *WEATHER_URL1 = @"http://www.weather.com.cn/data/sk/%@.html";
static NSString *WEATHER_URL2 = @"http://www.weather.com.cn/data/cityinfo/%@.html";
static NSString *PM25_URL = @"http://www.pm25.in/%@";
//static NSString *pm25TokenString = @"5j1znBVAsnSf5xQyNQyq";//公共测试api

//UIViewController *weatherDetailViewController;
//UIViewController *pm25DetailViewController;

static NSString *INTERNATIONAL_WEATHER_UIR=@"https://query.yahooapis.com/v1/public/yql?q=select * from weather.forecast where woeid=%@&format=json";

+(HttpConnectionLogic *)getInstance
{
    static HttpConnectionLogic *instance;
    if (instance == nil) {
        instance = [[HttpConnectionLogic alloc]init];
    }
    return instance;
}

-(void)init:(id)delegate
{
    httpConnectionDelegate = delegate;
    //weatherDetailViewController = viewController;
}
-(void)setPMDetailViewController:(UIViewController *)viewController
{
    //pm25DetailViewController = viewController;
}

-(NSString*)parseHtmlForWeatherImage:(NSString*)html{
    
    
    
    return  @"";
}
#pragma connection delegate
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSString *weatherString;
    if(weatherConnection1 == connection){
        @try {
            weatherString = [[NSString alloc] initWithData:data encoding: NSUTF8StringEncoding];
            NSMutableDictionary *jsonoObj = [weatherString JSONValue];
            NSMutableDictionary *jsonoSubObj = [jsonoObj objectForKey:@"weatherinfo"];
            NSMutableDictionary *weather = [XBody getWeather];
            [weather setObject:[jsonoSubObj objectForKey:WEATHER_CITY] forKey:WEATHER_CITY];
            [weather setObject:[jsonoSubObj objectForKey:WEATHER_TEMP] forKey:WEATHER_TEMP];
            [weather setObject:[jsonoSubObj objectForKey:WEATHER_WD] forKey:WEATHER_WD];
            [weather setObject:[jsonoSubObj objectForKey:WEATHER_WS] forKey:WEATHER_WS];
            [weather setObject:[jsonoSubObj objectForKey:WEATHER_SD] forKey:WEATHER_SD];
            [[XBody getInstance] setWeatherState_2:STATE_DATA_RECIEVED];
            NSLog(@"WEATHER_TEMP:%@",[weather objectForKey:WEATHER_TEMP]);
        }
        @catch (NSException *exception) {
            NSLog(@"WEATHER_TEMP NSException:%@",exception);
        }
    }
    if(weatherConnection2 == connection){
        @try {
            weatherString = [[NSString alloc] initWithData:data encoding: NSUTF8StringEncoding];
            NSMutableDictionary *jsonoObj = [weatherString JSONValue];
            NSMutableDictionary *jsonoSubObj = [jsonoObj objectForKey:@"weatherinfo"];
            NSMutableDictionary *weather = [XBody getWeather];
            [weather setObject:[jsonoSubObj objectForKey:WEATHER_CITYID] forKey:WEATHER_CITYID];
            [weather setObject:[jsonoSubObj objectForKey:WEATHER_IMG1] forKey:WEATHER_IMG1];
            [weather setObject:[jsonoSubObj objectForKey:WEATHER_IMG2] forKey:WEATHER_IMG2];
            [weather setObject:[jsonoSubObj objectForKey:WEATHER_TEMP1] forKey:WEATHER_TEMP1];
            [weather setObject:[jsonoSubObj objectForKey:WEATHER_TEMP2] forKey:WEATHER_TEMP2];
            [weather setObject:[jsonoSubObj objectForKey:WEATHER_WEATHER] forKey:WEATHER_WEATHER];
            [[XBody getInstance] setWeatherState_2:STATE_DATA_RECIEVED];
        }
        @catch (NSException *exception) {
            NSLog(@"WEATHER_WEATHER NSException:%@",exception);
        }
    }
    if(weatherConnection3 == connection){
        @try {
            weatherString = [[NSString alloc] initWithData:data encoding: NSUTF8StringEncoding];
            
          
            
            
            NSMutableDictionary *jsonoObj = [weatherString JSONValue];
            NSMutableDictionary *jsonQuery = [jsonoObj objectForKey:@"query"];
            NSMutableDictionary *jsonResults = [jsonQuery objectForKey:@"results"];
            NSMutableDictionary *jsonChannel = [jsonResults objectForKey:@"channel"];
            
            //获得湿度和风力
            NSMutableDictionary *jsonAtmosphere = [jsonChannel objectForKey:@"atmosphere"];
            NSString * humidity = [jsonAtmosphere objectForKey:@"humidity"];
            NSString * pressure = [jsonAtmosphere objectForKey:@"pressure"];
            
            NSLog(@"湿度: %@ , 风力: %@",humidity,pressure);
            
            //获得风速和风向
            
            NSMutableDictionary *jsonWind = [jsonChannel objectForKey:@"wind"];
            NSString * direction = [jsonWind objectForKey:@"direction"];
            NSString * speed = [jsonWind objectForKey:@"speed"];
            
               NSLog(@"风速: %@ , 风向: %@",speed,direction);
            
          
              NSMutableDictionary *jsonItem = [jsonChannel objectForKey:@"item"];
            
            //获得天气图片
            
            NSString *jsonDescription = [jsonItem objectForKey:@"description"];
            
            NSString *weatherImage;
            
            if(jsonDescription != nil){
                //NSLog(@"description %@",jsonDescription);
                NSArray * xmlArray = [jsonDescription componentsSeparatedByString:@"<br />"];
                for(int i =0 ;i <xmlArray.count;i++){
                    NSLog(@"\BR %@",[xmlArray objectAtIndex:i]);
                }
                if(xmlArray != nil){
                    NSArray *subStr =  [[xmlArray objectAtIndex:0]componentsSeparatedByString:@"\""];
                    if(subStr != nil){
                        
                        weatherImage = [subStr objectAtIndex:1];
                        NSLog(@"image url %@", weatherImage);
                        
                        
                    }
                    
                }
                
            }
            
          
            
            
            
            
              //获得温度
            NSMutableDictionary *jsonCondition= [jsonItem objectForKey:@"condition"];
            NSString * currTemp = [jsonCondition objectForKey:@"temp"];
            //获得天气状况：多云，雷阵雨
            
            NSString *text = [jsonCondition objectForKey:@"text"];
            
              NSLog(@"当前温度: %@, 状况 %@",currTemp,text);
            
            //获得最高温度和最低温度
            
            NSArray *jsonForecast =  [jsonItem objectForKey:@"forecast"];
            NSString *highTemp;
            NSString *lowTemp;
            if(jsonForecast != nil){
                
                NSMutableDictionary * forcast = [jsonForecast objectAtIndex:0];
                
               highTemp= [forcast objectForKey:@"high"];
               lowTemp = [forcast objectForKey:@"low"];
                
                
                  NSLog(@"最高温度: %@, 最低温度: %@",highTemp, lowTemp);
                
            }
            
            
            
            
            
            
            
            
            
            
            
            
            
              [[XBody getInstance] setWeatherState_2:STATE_DATA_RECIEVED];
            
            NSMutableDictionary *weather = [XBody getWeather];

            
            [weather setObject:[[XBody getInstance] currentCity]forKey:WEATHER_CITYID];
            
            [weather setObject:pressure forKey:WEATHER_WD];
            [weather setObject:speed forKey:WEATHER_WS];
            [weather setObject:humidity forKey:WEATHER_SD];;
            [weather setObject:highTemp forKey:WEATHER_TEMP1];
            [weather setObject:highTemp forKey:WEATHER_TEMP2];
            [weather setObject:lowTemp forKey:WEATHER_TEMP2];
            [weather setObject:text forKey:WEATHER_WEATHER];
            [weather setObject:currTemp forKey:WEATHER_TEMP];
            if(weatherImage != nil){
                [weather setObject:weatherImage forKey:WEATHER_IMG1];
            }
            
            [weather setObject:[[XBody getInstance] currentProvince]forKey:nil];
            [[XBody getInstance] setWeatherState_2:STATE_DATA_RECIEVED];
        }
        @catch (NSException *exception) {
            NSLog(@"WEATHER_WEATHER NSException:%@",exception);
        }

    }
    if(getCitysConnection == connection){
        @try {
            weatherString = [[NSString alloc] initWithData:data encoding: NSUTF8StringEncoding];
            
            
            
            NSMutableDictionary *jsonoObj = [weatherString JSONValue];
            NSArray *jsonoSubObj = [jsonoObj objectForKey:@"r"];
           
            
            
            
            
            XBody *xbody = [XBody getInstance];
            
            if(xbody.cities == nil){
                xbody.cities =  [[NSMutableArray alloc]init];
            }
            else{
                [xbody.cities removeAllObjects];
            }

            for (NSDictionary * city in jsonoSubObj) {
                //4.
                //NSString *cityName  = [city objectForKey:@"k"];
                NSString *detail  = [city objectForKey:@"d"];
                
                
                
               // NSLog(@"CITY detail :%@",detail);
                
                //=================
                
                NSMutableDictionary *city = [[NSMutableDictionary alloc]init];
                
                NSArray * str =[detail componentsSeparatedByString:@"&"];
                
                for(int i =0 ;i<str.count;i++){
                    
                    NSString * s = [str objectAtIndex:i];
                    NSString * woeid;
                    //NSLog(@"%@",s);
                    bool woeidRel = [s hasPrefix:@"woeid="];
                    if(woeidRel )
                    {
                        
                        
                        NSArray * woeidStr = [s componentsSeparatedByString:@"woeid="];
                        
                         woeid = [ woeidStr objectAtIndex:1];
                        
                        
                       NSLog(@"woeid: %@", woeid);
                    }
                    
                    bool cityRel =[s hasPrefix:@"n="];
                    NSString * cityName;
                    if(cityRel){
                        NSArray * cityStr = [s componentsSeparatedByString:@"n="];
                        
                       cityName = [ cityStr objectAtIndex:1];
                        
                        
                        NSLog(@"city: %@", cityName);
                        
                        
                    }
                    
                    if(cityName != nil ){
                        
                       
                        
                        [city setObject:cityName forKey:@"cityName"];

                    }
                    if(woeid != nil ){
                        
 
                        [city setObject:woeid forKey:@"woeid"];
                        
                       
                    }
                    
                   
                    
               }
            
                bool rel = false ;
                
                NSString *c =  [city objectForKey:@"cityName"];
                NSString *code = [city objectForKey:@"woeid"];
                
                if(c != nil && code != nil){
                    
                     [xbody.cities addObject:city];
                }
                
             
                
                //=================
                
                
                
               
                
                
                
            }
            
            [updateCitys update];

         }
        @catch (NSException *exception) {
            NSLog(@"WEATHER_WEATHER NSException:%@",exception);
        }

    }
    if(getCityConnection ==connection){
        @try {
            weatherString = [[NSString alloc] initWithData:data encoding: NSUTF8StringEncoding];

            NSMutableDictionary *jsonoObj = [weatherString JSONValue];
            NSMutableDictionary *jsonoSubObj = [jsonoObj objectForKey:@"query"];
            NSMutableDictionary *jsonResults = [jsonoSubObj objectForKey:@"results"];
            NSMutableDictionary *jsonResult = [jsonResults objectForKey:@"Result"];
            NSString *city = [jsonResult objectForKey:@"city"];
            
            NSString *woeid = [jsonResult objectForKey:@"woeid"];
            
            [locateCity cityLocated:city cityCode:woeid];
            
            [[XBody getInstance]setCurrentCityCode:woeid];
            
            [[XBody getInstance]setCurrentCity:city];
            
            NSLog(@"newyork weather info:%@,%@",city,woeid);
        }
        @catch (NSException *exception) {
            NSLog(@"WEATHER_WEATHER NSException:%@",exception);
        }
    }
    if(weatherOverSeasConnection ==connection){
        @try {
            weatherString = [[NSString alloc] initWithData:data encoding: NSUTF8StringEncoding];
            
            NSLog(@"weatherString: %@",weatherString);
            
//            NSMutableDictionary *jsonoObj = [weatherString JSONValue];
//            NSMutableDictionary *jsonoSubObj = [jsonoObj objectForKey:@"query"];
//            NSMutableDictionary *jsonResults = [jsonoSubObj objectForKey:@"results"];
//            NSMutableDictionary *jsonResult = [jsonResults objectForKey:@"Result"];
//            NSString *city = [jsonResult objectForKey:@"city"];
//            
//            NSString *woeid = [jsonResult objectForKey:@"woeid"];
//            
//            [locateCity cityLocated:city cityCode:woeid];
//            
//            [[XBody getInstance]setCurrentCityCode:woeid];
//            
//            [[XBody getInstance]setCurrentCity:city];
//
//            NSLog(@"newyork weather info:%@,%@",city,woeid);
        }
        @catch (NSException *exception) {
            NSLog(@"WEATHER_WEATHER NSException:%@",exception);
        }
    }
    if(pm25Connection == connection){
        //总是没有回答
        NSLog(@"pm25Connection");
    }
}

-(void) cityLocated:(NSString*)city cityCode:(NSString*)weiod{
    NSLog(@"city: %@, code:%@",city,weiod);
}

-(void) connection:(NSURLConnection *)connection
  didFailWithError: (NSError *)error {
    [[XBody getInstance] setWeatherState_2:STATE_DATA_ERROR];
    NSLog(@"connect error:%@",error);
}

-(void) connectionDidFinishLoading: (NSURLConnection*) connection {
    //[[XBody getInstance] setWeatherState_2:STATE_STOP];
    if(connection == pm25Connection){
        
    }else if(connection == weatherConnection1){
        
    }else if(connection == weatherConnection2){
        
    }
}

-(void)getCitys:(NSString *)cityName{
    
   
    
    int lang=[[XBody getInstance] getCurrentLanguage];
    //外文环境
    if(lang == 1){
        
        NSString *cityUrl = @"https://search.yahoo.com/sugg/gossip/gossip-gl-location/?appid=weather&output=sd1&command=";
        
        NSString *urlStr = [cityUrl stringByAppendingString:cityName];
        
        urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        
        
        NSURL *url = [NSURL URLWithString:urlStr];
        
        NSLog(@"city: %@",url);
        
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        
        getCitysConnection = [[NSURLConnection alloc] initWithRequest:request delegate:httpConnectionDelegate];
    }

    
    
}

-(void)getCityName:(CLLocation *)locaion{
    
    double a = locaion.coordinate.latitude;
    float b = locaion.coordinate.longitude;
    
    int lang=[[XBody getInstance] getCurrentLanguage];
    //外文环境
    if(lang == 1){
        
     NSString *cityUrl= [[NSString alloc]initWithFormat:@"http://query.yahooapis.com/v1/public/yql?q=select * from geo.placefinder where text= \"%f,%f\" and gflags=\"R\"&format=json", locaion.coordinate.latitude,locaion.coordinate.longitude];
        
        
        //= @"http://query.yahooapis.com/v1/public/yql?q=select * from geo.placefinder where text= \"31,104\" and gflags=\"R\"&format=json";
        
        
        
        cityUrl = [cityUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

        
        
        NSURL *url = [NSURL URLWithString:cityUrl];
        
          NSLog(@"city: %@",url);
       
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
       
        getCityConnection = [[NSURLConnection alloc] initWithRequest:request delegate:httpConnectionDelegate];
    }
    
   
    
}
//-(void)loadOverSeasWeather:(NSString*)woied{
//    
//    
//    NSString *weatherURL = [NSString stringWithFormat:INTERNATIONAL_WEATHER_UIR,woied];
//    
//    weatherURL = [weatherURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    
//    NSLog(@"weatherURL %@",weatherURL);
//    
//    NSURL *url = [NSURL URLWithString:weatherURL];
//    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
//    weatherOverSeasConnection = [[NSURLConnection alloc] initWithRequest:request delegate:httpConnectionDelegate];
//
//    
//}

//
-(void)loadWeather
{
    
    NSString *cityCode =[[XBody getInstance]currentCityCode];
    
    NSLog(@"loadWeather,%@,%@",[[XBody getInstance]currentCityCode],cityCode);
    int lang=[[XBody getInstance] getCurrentLanguage];
    
    //外文环境
    if(lang == 1){
        
        NSString *weatherURL = [NSString stringWithFormat:INTERNATIONAL_WEATHER_UIR,cityCode];
        
        weatherURL = [weatherURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSLog(@"weatherURL %@",weatherURL);
        
        NSURL *url = [NSURL URLWithString:weatherURL];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        weatherConnection3 = [[NSURLConnection alloc] initWithRequest:request delegate:httpConnectionDelegate];
        
    }
    else{
        NSString *weatherURL = [NSString stringWithFormat:WEATHER_URL1,[[XBody getInstance]currentCityCode]];
        NSURL *url = [NSURL URLWithString:weatherURL];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        weatherConnection1 = [[NSURLConnection alloc] initWithRequest:request delegate:httpConnectionDelegate];
        
        NSString *weatherURL2 = [NSString stringWithFormat:WEATHER_URL2,[[XBody getInstance]currentCityCode]];
        NSURL *url2 = [NSURL URLWithString:weatherURL2];
        NSURLRequest *request2 = [[NSURLRequest alloc] initWithURL:url2];
        weatherConnection2 = [[NSURLConnection alloc] initWithRequest:request2 delegate:httpConnectionDelegate];
        [[XBody getInstance] setWeatherState_2:STATE_START];
    }
    
    
    
    

}

-(void)loadPM25
{
    [self httpCreate_PM25:[NSString stringWithFormat:@"http://www.pm25.in/%@",[XBody getInstance].currentCityCode_pm25]];
    [[XBody getInstance] setPm25State_2:STATE_START];
}

//
-(void)httpCreate_PM25:(NSString *)URLString
{
    //STEP 1： 创建URL
    NSURL *finalURL = [NSURL URLWithString:[URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    //STEP 2：创建URLRequest
    NSMutableURLRequest *pm25URLRequest = [[NSMutableURLRequest alloc]initWithURL:finalURL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
    //如果是GET
    [pm25URLRequest setHTTPMethod:@"GET"];
    //STEP 3：通过NSURLConnection实现请求
    //一般有两种方式，如果不需要知道请求的进度，比如文字上传，那么用简单的异步请求。如下：
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    NSLog(@"sendAsynchronousRequest URLRequest URL %@",[pm25URLRequest URL]);
    [NSURLConnection sendAsynchronousRequest:pm25URLRequest queue:queue completionHandler:^(NSURLResponse*response,NSData *data,NSError *error)
     {
         //NSLog(@"sendAsynchronousRequest,response:%@,data:%@",response,data);
         NSString *pm25String = [[NSString alloc] initWithData:data encoding: NSUTF8StringEncoding];
         //NSLog(@"sendAsynchronousRequest connection didReceiveData %@", pm25String);
         //清除数据 PM_DATA_PM2_5_1H
         [[XBody getInstance].pm25CurrentCityDataDic setValue:@"" forKey:PM_DATA_PM2_5_1H];
         //
         @try {
             //初始化变量
             NSRegularExpression *reg_space = [NSRegularExpression regularExpressionWithPattern:@"[\\s]" options:NSRegularExpressionCaseInsensitive error:nil];
             
             //获取PM2.5参数数据
             NSString * patten_value = [NSString stringWithFormat:@"<div class\\s?=\\s?\"value\">(.|[\r\n])*?</div>"];
             NSString * patten_tagName = [NSString stringWithFormat:@"<div class\\s?=\\s?\"caption\">(.|[\r\n])*?</div>"];
             NSString * patten = [NSString stringWithFormat:@"%@\\s*?%@",patten_value,patten_tagName];
             NSString * patten_value_data = [NSString stringWithFormat:@"(?<=<div class\\s?=\\s?\"value\">)(.|[\r\n])*?(?=\\n*</div>)"];
             NSString * patten_tagName_data = [NSString stringWithFormat:@"(?<=<div class\\s?=\\s?\"caption\">)(.|[\r\n])*?(?=\\n*</div>)"];
             NSArray *arr = [[XBody getInstance]regularMatch:pm25String patten:patten];
             for (NSString* str in arr) {
                 NSArray *arr_value = [[XBody getInstance]regularMatch:str patten:patten_value_data];
                 NSArray *arr_tagName = [[XBody getInstance]regularMatch:str patten:patten_tagName_data];
                 NSMutableString * value = [[NSMutableString alloc]initWithString:[arr_value objectAtIndex:0]];
                 NSMutableString * tagName = [[NSMutableString alloc]initWithString:[arr_tagName objectAtIndex:0]];
                 [reg_space replaceMatchesInString:value options:NSMatchingReportCompletion range:NSMakeRange(0, [value length]) withTemplate:@""];
                 [reg_space replaceMatchesInString:tagName options:NSMatchingReportCompletion range:NSMakeRange(0, [tagName length]) withTemplate:@""];
                 [[XBody getInstance].pm25CurrentCityDataDic setValue:value forKey:tagName];
                 
             }
             //获取时间
             NSString * patten_live_data_time = [NSString stringWithFormat:@"<div class\\s?=\\s?\"live_data_time\">(.|[\r\n])*?</div>"];
             NSString * patten_live_time_str = [NSString stringWithFormat:@"([\\d]{4})-([\\d]{2})-([\\d]{2}) ([\\d]{2}):([\\d]{2})"];
             NSArray *arr_time = [[XBody getInstance]regularMatch:pm25String patten:patten_live_data_time];
             NSArray *arr_time_str = [[XBody getInstance]regularMatch:[arr_time objectAtIndex:0] patten:patten_live_time_str];
             [[XBody getInstance].pm25CurrentCityDataDic setValue:[arr_time_str objectAtIndex:0] forKey:@"live_data_time"];
             //<p>对健康影响情况：
             NSString * patten_health_affect = [NSString stringWithFormat:@"(?<=<p>对健康影响情况：)(.|[\r\n])*?(?=\\n*</p>)"];
             NSArray *arr_health_affect = [[XBody getInstance]regularMatch:pm25String patten:patten_health_affect];
             NSMutableString * health_affect = [[NSMutableString alloc]initWithString:[arr_health_affect objectAtIndex:0]];
             [reg_space replaceMatchesInString:health_affect options:NSMatchingReportCompletion range:NSMakeRange(0, [health_affect length]) withTemplate:@""];
             [[XBody getInstance].pm25CurrentCityDataDic setValue:health_affect forKey:PM_DATA_AFFECT];
             //<p>建议采取的措施：
             NSString * patten_health_action = [NSString stringWithFormat:@"(?<=<p>建议采取的措施：)(.|[\r\n])*?(?=\\n*</p>)"];
             NSArray *arr_health_action = [[XBody getInstance]regularMatch:pm25String patten:patten_health_action];
             NSMutableString * health_action = [[NSMutableString alloc]initWithString:[arr_health_action objectAtIndex:0]];
             
             [reg_space replaceMatchesInString:health_action options:NSMatchingReportCompletion range:NSMakeRange(0, [health_action length]) withTemplate:@""];
             [[XBody getInstance].pm25CurrentCityDataDic setValue:health_action forKey:PM_DATA_ACTION];
             
         }
         @catch (NSException *exception) {
             NSLog(@"match exception");
         }
         NSLog(@"pm25CurrentCityDic:%@",[XBody getInstance].pm25CurrentCityDataDic);
         [[XBody getInstance] setPm25State_2:STATE_DATA_RECIEVED];
     }];
}
@end
