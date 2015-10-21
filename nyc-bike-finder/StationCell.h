//
//  StationCell.h
//  nyc-bike-finder
//
//  Created by Joseph Misiti on 10/20/15.
//  Copyright © 2015 Math And Pencil LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SAMLabel;
@class Station;

@interface StationCell : UITableViewCell

@property (nonatomic, nonatomic) SAMLabel* titleLabel;
@property (nonatomic, nonatomic) SAMLabel* hashtagLabel;
@property (nonatomic, nonatomic) SAMLabel* uploadedMinutesAgoLabel;


-(void)setStation:(Station*)station;

@end
