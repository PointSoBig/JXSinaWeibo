//
//  Networking.m
//
//
//  Created by Conner Wu.
//  Copyright © 2016年 Beyondsoft. All rights reserved.
//

#import "NetworkOperation.h"
#import "AFHTTPRequestOperationManager.h"
#import "SVProgressHUD.h"
//#import "LoadingManager.h"
//#import "AppDefines.h"

NSString *const kHttpReturnCodeKey = @"code";
NSString *const kHttpReturnMsgKey = @"message";
NSUInteger const kHttpRetryCount = 1;

@interface NetworkOperation ()
{
    BOOL _showError;
}

@end

@implementation NetworkOperation

- (void)dealloc {
    NSLog(@"%s", __FUNCTION__);
}

// GET
- (void)getData {
    [self startRequest:HttpMethodGet];
}

// POST
- (void)postData {
    [self startRequest:HttpMethodPost];
}

// send request
- (void)startRequest:(HttpMethod)method {
    // show loading
    if (self.showLoading)
    {
//        [[LoadingManager shareInstance] startLoadingInView:self.loadingSuperView];
    }
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@", _baseURL, _path ? : @""];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/javascript", nil];
    manager.requestSerializer.timeoutInterval = (_files && _files.count > 0) ? 600 : 60;
    if (method == HttpMethodGet) {
        [manager GET:urlString parameters:_params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"请求地址: %@", operation.request.URL);
            [self requestCompleted:operation];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"请求地址: %@", operation.request.URL);
            NSLog(@"请求失败: %@", error);
            [self requestCompleted:operation];
        }];
    }
    else
    {
        NSLog(@"\n请求地址：%@\n提交数据：%@", urlString, _params);
        
        AFHTTPRequestOperation *operation = [manager POST:urlString parameters:_params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            // 上传文件
            if (_files && _files.count > 0) {
                NSLog(@"上传文件：%@", _files);
                for (NSDictionary *fileDic in _files) {
                    NSError *error;
                    NSString *filePath = [fileDic objectForKey:@"path"];
                    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
                    BOOL flag = [formData appendPartWithFileURL:fileURL name:[fileDic objectForKey:@"name"] error:&error];
                    if (!flag) {
                        NSLog(@"%@", error);
                    }
                }
            }
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self requestCompleted:operation];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"请求失败: %@", error);
            [self requestCompleted:operation];
        }];
        
        if (_files && _files.count > 0) {
            [operation setUploadProgressBlock:^(NSUInteger __unused bytesWritten,
                                                long long totalBytesWritten,
                                                long long totalBytesExpectedToWrite) {
                float progress = (float)totalBytesWritten / (float)totalBytesExpectedToWrite;
                NSLog(@"upload: %f %f", progress, totalBytesExpectedToWrite / (1024.0 * 1024.0));
            }];
            [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
                float progress = (float)totalBytesRead / (float)totalBytesExpectedToRead;
                NSLog(@"download: %f %f", progress, totalBytesExpectedToRead / (1024.0 * 1024.0));
            }];
        }
    }
}

// call back
- (void)requestCompleted:(AFHTTPRequestOperation *)completedOperation {
//    [[LoadingManager shareInstance] stopLoading];
    
    BOOL retry = YES;
    BOOL success = YES;
    id result = completedOperation.responseObject;
    
    NSLog(@"返回数据：%@", result ? : completedOperation.responseString);
    
    if (completedOperation.response.statusCode == 0) {
        success = NO;
        NSString *errorDescription = [completedOperation.error.userInfo objectForKey:@"NSLocalizedDescription"];
        [self showMessage:errorDescription ? [errorDescription substringToIndex:errorDescription.length - 1] : @"网络异常" needRetry:retry];
    } else if (completedOperation.response.statusCode == 200) {
        retry = NO;
        if (result) {
            if (_validateResult) {
                NSInteger code = [[result objectForKey:kHttpReturnCodeKey] integerValue];
                if (![kHttpReturnSuccCode containsObject:@(code)]) {
                    NSString *msg = [result objectForKey:kHttpReturnMsgKey];
                    [self showMessage:msg.length > 0 ? msg : @"操作失败" needRetry:retry];
                }
            }
        } else {
            success = NO;
            [self showMessage:@"数据异常" needRetry:retry];
        }
    } else {
        success = NO;
        [self showMessage:@"未知错误" needRetry:retry];
    }
    
    if (self.completion) {
        self.completion(result, success, retry);
    }
}

// show message
- (void)showMessage:(NSString *)message needRetry:(BOOL)retry {
    if (self.showError && (!retry || (retry && self.lastRequest))) {
        [SVProgressHUD showErrorWithStatus:message];
    }
}

@end
