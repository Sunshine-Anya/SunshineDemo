//
//  GoodThingModel+Net.m
//  ExcellentStudy
//
//  Created by Sunshine on 16/3/18.
//  Copyright © 2016年 Sunshine丶天. All rights reserved.
//

#import "GoodThingModel+Net.h"

@implementation GoodThingModel (Net)

+(void)requestDoodThing:(NSInteger)page callBack:(void(^)(NSArray *dataArr,NSError *error))callBack{
    
    NSDictionary *para = @{@"platform":@1,@"start":@((page - 1) * 10),@"end":@(page * 10),@"jaxusVersion":@"2.0.3"};
    [BaseRequest getWithURL:GoodThingUrl parameters:para callBack:^(id data, NSError *error) {
  
        if (!error) {
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSArray *dataArray = dict[@"data"];
            JSONModelArray *data = [[JSONModelArray alloc]initWithArray:dataArray modelClass:[GoodThingModel class]];
            callBack((NSArray *)data,nil);
        }else{
            callBack(nil,error);
        }
        
    }];
    
}

@end
