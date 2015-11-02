//
//  MAPSettings.h
//  nyc-bike-finder
//
//  Created by Joseph Misiti on 10/21/15.
//  Copyright © 2015 Math And Pencil LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MAPSettings : UIViewController

@property (nonatomic, strong) UIButton* sortBySpace;
@property (nonatomic, strong) UIButton* sortByDistance;
@property (nonatomic, strong) UIButton* sortByScore;

-(void)onUpdateSettings:(id)sender;
-(void)onDismissSettings:(id)sender;

@end
