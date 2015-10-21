//
//  MAPWebViewController.m
//  nyc-bike-finder
//
//  Created by Joseph Misiti on 10/20/15.
//  Copyright © 2015 Math And Pencil LLC. All rights reserved.
//

#import "MAPWebViewController.h"

@implementation MAPWebViewController

@synthesize topCoverView = _topCoverView;
@synthesize bottomCoverView = _bottomCoverView;
@synthesize finishedButton = _finishedButton;

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.toolbarHidden = YES;

    
    [self.view addSubview:self.topCoverView];
    [self.bottomCoverView addSubview:self.finishedButton];
    [self.view addSubview:self.finishedButton];
    
}

#pragma mark - lazy evaluation

-(UIButton*)finishedButton{
    if(!_finishedButton){
        CGFloat height = 200.0f;
        CGFloat yOffset = self.view.frame.size.height - height;
        _finishedButton = [[UIButton alloc] init];
        _finishedButton.frame = CGRectMake(0.0f,yOffset,self.view.frame.size.width, height);
        _finishedButton.backgroundColor = [UIColor redColor];
        [_finishedButton addTarget:self action:@selector(onClickHideWebView:)
            forControlEvents:UIControlEventTouchUpInside];

    }
    return _finishedButton;
}

-(UIView*)topCoverView {
    if(!_topCoverView){
        _topCoverView = [[UIView alloc] init];
        _topCoverView.frame = CGRectMake(0.0f,0.0f,self.view.frame.size.width, 100.0f);
        _topCoverView.backgroundColor = [UIColor blackColor];
    }
    return _topCoverView;
}

-(UIView*)bottomCoverView {
    if(!_bottomCoverView){
        CGFloat height = 200.0f;
        CGFloat yOffset = self.view.frame.size.height - height;
        _bottomCoverView = [[UIView alloc] init];
        _bottomCoverView.frame = CGRectMake(0.0f,yOffset,self.view.frame.size.width, height);
        _bottomCoverView.backgroundColor = [UIColor blackColor];
    }
    return _bottomCoverView;
}

#pragma mark - click events

-(void)onClickHideWebView:(id)sender{
    NSLog(@"--- onClickHideWebView");
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
