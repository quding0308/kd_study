//
//  ShuWeiLocation.h
//  ShuWeiLocation
//
//  Created by WYF on 2016/10/15.
//  Copyright © 2016年 WYF. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ShuWeiLocationDelegate <NSObject>

@optional
/**
 被动请求的定位结果，默认开启服务后，都是被动请求
 
 @param result 定位结果
 */
- (void)passiveLocationResult:(NSDictionary *)result;

/**
 主动请求的定位结果
 
 @param result 定位结果
 */
- (void)initiativeLocationResult:(NSDictionary *)result;
@end

@interface ShuWeiLocation : NSObject

@property (nonatomic,readwrite,weak) id<ShuWeiLocationDelegate>delegate;

/**
 地理位置信息权限申请开关,默认为NO；设置为YES，sdk不作位置信息权限申请。
 */
@property (nonatomic, assign) BOOL LocationAuthorizedIsForbidden;

/**
 扩展参数，可用于传递额外的标识字段
 */
@property (nonatomic, copy) NSString *extendParameter;

+ (ShuWeiLocation *)sharedInstance;

/**
 开启服务 默认开启服务后，都是被动请求
 @param appId  应用唯一Id
 @param appKey 与所选版本匹配的appKey
 */
- (void)startLocationWithAppId:(NSString *)appId
                     andAppKey:(NSString *)appKey;

/**
 主动请求定位
 */
- (void)initiativeRequestLocation;

@end
