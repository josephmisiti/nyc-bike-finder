//
//  Station.m
//  nyc-bike-finder
//
//  Created by Joseph Misiti on 10/20/15.
//  Copyright © 2015 Math And Pencil LLC. All rights reserved.
//

#import "Station.h"
#import "NSDictionary+nyc_bike_finder.h"

@implementation Station

+(Station*)fromJSON:(NSDictionary*)dictionary {
    Station* station = [[Station alloc] init];
    station.stationID = [[dictionary safeObjectForKey:@"id"] integerValue];
    station.stationName = [dictionary safeObjectForKey:@"stationName"];
    station.availableDocks = [[dictionary safeObjectForKey:@"availableDocks"] integerValue];
    station.totalDocks = [[dictionary safeObjectForKey:@"totalDocks"] integerValue];
    station.latitude = [[dictionary safeObjectForKey:@"latitude"] floatValue];
    station.longitude = [[dictionary safeObjectForKey:@"longitude"] floatValue];
    station.statusValue = [dictionary safeObjectForKey:@"statusValue"];
    station.statusKey = [[dictionary safeObjectForKey:@"statusKey"] integerValue];
    station.availableBikes = [[dictionary safeObjectForKey:@"availableBikes"] integerValue];
    station.statusValue = [dictionary safeObjectForKey:@"statusValue"];
    station.stAddress1 = [dictionary safeObjectForKey:@"stAddress1"];
    station.stAddress2 = [dictionary safeObjectForKey:@"stAddress2"];
    station.city = [dictionary safeObjectForKey:@"city"];
    station.postalCode = [dictionary safeObjectForKey:@"postalCode"];
    station.location = [dictionary safeObjectForKey:@"location"];
    station.altitude = [dictionary safeObjectForKey:@"altitude"];
    station.lastCommunicationTime = [dictionary safeObjectForKey:@"lastCommunicationTime"];
    station.landMark = [dictionary safeObjectForKey:@"landMark"];

    return station;
}

- (NSString *)description {
    return [NSString stringWithFormat:
            @"Station: %i %@", self.stationID, self.stationName];
}

@end
