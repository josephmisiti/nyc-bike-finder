//
//  MAPWebViewController.h
//  nyc-bike-finder
//
//  Created by Joseph Misiti on 10/20/15.
//  Copyright © 2015 Math And Pencil LLC. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

#import "SAMWebViewController.h"

@interface MAPWebViewController : SAMWebViewController <MKMapViewDelegate>

@property (nonatomic, nonatomic) MKMapView* mapView;
@property (nonatomic, nonatomic) UIView* topCoverView;
@property (nonatomic, nonatomic) UIView* bottomCoverView;
@property (nonatomic, nonatomic) UIButton* finishedButton;
@property (nonatomic) float latitude;
@property (nonatomic) float longitude;

-(void)onClickHideWebView:(id)sender;
-(void)applyMapZoomWithPins:(NSMutableArray*)stations;

@end
