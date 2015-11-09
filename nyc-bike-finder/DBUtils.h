//
//  DBUtils.h
//  nyc-bike-finder
//
//  Created by Joseph Misiti on 11/6/15.
//  Copyright © 2015 Math And Pencil LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBUtils : NSObject

@property (nonatomic, strong) NSString* databasePath;


+(DBUtils *)sharedClient;


@end
