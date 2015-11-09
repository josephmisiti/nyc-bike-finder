//
//  DBUtils.m
//  nyc-bike-finder
//
//  Created by Joseph Misiti on 11/6/15.
//  Copyright © 2015 Math And Pencil LLC. All rights reserved.
//

#import "DBUtils.h"

@implementation DBUtils

//https://github.com/yapstudios/YapDatabase/issues/40

@synthesize databasePath = _databasePath;

- (NSString*)databasePath{
    NSArray *searchPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [searchPaths lastObject];
    return [documentPath stringByAppendingPathComponent:@"test_db"];
}

+ (DBUtils *)sharedClient{
    static DBUtils *sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [[self alloc] init];
    });
    return sharedClient;
}

@end
