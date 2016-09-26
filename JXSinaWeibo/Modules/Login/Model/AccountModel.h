//
//  AccountModel.h
//  JXSinaWeibo
//
//  Created by 景晓峰 on 16/9/21.
//  Copyright © 2016年 JX. All rights reserved.
//

#import "BaseModel.h"

@interface AccountModel : BaseModel

/**
 *  授权后获得的token
 */
@property (nonatomic, copy) NSString *access_token;

@property (nonatomic, copy) NSString *expires_in;

@property (nonatomic, copy) NSString *refresh_token;

@property (nonatomic, copy) NSString *remind_in;

/**
 *  授权后获得的userId
 */
@property (nonatomic, copy) NSString *uid;

+ (instancetype)shareInstance;

+ (BOOL)isLogin;

+ (NSString *)getPassword;

+ (NSError *)savePassword:(NSString *)password;

+ (void)logout;

@end
