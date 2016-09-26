//
//  NetworkRequestBase.m
//
//
//  Created by Conner Wu.
//  Copyright © 2016年 Beyondsoft. All rights reserved.
//

#import "NetworkRequestBase.h"
#import "AppDelegate.h"
//#import "AppDefines.h"
//#import "AccountModel.h"

@interface NetworkRequestBase ()
{
    HttpMethod _method;
    NSUInteger _retryCount;
    CompletedBlock _completedBlock;
}
@end

@implementation NetworkRequestBase

@synthesize showLoading = _showLoading;

- (void)dealloc {
    NSLog(@"%s", __FUNCTION__);
}

- (id)init {
    self = [self initWithLoadingSuperview:((AppDelegate *)[UIApplication sharedApplication].delegate).window];
    return self;
}

- (id)initWithLoadingSuperview:(UIView *)view {
    self = [super init];
    if (self) {
        _retryCount = 0;
        _validateResult = YES;
        _showLoading = NO;
        _showError = YES;
        _loadingSuperView = view;
    }
    return self;
}

#pragma mark GET Method

- (void)startGet {
    [self sendRequest:HttpMethodGet];
}

#pragma mark POST Method

- (void)startPost {
    [self sendRequest:HttpMethodPost];
}

#pragma mark Request Method

- (void)sendRequest:(HttpMethod)type {
    _retryCount++;
    _method = type;
    
    NSMutableDictionary *params = _params.mutableCopy;
    NSMutableString *path = _path.mutableCopy;
//    if ([AccountModel isLogin]) {
//        if (type == HttpMethodPost) {
//            [params setObject:[AccountModel shareInstance].sessionID forKey:@"sessionID"];
//        }else {
//            NSRange range = [path rangeOfString:@"?" options:NSCaseInsensitiveSearch];
//            if (range.location == NSNotFound) {
//                [path appendFormat:@"?sessionID=%@", [AccountModel shareInstance].sessionID];
//            } else {
//                [path appendFormat:@"&sessionID=%@", [AccountModel shareInstance].sessionID];
//            }
//        }
//    }
    
    NetworkOperation *networkOperation = [[NetworkOperation alloc] init];
    networkOperation.flag = _flag;
    networkOperation.baseURL = _baseURL ? : kApiBaseURL;
    networkOperation.path = path;
    networkOperation.params = params;
    networkOperation.files = _files;
    networkOperation.loadingSuperView = _loadingSuperView;
    networkOperation.validateResult = _validateResult;
    networkOperation.showLoading = _showLoading;
    networkOperation.showError = _showError;
    networkOperation.lastRequest = _retryCount == kHttpRetryCount;
    networkOperation.completion = ^(id result, BOOL success, BOOL retry) {
        [self privateRequestCompleted:result success:success needRetry:retry];
    };
    
    if (type == HttpMethodGet) {
        [networkOperation getData];
    } else {
        [networkOperation postData];
    }
}

- (void)privateRequestCompleted:(id)result success:(BOOL)success needRetry:(BOOL)retry {
    if (success) {
        if (_validateResult) {
            success = NO;
            if ([result isKindOfClass:[NSDictionary class]]) {
                NSDictionary *dicResult = (NSDictionary *)result;
                NSArray *allKeys = [dicResult allKeys];
                if ([allKeys containsObject:kHttpReturnCodeKey]) {
                    NSInteger code = [[dicResult objectForKey:kHttpReturnCodeKey] integerValue];
                    if ([kHttpReturnSuccCode containsObject:@(code)]) {
                        result = [result objectForKey:@"data"];
                        success = YES;
                    }
                }
            }
        }
    }
    [self requestCompleted:result succ:success needRetry:retry];
}

// 定义回调
- (void)completion:(CompletedBlock)completion {
    _completedBlock = completion;
}

// 回调
- (void)requestCompleted:(id)result succ:(BOOL)succ needRetry:(BOOL)retry {
    if (!succ && retry) {
        if (_retryCount < kHttpRetryCount) {
            [self sendRequest:_method];
            return;
        }
    }
    
    if (_completedBlock) {
        _completedBlock(result, succ);
    }
}

@end
