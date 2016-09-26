//
//  ParameterHelper.h
//  JXSinaWeibo
//
//  Created by 景晓峰 on 16/9/23.
//  Copyright © 2016年 JX. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ValidString(string) [ParameterHelper validString:string]

@interface ParameterHelper : NSObject

+ (NSString *)validString:(NSString *)string;

@end
