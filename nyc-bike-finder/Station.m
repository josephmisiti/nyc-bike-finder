//
//  Station.m
//  nyc-bike-finder
//
//  Created by Joseph Misiti on 10/20/15.
//  Copyright © 2015 Math And Pencil LLC. All rights reserved.
//

#import "Station.h"
#import "NSDictionary+nyc_bike_finder.h"
#import "MAPMathUtils.h"
#import <CoreLocation/CoreLocation.h>

@implementation Station

+(Station*)fromJSON:(NSDictionary*)dictionary {
    Station* station = [[Station alloc] init];
    station.stationID = (int)[[dictionary safeObjectForKey:@"id"] integerValue];
    station.stationName = [dictionary safeObjectForKey:@"stationName"];
    station.availableDocks = (int)[[dictionary safeObjectForKey:@"availableDocks"] integerValue];
    station.totalDocks = (int)[[dictionary safeObjectForKey:@"totalDocks"] integerValue];
    station.latitude = [[dictionary safeObjectForKey:@"latitude"] floatValue];
    station.longitude = [[dictionary safeObjectForKey:@"longitude"] floatValue];
    station.statusValue = [dictionary safeObjectForKey:@"statusValue"];
    station.statusKey = (int)[[dictionary safeObjectForKey:@"statusKey"] integerValue];
    station.availableBikes = (int)[[dictionary safeObjectForKey:@"availableBikes"] integerValue];
    station.statusValue = [dictionary safeObjectForKey:@"statusValue"];
    station.stAddress1 = [dictionary safeObjectForKey:@"stAddress1"];
    station.stAddress2 = [dictionary safeObjectForKey:@"stAddress2"];
    station.city = [dictionary safeObjectForKey:@"city"];
    station.postalCode = [dictionary safeObjectForKey:@"postalCode"];
    station.location = [dictionary safeObjectForKey:@"location"];
    station.altitude = [dictionary safeObjectForKey:@"altitude"];
    station.lastCommunicationTime = [dictionary safeObjectForKey:@"lastCommunicationTime"];
    station.landMark = [dictionary safeObjectForKey:@"landMark"];
    
    // station.distanceFromCurrentLocation == ??
    
    return station;
}

- (NSString *)description {
    return [NSString stringWithFormat:
            @"Station: %i %@ %@",
                self.stationID,
                self.stationName, self.googleMapsUrl];
}

-(void)performDistanceCalcuations {
    CLLocationDistance distance = [MAPMathUtils calcualateLLDistance:self.currentLatitude
                                longX:self.currentLongitude
                                latY:self.latitude
                                longY:self.longitude];
    self.distanceFromLocation = distance;
}

@end
