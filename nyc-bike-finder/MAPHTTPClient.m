//
//  MAPHTTPClient.m
//  nyc-bike-finder
//
//  Created by Joseph Misiti on 10/20/15.
//  Copyright © 2015 Math And Pencil LLC. All rights reserved.
//

#import "MAPHTTPClient.h"

@implementation MAPHTTPClient


+ (MAPHTTPClient *)sharedClient{
    static MAPHTTPClient *sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [[self alloc] init];
        NSMutableSet *newSet=[NSMutableSet set];
        newSet.set = sharedClient.responseSerializer.acceptableContentTypes;
        [newSet addObject:@"text/html"];
        [newSet addObject:@"application/json"];
        [newSet addObject:@"text/json"];
        [newSet addObject:@"text/javascript"];
        [newSet addObject:@"text/plain"];
        sharedClient.responseSerializer.acceptableContentTypes = newSet;
    });
    return sharedClient;
}

- (void)uploadStations:(NSDictionary *)params
               success:(MAPHTTPClientSuccess)success
               failure:(MAPHTTPClientFailure)failure {
    
    [self GET:kCitiBikeStationURL parameters:params
        success:^(AFHTTPRequestOperation *operation, id responseObject){
        if(success){
            success((AFHTTPRequestOperation *)operation, responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure((AFHTTPRequestOperation *)operation, error);
        }
    }];
    
}


@end
