//
//  NetworkRequestBase.h
//
//
//  Created by Conner Wu.
//  Copyright © 2016年 Beyondsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkOperation.h"

typedef void (^CompletedBlock) (NSDictionary *result, BOOL success);

@interface NetworkRequestBase : NSObject
{
    NetworkFlag _flag;
    NSString *_baseURL;
    NSString *_path;
    NSDictionary *_params;
    NSArray *_files;
    UIView *_loadingSuperView;
    BOOL _validateResult;
    BOOL _showError;
    BOOL _showLoading;
}

@property (nonatomic, assign) BOOL showLoading;

- (id)initWithLoadingSuperview:(UIView *)view;
- (void)startGet;
- (void)startPost;
- (void)requestCompleted:(id)result succ:(BOOL)succ needRetry:(BOOL)retry;
- (void)completion:(CompletedBlock)completion;

@end
