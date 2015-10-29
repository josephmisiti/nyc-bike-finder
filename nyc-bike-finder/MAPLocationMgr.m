//
//  MAPLocationMgr.m
//  nyc-bike-finder
//
//  Created by Joseph Misiti on 10/28/15.
//  Copyright © 2015 Math And Pencil LLC. All rights reserved.
//

#import "MAPLocationMgr.h"

@implementation MAPLocationMgr

@synthesize locationManager = _locationManager;

-(CLLocationManager*)locationManager{
    if(!_locationManager){
        _locationManager = [[CLLocationManager alloc] init];
    }
    return _locationManager;
}


-(void)initialize {
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager requestAlwaysAuthorization];
}

-(void)updateCurrentLocation {
    float latitude = self.locationManager.location.coordinate.latitude;
    float longitude = self.locationManager.location.coordinate.longitude;
    [self saveCurrentLocation:latitude longitude:longitude];
}

-(void)saveCurrentLocation:(float)latitude longitude:(float)longitude {
    NSLog(@"--- saveCurrentLocation: latitude : %f  longitude : %f", latitude, longitude);
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:[NSNumber numberWithFloat:latitude] forKey:@"latitude"];
    [userDefaults setValue:[NSNumber numberWithFloat:longitude] forKey:@"longitude"];
}

@end
