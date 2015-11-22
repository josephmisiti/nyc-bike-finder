//
//  DBUtils.m
//  nyc-bike-finder
//
//  Created by Joseph Misiti on 11/6/15.
//  Copyright © 2015 Math And Pencil LLC. All rights reserved.
//

#import "DBUtils.h"
#import "YapDatabase.h"
#import "YapDatabaseConnection.h"

@implementation DBUtils

//https://github.com/yapstudios/YapDatabase/issues/40

@synthesize database = _database;

- (id)init
{
    if(self = [super init]){
        NSString *databaseFilePath = [[[[NSFileManager defaultManager]
                URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject] absoluteString];
        self.database = [[YapDatabase alloc]
                         initWithPath:[databaseFilePath stringByAppendingPathComponent:@"db.sqlite"]];
        
        self.connection = [self.database newConnection];
        
        NSLog(@"--- YapDatabase initialized");
    }
    return self;
}

+ (DBUtils *)sharedClient{
    static DBUtils *sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [[self alloc] init];
    });
    return sharedClient;
}

-(void)addObject:(NSString*)forKey
        setObject:(NSString*)setObject
    inCollection:(NSString*)inCollection {

    [self.connection readWriteWithBlock:^(YapDatabaseReadWriteTransaction *transaction) {
        [transaction setObject:setObject forKey:forKey inCollection:inCollection];
    }];
    
}

-(void)getObject:(NSString*)forKey inCollection:(NSString*)inCollection{
}

@end
