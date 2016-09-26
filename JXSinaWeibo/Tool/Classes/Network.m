//
//  Network.m
//  HairStylist
//
//  Created by SookinMac04 on 13-11-1.
//  Copyright (c) 2013年 SookinMac04. All rights reserved.
//

#import "Network.h"

@implementation Network
+ (BOOL)isConnect
{
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus<=0) {
//        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"网络异常,请检查wifi或手机网络"];
        return NO;
    }
    return  YES;
}

@end
