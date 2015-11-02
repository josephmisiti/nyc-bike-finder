//
//  MAPStationList.h
//  nyc-bike-finder
//
//  Created by Joseph Misiti on 10/20/15.
//  Copyright © 2015 Math And Pencil LLC. All rights reserved.
//

#import "MAPBase.h"

@class MAPSettings;
@class MAPWebViewController;

@interface MAPStationList : MAPBase

@property (nonatomic, strong) MAPWebViewController* webView;
@property (nonatomic, strong) MAPSettings* settingsView;

-(void)onClickSettings:(id)sender;

@end

