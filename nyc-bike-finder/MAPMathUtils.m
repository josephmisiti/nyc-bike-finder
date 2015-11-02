//
//  MAPMathUtils.m
//  nyc-bike-finder
//
//  Created by Joseph Misiti on 10/20/15.
//  Copyright © 2015 Math And Pencil LLC. All rights reserved.
//

#import "MAPMathUtils.h"

@implementation MAPMathUtils

+(CLLocationDistance)calcualateLLDistance:(float)latX
                longX:(float)longX
                 latY:(float)latY
                longY:(float)longY {
    
    
    CLLocation *locX = [[CLLocation alloc] initWithLatitude:(CLLocationDegrees)latX
                                                  longitude:(CLLocationDegrees)longX];
    CLLocation *locY = [[CLLocation alloc] initWithLatitude:(CLLocationDegrees)latY
                                                  longitude:(CLLocationDegrees)longY];
    
    
    CLLocationDistance distance = [locX distanceFromLocation:locY];
    NSLog(@"-- calcualateLLDistance: distance %f", distance);
    return distance;
}


-(NSArray*)sortByKey:(NSMutableArray*)a key:(NSString*)key ascending:(BOOL)ascending {

    NSSortDescriptor * sortDescriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:ascending];
    NSArray * descriptors = [NSArray arrayWithObject:sortDescriptor];
    return [a sortedArrayUsingDescriptors:descriptors];

}


@end
