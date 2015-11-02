//
//  MAPLocationMgr.h
//  nyc-bike-finder
//
//  Created by Joseph Misiti on 10/28/15.
//  Copyright © 2015 Math And Pencil LLC. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

@interface MAPLocationMgr : NSObject

@property (nonatomic, strong) CLLocationManager* locationManager;
@property (nonatomic) float latitude;
@property (nonatomic) float longitude;


-(void)initialize;
-(void)updateCurrentLocation;

-(void)saveCurrentLocation:(float)latitude longitude:(float)longitude;


@end
