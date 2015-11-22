//
//  DBUtils.h
//  nyc-bike-finder
//
//  Created by Joseph Misiti on 11/6/15.
//  Copyright © 2015 Math And Pencil LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YapDatabase;
@class YapDatabaseConnection;

@interface DBUtils : NSObject

@property (nonatomic, strong) YapDatabase* database;
@property (nonatomic, strong) YapDatabaseConnection* connection;

+(DBUtils *)sharedClient;

-(void)addObject:(NSString*)forKey setObject:(NSString*)setObject inCollection:(NSString*)inCollection;
-(void)getObject:(NSString*)forKey inCollection:(NSString*)inCollection;

@end
