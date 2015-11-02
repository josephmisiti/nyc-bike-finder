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
    
    self.view.backgroundColor = UIColorFromRGB(kColorGrey);
    
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
        _sortBySpace.backgroundColor = UIColorFromRGB(kColorPink);
        _sortBySpace.tag = 1001;
        [_sortBySpace setTitle:@"Sort By Space" forState:UIControlStateNormal];
        _sortBySpace.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:25.0f];
        [_sortBySpace setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sortBySpace setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [_sortBySpace addTarget:self action:@selector(onUpdateSettings:)
                  forControlEvents:UIControlEventTouchUpInside];
    }
    return _sortBySpace;
}

-(UIButton*)sortByDistance{
    if(!_sortByDistance){
        CGFloat yOffset = self.sortBySpace.frame.origin.y + self.sortBySpace.frame.size.height + kTopMargin;
        _sortByDistance = [[UIButton alloc] init];
        _sortByDistance.backgroundColor = UIColorFromRGB(kColorPink);
        _sortByDistance.frame = CGRectMake(kLeftMargin, yOffset, _buttonWidth, _buttonHeight);
        _sortByDistance.tag = 1002;
        [_sortByDistance setTitle:@"Sort By Distance" forState:UIControlStateNormal];
        _sortByDistance.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:25.0f];
        [_sortByDistance setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sortByDistance setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [_sortByDistance addTarget:self action:@selector(onUpdateSettings:)
               forControlEvents:UIControlEventTouchUpInside];
    }
    return _sortByDistance;
}

-(UIButton*)sortByScore{
    if(!_sortByScore){
        CGFloat yOffset = self.sortByDistance.frame.origin.y
        + self.sortByDistance.frame.size.height + kTopMargin;
        _sortByScore = [[UIButton alloc] init];
        _sortByScore.frame = CGRectMake(kLeftMargin, yOffset, _buttonWidth, _buttonHeight);
        _sortByScore.backgroundColor = UIColorFromRGB(kColorPink);
        _sortByScore.tag = 1003;
        [_sortByScore setTitle:@"Sort By Score" forState:UIControlStateNormal];
        _sortByScore.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:25.0f];
        [_sortByScore setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sortByScore setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];

        [_sortByScore addTarget:self action:@selector(onUpdateSettings:)
                  forControlEvents:UIControlEventTouchUpInside];
    }
    return _sortByScore;
}


#pragma mark - on touch events

-(void)onUpdateSettings:(id)sender {
    NSLog(@" --- onUpdateSettings");
    [self.navigationController
     dismissViewControllerAnimated:YES completion:nil];

}



@end
