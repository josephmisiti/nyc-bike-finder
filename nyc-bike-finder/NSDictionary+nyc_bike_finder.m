//
//  NSDictionary+nyc_bike_finder.m
//  nyc-bike-finder
//
//  Created by Joseph Misiti on 10/20/15.
//  Copyright © 2015 Math And Pencil LLC. All rights reserved.
//

#import "NSDictionary+nyc_bike_finder.h"

@implementation NSDictionary (nyc_bike_finder)

- (id)safeObjectForKey:(id)key {
    id value = [self valueForKey:key];
    if (value == [NSNull null]) {
        return nil;
    }
    return value;
}


@end
