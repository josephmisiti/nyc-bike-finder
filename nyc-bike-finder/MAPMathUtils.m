//
//  MAPMathUtils.m
//  nyc-bike-finder
//
//  Created by Joseph Misiti on 10/20/15.
//  Copyright © 2015 Math And Pencil LLC. All rights reserved.
//

#import "MAPMathUtils.h"

@implementation MAPMathUtils

-(CLLocationDistance)calcualateLLDistance:(CLLocationDegrees)latX
                longX:(CLLocationDegrees)longX
                 latY:(CLLocationDegrees)latY
                longY:(CLLocationDegrees)longY {
    
    
    CLLocation *locX = [[CLLocation alloc] initWithLatitude:latX longitude:longX];
    CLLocation *locY = [[CLLocation alloc] initWithLatitude:latY longitude:longY];
    return [locX distanceFromLocation:locY];
}


-(NSArray*)sortByKey:(NSMutableArray*)a key:(NSString*)key ascending:(BOOL)ascending {

    NSSortDescriptor * sortDescriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:ascending];
    NSArray * descriptors = [NSArray arrayWithObject:sortDescriptor];
    return [a sortedArrayUsingDescriptors:descriptors];

}


@end
