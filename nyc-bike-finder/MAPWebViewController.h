//
//  MAPWebViewController.h
//  nyc-bike-finder
//
//  Created by Joseph Misiti on 10/20/15.
//  Copyright © 2015 Math And Pencil LLC. All rights reserved.
//

#import "SAMWebViewController.h"

@interface MAPWebViewController : SAMWebViewController

@property (nonatomic, nonatomic) UIView* topCoverView;
@property (nonatomic, nonatomic) UIView* bottomCoverView;
@property (nonatomic, nonatomic) UIButton* finishedButton;

-(void)onClickHideWebView:(id)sender;

@end
