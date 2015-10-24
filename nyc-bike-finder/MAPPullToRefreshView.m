//
//  MAPPullToRefreshView.m
//  nyc-bike-finder
//
//  Created by Joseph Misiti on 10/21/15.
//  Copyright © 2015 Math And Pencil LLC. All rights reserved.
//

#import "MAPPullToRefreshView.h"
#import "MAPPullToRefreshContentView.h"

@implementation MAPPullToRefreshView

@synthesize bottomBorderColor = _bottomBorderColor;

#pragma mark - UIView

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        self.backgroundColor = [UIColor whiteColor];
        self.contentView = [[MAPPullToRefreshContentView alloc] initWithFrame:CGRectZero];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    [self.bottomBorderColor setFill];
    CGSize size = self.bounds.size;
    CGContextFillRect(UIGraphicsGetCurrentContext(),
                      CGRectMake(0.0f, size.height - 1.0f, size.width, 1.0f));
}


@end
