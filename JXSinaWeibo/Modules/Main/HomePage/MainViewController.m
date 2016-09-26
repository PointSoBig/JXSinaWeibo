//
//  MainViewController.m
//  JXSinaWeibo
//
//  Created by 景晓峰 on 16/9/18.
//  Copyright © 2016年 JX. All rights reserved.
//

#import "MainViewController.h"
#import "AFHTTPRequestOperationManager.h"

@interface MainViewController ()
@property (nonatomic,strong) UITableView *_tableView;

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"首页";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpUI];
}

- (void)setUpUI
{
    
    
    UIButton *sendWeiboBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sendWeiboBtn.backgroundColor = [UIColor orangeColor];
    [sendWeiboBtn setTitle:@"发微博" forState:UIControlStateNormal];
    [sendWeiboBtn addTarget:self action:@selector(publishWeibo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendWeiboBtn];
    [sendWeiboBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(100));
        make.centerX.equalTo(@(0));
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
    
    UIButton *nearPointListBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nearPointListBtn.backgroundColor = [UIColor orangeColor];
    [nearPointListBtn setTitle:@"获取附近地点" forState:UIControlStateNormal];
    [nearPointListBtn addTarget:self action:@selector(getNearPoint) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nearPointListBtn];
    [nearPointListBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sendWeiboBtn).offset(100);
        make.centerX.equalTo(sendWeiboBtn);
        make.size.mas_equalTo(CGSizeMake(120, 30));
    }];
    
    UIButton *chickinPoint = [UIButton buttonWithType:UIButtonTypeCustom];
    chickinPoint.backgroundColor = [UIColor orangeColor];
    [chickinPoint setTitle:@"签到" forState:UIControlStateNormal];
    [chickinPoint addTarget:self action:@selector(ChickinPoint) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:chickinPoint];
    [chickinPoint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nearPointListBtn).offset(100);
        make.centerX.equalTo(sendWeiboBtn);
        make.size.mas_equalTo(sendWeiboBtn);
    }];
    
    UIButton *newWeiboBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    newWeiboBtn.backgroundColor = [UIColor orangeColor];
    [newWeiboBtn setTitle:@"最新微博" forState:UIControlStateNormal];
    [newWeiboBtn addTarget:self action:@selector(getNewWeibo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:newWeiboBtn];
    [newWeiboBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(chickinPoint).offset(100);
        make.centerX.equalTo(sendWeiboBtn);
        make.size.mas_equalTo(sendWeiboBtn);
    }];
}

- (void)publishWeibo
{
    WeiboRequest *weiboRequest = [[WeiboRequest alloc] init];
    [weiboRequest publishWeiboWithStatus:@"发一条微博" visible:0 list_id:nil lat:35.69466958906191 long:139.73038369140625 annotations:nil rip:nil];
    weiboRequest.block = ^(id responseObj)
    {
        [SVProgressHUD showSuccessWithStatus:@"发布成功"];
    };
}

- (void)getNearPoint
{
    LocationServiceRequest *locationReq = [[LocationServiceRequest alloc] init];
    [locationReq requestLocationPointNearbyWithLat:35.69466958906191 long:139.73038369140625 range:10000 q:nil category:nil count:5 page:1 sort:0 offset:0];
    locationReq.block = ^(id responseObj)
    {
        [SVProgressHUD showSuccessWithStatus:@"刷新成功"];
    };
}

- (void)ChickinPoint
{
    LocationServiceRequest *locationReq = [[LocationServiceRequest alloc] init];
    [locationReq requestPointChinckinWithPoiid:@"B2094757D16BA6F8409D" status:@"..签个到" pic:nil public:1];
    locationReq.block = ^(id responseObj)
    {
        [SVProgressHUD showSuccessWithStatus:@"刷新成功"];
    };
}

- (void)getNewWeibo
{
    WeiboRequest *weiboReq = [[WeiboRequest alloc] init];
    [weiboReq requestGetNewWeiboFromCurrentUserAndHisFriendsWithSince_id:0 max_id:0 count:10 page:1 base_app:0 feature:0 trim_user:0];
    weiboReq.block = ^(id responseObj)
    {
        [SVProgressHUD showSuccessWithStatus:@"刷新成功"];
    };
}

@end
