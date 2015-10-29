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

-(void)initialize;
-(void)updateCurrentLocation;

@end
