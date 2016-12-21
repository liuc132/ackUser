//
//  GPSLocationInformation.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/11/8.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "GPSLocationInformation.h"
#import <UIKit/UIKit.h>

@interface GPSLocationInformation ()<CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;


@end

@implementation GPSLocationInformation

+ (instancetype)sharedManager {
    static GPSLocationInformation *gpsLocation = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        gpsLocation = [[GPSLocationInformation alloc] init];
        [gpsLocation gpsInitialization];
    });
    
    return gpsLocation;
}

- (void)gpsInitialization
{
    //GPS初始化
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    //    self.locationManager.allowsBackgroundLocationUpdates = YES;
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8)
    {
        if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
            [self.locationManager requestAlwaysAuthorization];
            NSLog(@"ENTER requestAlwaysAuthorization");
        }
    }
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9)
    {
        self.locationManager.allowsBackgroundLocationUpdates = YES;
    }
    if([CLLocationManager significantLocationChangeMonitoringAvailable] == YES)
    {
        [self.locationManager startMonitoringSignificantLocationChanges];
    }
    
    [self.locationManager startUpdatingLocation];
}

/**
 *  查询到areaid
 *
 *  @param areaName areaName 通过定位信息中所读取到的位置信息
 *
 *  @return return value 返回的是当前所定为到的位置的areaid
 */
- (NSString *)getAreaIDbylocationName:(NSString *)areaName
{
    NSString *theAreaID;
    //
    NSString *areaIDPlistPath = [[NSBundle mainBundle] pathForResource:@"areaID" ofType:@"plist"];
    
    NSArray *areaIDArray = [[NSArray alloc] initWithContentsOfFile:areaIDPlistPath];
    //进行查询
    for (NSDictionary *areaDic in areaIDArray) {
        NSString *areaNameAsPrefix = areaDic[@"NAMECN"];
        //        NSLog(@"%@",areaNameAsPrefix);
        if ([areaName hasPrefix:areaNameAsPrefix]) {
            theAreaID = areaDic[@"AREAID"];
            break;//查到之后就直接退出查询
        }
        
    }
    //
    
    return theAreaID;
}

#pragma mark -CLLocationDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *cacheLocation = [locations lastObject];
    NSDate *eventDate = cacheLocation.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (fabs(howRecent) < 1.0) {
        //if the event is recent,do something with it.
//        _getGPSLocation = cacheLocation;
        [self searchTheCityNameID:cacheLocation];
        [_locationManager stopUpdatingLocation];
    }

}

/**
 *  根据所提供的GPS地理信息，反编译查询出当前地区的areaID
 *
 *  @param currentLoaction currentLoaction 传入的GPS地理信息，类型为CLLocation
 *
 *  @return return value 返回的是查询出来的areaID
 */
- (NSString *)searchTheCityNameID:(CLLocation *)currentLoaction
{
    __weak typeof(self) weakSelf = self;
    //
    __block NSString *cityID;
    //获取到当前的城市名称
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    //根据地理信息编译出地址信息
    [geoCoder reverseGeocodeLocation:currentLoaction completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        //
        if (placemarks.count) {
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            //获取城市
            //NSString *city = placemark.locality;
            //if (!city) {
            //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
            //city = placemark.administrativeArea;
            //}
            
            //查询获取到areaID，默认设置成administrativeArea（省／四大直辖市）
            cityID = [strongSelf getAreaIDbylocationName:placemark.administrativeArea];
            if (placemark.subLocality) {
                NSString *subLocalityAreaID;
                subLocalityAreaID = [strongSelf getAreaIDbylocationName:placemark.subLocality];
                if (subLocalityAreaID) {
                    cityID = subLocalityAreaID;
                }
                else if(placemark.locality)
                {
                    NSString *localityAreaID;
                    localityAreaID = [strongSelf getAreaIDbylocationName:placemark.locality];
                    if (localityAreaID) {
                        cityID = localityAreaID;
                    }
                }
            }
            
        }
        else if (error == nil && [placemarks count] == 0)
        {
            NSLog(@"No results were returned.");
        }
        else if (error != nil)
        {
            NSLog(@"An error occurred = %@", error);
        }
        
    }];
    
    return cityID;
}







@end
