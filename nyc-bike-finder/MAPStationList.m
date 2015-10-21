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
#import "StationCell.h"

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


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    StationCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (cell == nil) {
        cell = [[StationCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:@"CELL"];
    }
    
    Station* station = [self.tableData objectAtIndex:indexPath.row];
    [cell setStation:station];
    
    return cell;
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
        }
        [self reloadDataWithAnimation];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error=%@", error);
    }];
}

#pragma mark - UITableViewController


- (NSInteger)numberOfSectionsInTableView:
(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    
    return [self.tableData count];
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kCellHeight;
}

@end
