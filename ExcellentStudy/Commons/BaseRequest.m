//
//  BaseRequest.m
//  ExcellentStudy
//
//  Created by Sunshine on 16/3/16.
//  Copyright © 2016年 Sunshine丶天. All rights reserved.
//

#import "BaseRequest.h"
#import "AFNetworking.h"

@implementation BaseRequest

+(void)getWithURL:(NSString *)Url parameters:(NSDictionary *)para callBack:(void (^)(id, NSError *))callBack{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //设置响应解析器
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:Url parameters:para success:^(NSURLSessionDataTask *task, id responseObject) {
        callBack(responseObject,nil);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        callBack(nil,error);
    }];
    
}

+(void)postWithURL:(NSString *)Url parameters:(NSDictionary *)para callBack:(void (^)(id, NSError *))callBack{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:Url parameters:para success:^(NSURLSessionDataTask *task, id responseObject) {
        callBack(responseObject,nil);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        callBack(nil,error);

    }];
}


@end
