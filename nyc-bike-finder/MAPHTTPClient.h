//
//  MAPHttpClient.h
//  nyc-bike-finder
//
//  Created by Joseph Misiti on 10/20/15.
//  Copyright © 2015 Math And Pencil LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFNetworking.h"

typedef void (^MAPHTTPClientSuccess)(AFHTTPRequestOperation *operation, id responseObject);
typedef void (^MAPHTTPClientFailure)(AFHTTPRequestOperation *operation, NSError *error);


@interface MAPHTTPClient : AFHTTPRequestOperationManager

+ (MAPHTTPClient *)sharedClient;

- (void)uploadStations:(NSDictionary *)params
           success:(MAPHTTPClientSuccess)success
           failure:(MAPHTTPClientFailure)failure;



@end
