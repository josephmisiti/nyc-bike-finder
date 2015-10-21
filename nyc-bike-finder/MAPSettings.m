//
//  MAPSettings.m
//  nyc-bike-finder
//
//  Created by Joseph Misiti on 10/21/15.
//  Copyright © 2015 Math And Pencil LLC. All rights reserved.
//

#import "MAPSettings.h"
#import "AppDelegate.h"

static CGFloat kNumButtons = 3.0f;
static CGFloat kTopMargin = 1.0f;
static CGFloat kLeftMargin = 1.0f;

@implementation MAPSettings{
    CGRect _dims;
    CGFloat _buttonHeight;
    CGFloat _buttonWidth;
}

@synthesize sortBySpace = _sortBySpace;
@synthesize sortByDistance = _sortByDistance;
@synthesize sortByScore = _sortByScore;

#pragma mark - UIViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    _dims = [AppDelegate getScreenDims];
    _buttonHeight = ((_dims.size.height) / kNumButtons) - 2.0f*kTopMargin;
    _buttonWidth = self.view.frame.size.width - 2.0f*kLeftMargin;
    
    [self.view addSubview:self.sortBySpace];
    [self.view addSubview:self.sortByDistance];
    [self.view addSubview:self.sortByScore];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

#pragma mark - lazy evaluation

-(UIButton*)sortBySpace{
    if(!_sortBySpace){
        _sortBySpace = [[UIButton alloc] init];
        _sortBySpace.frame = CGRectMake(kLeftMargin, kTopMargin, _buttonWidth, _buttonHeight);
        _sortBySpace.backgroundColor = [UIColor blackColor];
        _sortBySpace.tag = 1001;
        [_sortBySpace addTarget:self action:@selector(onUpdateSettings:)
                  forControlEvents:UIControlEventTouchUpInside];
    }
    return _sortBySpace;
}

-(UIButton*)sortByDistance{
    if(!_sortByDistance){
        _sortByDistance = [[UIButton alloc] init];
        _sortByDistance.tag = 1001;
        [_sortByDistance addTarget:self action:@selector(onUpdateSettings:)
               forControlEvents:UIControlEventTouchUpInside];
    }
    return _sortByDistance;
}

-(UIButton*)sortByScore{
    if(!_sortByScore){
        _sortByScore = [[UIButton alloc] init];
        _sortByScore.tag = 1001;
        [_sortByScore addTarget:self action:@selector(onUpdateSettings:)
                  forControlEvents:UIControlEventTouchUpInside];
    }
    return _sortByScore;
}




#pragma mark - on touch events

-(void)onUpdateSettings:(id)sender {
    NSLog(@" --- onUpdateSettings");

}



@end
