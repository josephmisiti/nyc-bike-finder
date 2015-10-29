//
//  MAPWebViewController.m
//  nyc-bike-finder
//
//  Created by Joseph Misiti on 10/20/15.
//  Copyright © 2015 Math And Pencil LLC. All rights reserved.
//

#import "MAPWebViewController.h"
#import "Station.h"

@implementation MAPWebViewController

@synthesize topCoverView = _topCoverView;
@synthesize bottomCoverView = _bottomCoverView;
@synthesize finishedButton = _finishedButton;
@synthesize mapView = _mapView;

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.view addSubview: self.mapView];
    //[self.view addSubview:self.topCoverView];
    //[self.bottomCoverView addSubview:self.finishedButton];
    [self.view addSubview:self.finishedButton];
    
    self.navigationController.navigationBar.hidden = YES;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.toolbarHidden = YES;
}

#pragma mark - lazy evaluation

-(MKMapView*)mapView {
    if(!_mapView){
        _mapView = [[MKMapView alloc] initWithFrame:self.view.frame];
    }
    return _mapView;
}

-(UIButton*)finishedButton{
    if(!_finishedButton){
        CGFloat height = 200.0f;
        CGFloat yOffset = self.view.frame.size.height - height;
        _finishedButton = [[UIButton alloc] init];
        _finishedButton.frame = CGRectMake(0.0f,yOffset,self.view.frame.size.width, height);
        _finishedButton.backgroundColor = [UIColor redColor];
        [_finishedButton addTarget:self action:@selector(onClickHideWebView:)
            forControlEvents:UIControlEventTouchUpInside];

    }
    return _finishedButton;
}

-(UIView*)topCoverView {
    if(!_topCoverView){
        _topCoverView = [[UIView alloc] init];
        _topCoverView.frame = CGRectMake(0.0f,0.0f,self.view.frame.size.width, 100.0f);
        _topCoverView.backgroundColor = [UIColor blackColor];
    }
    return _topCoverView;
}

-(UIView*)bottomCoverView {
    if(!_bottomCoverView){
        CGFloat height = 200.0f;
        CGFloat yOffset = self.view.frame.size.height - height;
        _bottomCoverView = [[UIView alloc] init];
        _bottomCoverView.frame = CGRectMake(0.0f,yOffset,self.view.frame.size.width, height);
        _bottomCoverView.backgroundColor = [UIColor blackColor];
    }
    return _bottomCoverView;
}

#pragma mark - click events

-(void)onClickHideWebView:(id)sender{
    NSLog(@"--- onClickHideWebView");
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)applyMapZoomWithPins:(NSMutableArray*)stations {
    NSLog(@"---- applyMapZoomWithPins");
    // based on http://stackoverflow.com/a/22492566/323578
    
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(40.720356, -73.984863);
    MKCoordinateSpan span = MKCoordinateSpanMake(0.01f, 0.01f);
    MKCoordinateRegion region = {coord, span};
    
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    [annotation setCoordinate:coord];
    
    [self.mapView setRegion:region];
    [self.mapView addAnnotation:annotation];
    
    for (Station*station in stations) {
        CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(station.latitude, station.longitude);
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        [annotation setCoordinate:coord];
        [self.mapView addAnnotation:annotation];
    }
    
    
    
}

@end
