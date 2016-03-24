//
//  FoundModel+Net.m
//  ExcellentStudy
//
//  Created by Sunshine on 16/3/21.
//  Copyright © 2016年 Sunshine丶天. All rights reserved.
//

#import "FoundModel+Net.h"

@implementation FoundModel (Net)

+(void)requestFoundData:(void(^)(NSArray *bannerarray,NSArray *categoryarray,NSArray *recommendarray,NSArray *topicsarray,NSError *error))callBack{
    
//    NSDictionary *para = @{@""};
    [BaseRequest getWithURL:FoundUrl parameters:nil callBack:^(id data, NSError *error) {
       
        if (!error) {
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSArray *bannerarray = dict[@"banners"];
            JSONModelArray *bannerMA = [[JSONModelArray alloc]initWithArray:bannerarray modelClass:[BannerModel class]];
            
            NSArray *topicarray = dict[@"topics"];
            JSONModelArray *topicMA = [[JSONModelArray alloc]initWithArray:topicarray modelClass:[Topicmodel class]];
            
            NSArray *commendarray = dict[@"recommendUsers"];
            JSONModelArray *commendMA = [[JSONModelArray alloc]initWithArray:commendarray modelClass:[recommendModel class]];
            
            
            callBack((NSArray *)bannerMA,nil,(NSArray *)commendMA,(NSArray *)topicMA,nil);
        }else{
            callBack(nil,nil,nil,nil,error);
        }
        
    }];
    
}

@end
