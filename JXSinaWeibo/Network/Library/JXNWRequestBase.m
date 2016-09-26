//
//  JXNWRequestBase.m
//  JXSinaWeibo
//
//  Created by 景晓峰 on 16/9/22.
//  Copyright © 2016年 JX. All rights reserved.
//

#import "JXNWRequestBase.h"
#import "AFHTTPRequestOperationManager.h"
#import "SVProgressHUD.h"
#import "Network.h"

@implementation JXNWRequestBase

- (void)starRequestWithHttpWay:(HttpWay)httpWay
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@.json",kApiBaseURL,_path];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/javascript", nil];
    NSLog(@"访问地址: %@",urlStr);
    if (httpWay == HttpWayGet)
    {
        NSLog(@"GET 参数 :\n %@ ",_parameters);
        [manager GET:urlStr parameters:_parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject)
        {
             [self requestCompleted:operation];
             if (self.block)
             {
                 self.block(responseObject);
             }
        }
             failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error)
        {
            [self requestCompleted:operation];
        }];
    }
    else
    {
        NSLog(@"POST 参数 :\n %@ ",_parameters);
        [manager POST:urlStr parameters:_parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject)
        {
            [self requestCompleted:operation];
            if (self.block)
            {
                self.block(responseObject);
            }
        } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error)
        {
            [self requestCompleted:operation];
        }];
    }
}

// call back
- (void)requestCompleted:(AFHTTPRequestOperation *)completedOperation
{
    id response = completedOperation.responseObject;
    
    NSLog(@"返回数据：%@", response ? response : completedOperation.responseString);
    
    if (completedOperation.response.statusCode == 0) {
        NSString *errorDescription = [completedOperation.error.userInfo objectForKey:@"NSLocalizedDescription"];
        if (![Network isConnect])
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"请检查您的网络" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        else
        {
            [self showMessage:errorDescription ? [errorDescription substringToIndex:errorDescription.length - 1] : @"网络异常"];
        }
    }
    else if (completedOperation.response.statusCode == 200)
    {
        if (response)
        {
            
        }
        else
        {
            [self showMessage:@"数据异常"];
        }
    }
    else
    {
        if (![Network isConnect])
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"网络未连接，请检查网络" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        else
        {
            [self showMessage:@"无法连接到服务器，请稍后再试"];
        }
    }
}

- (void)showMessage:(NSString *)message
{
    if (self.showError)
    {
        [SVProgressHUD showErrorWithStatus:message];
    }
}
@end
