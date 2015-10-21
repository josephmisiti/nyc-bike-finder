//
//  StationCell.m
//  nyc-bike-finder
//
//  Created by Joseph Misiti on 10/20/15.
//  Copyright © 2015 Math And Pencil LLC. All rights reserved.
//

#import "StationCell.h"
#import "SAMLabel.h"
#import "AppDelegate.h"
#import "Station.h"

@implementation StationCell {
    CGRect _dims;
}

@synthesize titleLabel = _titleLabel;
@synthesize hashtagLabel = _hashtagLabel;
@synthesize uploadedMinutesAgoLabel = _uploadedMinutesAgoLabel;

#pragma mark - UIView

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _dims = [AppDelegate getScreenDims];
        UIView* newView = [[UIView alloc] initWithFrame:CGRectMake(
                                                                   0.0f, 0.0f,
                                                                   _dims.size.width, kCellHeight)];
        newView.backgroundColor = [UIColor whiteColor];
        [newView addSubview:self.titleLabel];
        [newView addSubview:self.hashtagLabel];
        [newView addSubview:self.uploadedMinutesAgoLabel];
        [self addSubview:newView];
        
    }
    return self;
}


#pragma mark - lazy evaluation

-(SAMLabel*)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[SAMLabel alloc] init];
        _titleLabel.frame = CGRectMake(10.0f, 10.0f, _dims.size.width-70.0f,50.0f);
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont fontWithName:@"AppleSDGothicNeo-Light" size:25.0f];
        _titleLabel.numberOfLines = 0;
        _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _titleLabel;
}

-(SAMLabel*)hashtagLabel{
    if(!_hashtagLabel){
        CGFloat yOffset = self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height + 5.0f;
        _hashtagLabel = [[SAMLabel alloc] init];
        _hashtagLabel.frame = CGRectMake(10.0f, yOffset, _dims.size.width-70.0f,30.0f);
        _hashtagLabel.textColor = [UIColor blackColor];
        _hashtagLabel.font = [UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:13.0f];
    }
    return _hashtagLabel;
}

-(SAMLabel*)uploadedMinutesAgoLabel{
    if(!_uploadedMinutesAgoLabel){
        _uploadedMinutesAgoLabel = [[SAMLabel alloc] init];
        _uploadedMinutesAgoLabel.frame = CGRectMake(_dims.size.width-70.0f, 35.0f, 70.0f,30.0f);
        _uploadedMinutesAgoLabel.textColor = UIColorFromRGB(0x46baef);
        _uploadedMinutesAgoLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:15.0f];
        _uploadedMinutesAgoLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _uploadedMinutesAgoLabel;
}

-(void)setStation:(Station*)station {
    self.titleLabel.text = station.stationName;
}



@end
