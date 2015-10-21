//
//  MAPStationList.m
//  nyc-bike-finder
//
//  Created by Joseph Misiti on 10/20/15.
//  Copyright © 2015 Math And Pencil LLC. All rights reserved.
//

#import "MAPStationList.h"
#import "MAPHTTPClient.h"
#import "Station.h"

@interface MAPStationList ()

@end

@implementation MAPStationList

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self refresh:nil];
}

#pragma mark - inheritence

-(void)refresh:(id)sender {
    MAPHTTPClient* client = [MAPHTTPClient sharedClient];
    [client uploadStations:@{} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dictionary = (NSDictionary *)responseObject;
        for (NSDictionary *stationDictionary in [dictionary objectForKey:@"stationBeanList"]) {
            Station *station = [Station fromJSON:stationDictionary];
            [self.tableData addObject:station];
            NSLog(@"%@", station);
            
            
        }        //
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error=%@", error);
    }];
}


@end
