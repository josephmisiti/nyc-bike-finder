//
//  MAPStationList.m
//  nyc-bike-finder
//
//  Created by Joseph Misiti on 10/20/15.
//  Copyright © 2015 Math And Pencil LLC. All rights reserved.
//


#import "Station.h"
#import "StationCell.h"
#import "MAPStationList.h"
#import "MAPHTTPClient.h"
#import "MAPWebViewController.h"
#import "MAPLocationMgr.h"
#import "MAPSettings.h"
#import "DBUtils.h"

@interface MAPStationList ()

@end

@implementation MAPStationList {
    MAPLocationMgr* _locationMgr;
    DBUtils* dbClient;
}

@synthesize webView = _webView;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    dbClient = [DBUtils sharedClient];
    
    [self applyStyleSheets];
    _locationMgr = [[MAPLocationMgr alloc] init];
    [_locationMgr initialize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self refresh:nil];
    [_locationMgr updateCurrentLocation];
}

-(MAPWebViewController*)webView{
    if(!_webView){
        _webView = [[MAPWebViewController alloc] init];
    }
    return _webView;
}

-(MAPSettings*)settingsView{
    if(!_settingsView){
        _settingsView = [[MAPSettings alloc] init];
    }
    return _settingsView;
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
    if (self.loading) {
        return;
    }

    self.loading = YES;
    MAPHTTPClient* client = [MAPHTTPClient sharedClient];
    [client uploadStations:@{} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dictionary = (NSDictionary *)responseObject;
        [self.tableData removeAllObjects];
        for (NSDictionary *stationDictionary in [dictionary objectForKey:@"stationBeanList"]) {
            Station *station = [Station fromJSON:stationDictionary];
            station.currentLatitude = _locationMgr.latitude;
            station.currentLongitude = _locationMgr.longitude;
            [station performDistanceCalcuations];
            [self.tableData addObject:station];
            self.loading = NO;
            
            NSSortDescriptor *sort = [NSSortDescriptor
                    sortDescriptorWithKey:@"distanceFromLocation" ascending:YES];
            [self.tableData sortUsingDescriptors:[NSArray arrayWithObject:sort]];
            [self setLoading:NO animated:YES];
            
            
        }
        [self reloadDataWithAnimation];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error=%@", error);
        self.loading = NO;
        [self setLoading:NO animated:YES];
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

// #pragma mark - SAMWebView
//
//- (void)webViewDidFinishLoadingPage:(SAMWebView *)aWebView{
//    //    // http://codegerms.com/login-with-twitter-example-with-ios-tutorial-using-oauth/
//    //    NSString *theAbsoluteURL = [NSString stringWithFormat:@"%@",aWebView.request.URL.absoluteString];
//    //    NSRange textRange = [[theAbsoluteURL lowercaseString] rangeOfString:[@"api/authenicated" lowercaseString]];
//    //    if(textRange.location != NSNotFound){
//    //        //[self.navigationController dismissModalViewControllerAnimated:YES];
//    //        [self dismissViewControllerAnimated:NO completion:nil];
//    //        loginSuccess = YES;
//    //    }
//}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Station* station = [self.tableData objectAtIndex:indexPath.row];
    [self.webView.webView loadURLString:station.googleMapsUrl];
    self.webView.latitude = station.latitude;
    self.webView.longitude = station.longitude;
    self.webView.webView.delegate = (id)self;
    [self.webView applyMapZoomWithPins:self.tableData];
    
    UINavigationController *navigationController = [[UINavigationController alloc]
                                                    initWithRootViewController:_webView];
    navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
    [self.navigationController presentViewController:navigationController animated:YES completion:nil];
}

-(void)applyStyleSheets {
    // override in base class
    CGFloat imageHeight = self.navigationController.navigationBar.frame.size.height - 25.0f;
    UIButton* backButton =  [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, imageHeight, imageHeight)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"settings-50"] forState:UIControlStateNormal];
    UIBarButtonItem *barBackButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [backButton addTarget:self action:@selector(onClickSettings:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = barBackButtonItem;
}

-(void)onClickSettings:(id)sender{
    NSLog(@"--- onClickSettings");
    UINavigationController *navigationController = [[UINavigationController alloc]
                                initWithRootViewController:self.settingsView];

    navigationController.navigationBar.hidden = YES;
    navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
    [self.navigationController presentViewController:navigationController
                                            animated:YES completion:nil];

}



@end
