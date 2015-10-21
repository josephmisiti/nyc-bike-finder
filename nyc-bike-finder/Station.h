//
//  Station.h
//  nyc-bike-finder
//
//  Created by Joseph Misiti on 10/20/15.
//  Copyright © 2015 Math And Pencil LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Station : NSObject


@property (nonatomic) int stationID;
@property (nonatomic, strong) NSString* stationName;
@property (nonatomic) int availableDocks;
@property (nonatomic) int totalDocks;
@property (nonatomic) float latitude;
@property (nonatomic) float longitude;
@property (nonatomic, strong) NSString* statusValue;
@property (nonatomic) int statusKey;
@property (nonatomic) int availableBikes;
@property (nonatomic, strong) NSString* stAddress1;
@property (nonatomic, strong) NSString* stAddress2;
@property (nonatomic, strong) NSString* city;
@property (nonatomic, strong) NSString* postalCode;
@property (nonatomic, strong) NSString* location;
@property (nonatomic, strong) NSString* altitude;
@property (nonatomic, strong) NSDate* lastCommunicationTime;
@property (nonatomic, strong) NSString* landMark;
@property (nonatomic, strong) NSString* googleMapsUrl;


//testStation: false,


+(Station*)fromJSON:(NSDictionary*)dictionary;
-(NSString*)getGoogleMapsURL;

@end
