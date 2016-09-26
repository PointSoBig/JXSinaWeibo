//
//  LoginViewController.m
//  JXSinaWeibo
//
//  Created by 景晓峰 on 16/9/20.
//  Copyright © 2016年 JX. All rights reserved.
//

#import "LoginViewController.h"
#import "WeiboSDK.h"

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"登录";
    [self setUpUI];
    
}

- (void)setUpUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2, self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    loginBtn.backgroundColor = [UIColor orangeColor];
    [loginBtn setTitle:@"Sign in" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(requestWeiboAuthorization) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
}

//请求获取微博授权
- (void)requestWeiboAuthorization
{
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = kRedirectURL;
    request.scope = @"all";
    request.userInfo = @{};
    [WeiboSDK sendRequest:request];
}

@end
