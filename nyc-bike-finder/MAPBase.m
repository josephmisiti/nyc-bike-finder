//
//  MAPBase.m
//  nyc-bike-finder
//
//  Created by Joseph Misiti on 10/20/15.
//  Copyright © 2015 Math And Pencil LLC. All rights reserved.
//

#import "MAPBase.h"

@implementation MAPBase

@synthesize tableData = _tableData;
@synthesize loading = _loading;

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableData = [[NSMutableArray alloc] init];
}

-(void)refresh:(id)sender {
    // override in base class
}

-(void)applyStyleSheets {
    // override in base class
}

-(void)reloadDataWithAnimation {
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0]
                  withRowAnimation:UITableViewRowAnimationFade];
}


@end
