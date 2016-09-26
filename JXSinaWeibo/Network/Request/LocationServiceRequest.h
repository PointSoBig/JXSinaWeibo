//
//  LocationServiceRequest.h
//  JXSinaWeibo
//
//  Created by 景晓峰 on 16/9/23.
//  Copyright © 2016年 JX. All rights reserved.
//

#import "JXNWRequestBase.h"

@interface LocationServiceRequest : JXNWRequestBase

/**
 *  获取附近地点
 *
 *  @param lat       true	float	纬度，有效范围：-90.0到+90.0，+表示北纬。
 *  @param longitude true	float	经度，有效范围：-180.0到+180.0，+表示东经。
 *  @param range     false	int	查询范围半径，默认为2000，最大为10000，单位米。
 *  @param q         false	string	查询的关键词，必须进行URLencode。
 *  @param category  false	string	查询的分类代码，取值范围见：分类代码对应表。
 *  @param count     false	int	单页返回的记录条数，默认为20，最大为50。
 *  @param page      false	int	返回结果的页码，默认为1。
 *  @param sort      false	int	排序方式，0：按权重，1：按距离，3：按签到人数。默认为0。
 *  @param offset    false	int	传入的经纬度是否是纠偏过，0：没纠偏、1：纠偏过，默认为0。
 */

- (void)requestLocationPointNearbyWithLat:(CGFloat)lat long:(CGFloat)longitude range:(NSInteger)range q:(NSString *)q category:(NSString *)category count:(NSInteger)count page:(NSInteger)page sort:(NSInteger)sort offset:(NSInteger)offset;

/**
 *  签到,同时可以上传一张图片
 *
 *  @param poiid  true	string	需要签到的POI地点ID。
 *  @param status true	string	签到时发布的动态内容，必须做URLencode，内容不超过140个汉字。
 *  @param pic    false	binary	需要上传的图片，仅支持JPEG、GIF、PNG格式，图片大小小于5M。
 *  @param public false	int	是否同步到微博，1：是、0：否，默认为0。
 */
- (void)requestPointChinckinWithPoiid:(NSString *)poiid status:(NSString *)status pic:(NSData *)pic public:(NSInteger)public;

@end
