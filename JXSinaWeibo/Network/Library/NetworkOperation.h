//
//  NetworkOperation.h
//
//
//  Created by Conner Wu.
//  Copyright © 2016年 Beyondsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define kHttpReturnSuccCode @[@200, @361]

typedef NS_ENUM(NSUInteger, NetworkFlag) {
    NetworkFlagTest = 101, // for test
};

typedef NS_ENUM(NSUInteger, HttpMethod) {
    HttpMethodPost = 1,
    HttpMethodGet = 2
};

FOUNDATION_EXPORT NSString *const kHttpReturnCodeKey;
FOUNDATION_EXPORT NSString *const kHttpReturnMsgKey;
FOUNDATION_EXPORT NSUInteger const kHttpRetryCount;

@interface NetworkOperation : NSObject

@property (nonatomic, strong) NSString *baseURL;
@property (nonatomic, strong) NSString *path;
@property (nonatomic, strong) NSDictionary *params;
@property (nonatomic, strong) NSArray *files;
@property (nonatomic, strong) UIView *loadingSuperView;
@property (nonatomic, assign) BOOL validateResult;
@property (nonatomic, assign) BOOL showLoading;
@property (nonatomic, assign) BOOL showError;
@property (nonatomic, assign) BOOL lastRequest;
@property (nonatomic, assign) NetworkFlag flag;
@property (nonatomic, strong) void (^completion) (id result, BOOL success, BOOL retry);

- (void)getData;
- (void)postData;

@end
