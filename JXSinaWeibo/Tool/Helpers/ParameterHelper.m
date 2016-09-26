//
//  ParameterHelper.m
//  JXSinaWeibo
//
//  Created by 景晓峰 on 16/9/23.
//  Copyright © 2016年 JX. All rights reserved.
//

#import "ParameterHelper.h"

@implementation ParameterHelper

+ (NSString *)validString:(NSString *)string
{
    if (string && ![string isEqual:[NSNull null]] && string.length > 0) {
        return string;
    }else {
        return @"";
    }
}

@end
