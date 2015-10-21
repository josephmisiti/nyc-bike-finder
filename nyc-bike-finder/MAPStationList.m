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

@interface MAPStationList ()

@end

@implementation MAPStationList

@synthesize webView = _webView;

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

#pragma mark - SAMWebView

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
    //self.webView.webView loadURLString:kFacebookConnectURL];
    //_webView.webView.delegate = (id)self;
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:_webView];
    navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
    [self.navigationController presentViewController:navigationController animated:YES completion:nil];
}




@end
