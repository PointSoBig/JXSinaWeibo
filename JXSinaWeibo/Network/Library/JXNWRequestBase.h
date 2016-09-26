//
//  JXNWRequestBase.h
//  JXSinaWeibo
//
//  Created by 景晓峰 on 16/9/22.
//  Copyright © 2016年 JX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParameterHelper.h"

typedef NS_ENUM(NSUInteger, HttpWay) {
    HttpWayPost      = 1,
    HttpWayGet       = 2
//    HttpWayPut       = 3,
//    HttpWayDelete    = 4
};

typedef void(^completeRequest)(id);

@interface JXNWRequestBase : NSObject

@property (nonatomic, strong) NSDictionary *parameters;

@property (nonatomic, copy) NSString *path;

@property (nonatomic, assign) completeRequest block;

@property (nonatomic, assign) BOOL showLoading;

@property (nonatomic, assign) BOOL showError;

- (void)starRequestWithHttpWay:(HttpWay)httpWay;

@end
