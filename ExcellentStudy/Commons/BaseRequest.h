//
//  BaseRequest.h
//  ExcellentStudy
//
//  Created by Sunshine on 16/3/16.
//  Copyright © 2016年 Sunshine丶天. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseRequest : NSObject

+(void)getWithURL:(NSString *)Url parameters:(NSDictionary *)para callBack:(void(^)(id data,NSError *error))callBack;

+(void)postWithURL:(NSString *)Url parameters:(NSDictionary *)para callBack:(void(^)(id data,NSError *error))callBack;

@end
