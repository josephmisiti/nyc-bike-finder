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
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
    [self.locationManager requestAlwaysAuthorization];
}

-(void)updateCurrentLocation {
    float Lat = self.locationManager.location.coordinate.latitude;
    float Long = self.locationManager.location.coordinate.longitude;
    NSLog(@"Lat : %f  Long : %f",Lat,Long);
}

@end
