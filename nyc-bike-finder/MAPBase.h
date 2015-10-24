//
//  MAPBase.h
//  nyc-bike-finder
//
//  Created by Joseph Misiti on 10/20/15.
//  Copyright © 2015 Math And Pencil LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MAPPullToRefreshView;

@interface MAPBase : UITableViewController <UISearchBarDelegate, UISearchDisplayDelegate>

@property (nonatomic, strong) NSMutableArray* tableData;
@property (nonatomic, getter=isLoading) BOOL loading;
@property (nonatomic, strong, readonly) MAPPullToRefreshView *pullToRefreshView;

-(void)setLoading:(BOOL)loading animated:(BOOL)animated;
-(void)refresh:(id)sender;
-(void)reloadDataWithAnimation;
-(void)applyStyleSheets;

@end
