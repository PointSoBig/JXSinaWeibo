//
//  AccountModel.m
//  JXSinaWeibo
//
//  Created by 景晓峰 on 16/9/21.
//  Copyright © 2016年 JX. All rights reserved.
//

#import "AccountModel.h"
#import <SSKeychain/SSKeychain.h>

NSString *const kKeyChainService_accessToken = @"JXWeiboKeyChainService_accessToken";
NSString *const kKeyChainAccount = @"JXWeiboKeyChainAccount";

@implementation AccountModel

+ (instancetype)shareInstance
{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}

+ (BOOL)isLogin
{
    NSString *str = [AccountModel getPassword];
    return str != nil;
}

+ (void)destoryUser
{
    [AccountModel shareInstance].uid = nil;
    [AccountModel shareInstance].access_token = nil;
}

+ (BOOL)removeAccount
{
    BOOL flag;
    NSString *password = [AccountModel getPassword];
    if (password.length > 0) {
        NSError *error;
        flag = [SSKeychain deletePasswordForService:kKeyChainService_accessToken account:kKeyChainAccount error:&error];
        if (error) {
            NSLog(@"%s %d %@", __FUNCTION__, __LINE__, error);
        }
    }
    return flag;
}

+ (NSError *)savePassword:(NSString *)password
{
    NSError *error;
    [AccountModel removeAccount];
    [SSKeychain setPassword:password forService:kKeyChainService_accessToken account:kKeyChainAccount error:&error];
    return error;
}

+ (NSString *)getPassword
{
    NSString *password;
    password = [SSKeychain passwordForService:kKeyChainService_accessToken account:kKeyChainAccount];
    return password;
}

+ (void)logout
{
    [AccountModel destoryUser];
    [AccountModel removeAccount];
}

@end
