//
//  MAPMathUtils.h
//  nyc-bike-finder
//
//  Created by Joseph Misiti on 10/20/15.
//  Copyright © 2015 Math And Pencil LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MAPMathUtils : NSObject

-(CLLocationDistance)calcualateLLDistance:(CLLocationDegrees)latX
            longX:(CLLocationDegrees)longX
            latY:(CLLocationDegrees)latY
            longY:(CLLocationDegrees)longY;


-(NSArray*)sortByKey:(NSMutableArray*)a
        key:(NSString*)key
        ascending:(BOOL)ascending;

@end
