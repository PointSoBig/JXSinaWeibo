//
//  WeiboRequest.m
//  JXSinaWeibo
//
//  Created by 景晓峰 on 16/9/22.
//  Copyright © 2016年 JX. All rights reserved.
//

#import "WeiboRequest.h"
#import "ParameterHelper.h"

@implementation WeiboRequest
/**
 *  发布微博
 *
 *  @param status   (true)     要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。
 *  @param visible       微博的可见性，0：所有人能看，1：仅自己可见，2：密友可见，3：指定分组可见，默认为0。
 *  @param list_id       微博的保护投递指定分组ID，只有当visible参数为3时生效且必选。
 *  @param parameterLat  纬度，有效范围：-90.0到+90.0，+表示北纬，默认为0.0。
 *  @param parameterLong 经度，有效范围：-180.0到+180.0，+表示东经，默认为0.0。
 *  @param annotations   元数据，主要是为了方便第三方应用记录一些适合于自己使用的信息，每条微博可以包含一个或者多个元数据，必须以json字串的形式提交，字串长度不超过512个字符，具体内容可以自定。
 *  @param rip           开发者上报的操作用户真实IP，形如：211.156.0.1。
 */

- (void)publishWeiboWithStatus:(NSString *)status visible:(NSInteger)visible list_id:(NSString *)list_id lat:(CGFloat)parameterLat long:(CGFloat)parameterLong annotations:(NSString *)annotations rip:(NSString *)rip
{
    self.path = @"statuses/update";
    self.parameters = @{@"access_token":[AccountModel getPassword],@"status": ValidString(status),
                @"visible": @(visible),@"lat":@(parameterLat),@"long":@(parameterLong),@"annotations":ValidString(annotations),@"rip":ValidString(rip)};
    [self starRequestWithHttpWay:HttpWayPost];
}

/**
 *  获取当前登录用户及其所关注（授权）用户的最新微博
 *
 *  @param since_id  false	int64	若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
 *  @param max_id    false	int64	若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
 *  @param count     false	int	单页返回的记录条数，最大不超过100，默认为20。
 *  @param page      false	int	返回结果的页码，默认为1。
 *  @param base_app  false	int	是否只获取当前应用的数据。0为否（所有数据），1为是（仅当前应用），默认为0。
 *  @param feature   false	int	过滤类型ID，0：全部、1：原创、2：图片、3：视频、4：音乐，默认为0。
 *  @param trim_user false	int	返回值中user字段开关，0：返回完整user字段、1：user字段仅返回user_id，默认为0。
 */
- (void)requestGetNewWeiboFromCurrentUserAndHisFriendsWithSince_id:(int64_t)since_id max_id:(int64_t)max_id count:(NSInteger)count page:(NSInteger)page base_app:(NSInteger)base_app feature:(NSInteger)feature trim_user:(NSInteger)trim_user
{
    self.path = @"statuses/home_timeline";
    self.parameters = @{@"access_token":[AccountModel getPassword],@"since_id":@(since_id),@"max_id":@(max_id),@"count":@(count),@"page":@(page),@"base_app":@(base_app),@"feature":@(feature),@"trim_user":@(trim_user)};
    [self starRequestWithHttpWay:HttpWayGet];
}




@end
