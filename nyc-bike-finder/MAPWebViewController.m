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
@synthesize latitude = _latitude;
@synthesize longitude = _longitude;

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.view addSubview: self.mapView];
    [self.view addSubview:self.topCoverView];
    [self.view addSubview:self.finishedButton];
    
    // map view deleted
    self.mapView.delegate = (id)self;
    
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
        [_mapView setShowsUserLocation:YES];
    }
    return _mapView;
}

-(UIButton*)finishedButton{
    if(!_finishedButton){
        CGFloat height = 100.0f;
        CGFloat yOffset = self.view.frame.size.height - height;
        _finishedButton = [[UIButton alloc] init];
        _finishedButton.frame = CGRectMake(0.0f,yOffset,self.view.frame.size.width, height);
        _finishedButton.backgroundColor = [UIColor blackColor];
        _finishedButton.alpha = 0.5f;
        [_finishedButton setTitle:@"Finished?" forState:UIControlStateNormal];
        _finishedButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:25.0f];
        [_finishedButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_finishedButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
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
    // based on http://stackoverflow.com/a/22492566/323578
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(self.latitude, self.longitude);
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

-(MKAnnotationView *)mapView:(MKMapView *)mapView
           viewForAnnotation:(id <MKAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    MKAnnotationView *annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"loc"];
    annotationView.canShowCallout = YES;
    annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
    
    return annotationView;

}


@end
