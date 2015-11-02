//
//  MAPBase.m
//  nyc-bike-finder
//
//  Created by Joseph Misiti on 10/20/15.
//  Copyright © 2015 Math And Pencil LLC. All rights reserved.
//

#import "MAPBase.h"
#import "MAPPullToRefreshView.h"

@implementation MAPBase

@synthesize tableData = _tableData;
@synthesize loading = _loading;
@synthesize pullToRefreshView = _pullToRefreshView;

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableData = [[NSMutableArray alloc] init];
    
    _pullToRefreshView = [[MAPPullToRefreshView alloc]
                          initWithScrollView:self.tableView delegate:(id)self];
    _pullToRefreshView.backgroundColor = UIColorFromRGB(kColorPink);
    _pullToRefreshView.layer.borderColor = UIColorFromRGB(kColorPink).CGColor;
    _pullToRefreshView.layer.borderWidth = 1.0f;
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


#pragma mark - NSObject

- (void)dealloc {
    _pullToRefreshView.delegate = nil;
    [_pullToRefreshView removeFromSuperview];
    _pullToRefreshView = nil;
}

- (void)setLoading:(BOOL)loading animated:(BOOL)animated {
    if (self.loading) {
        [self.pullToRefreshView startLoading];
    } else {
        [self.pullToRefreshView finishLoading];
    }
}

- (void)pullToRefreshViewDidStartLoading:(SSPullToRefreshView *)view {
    [self refresh:view];
}

@end
