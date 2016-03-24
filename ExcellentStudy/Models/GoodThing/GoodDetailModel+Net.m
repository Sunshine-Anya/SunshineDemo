//
//  GoodDetailModel+Net.m
//  ExcellentStudy
//
//  Created by Sunshine on 16/3/22.
//  Copyright © 2016年 Sunshine丶天. All rights reserved.
//

#import "GoodDetailModel+Net.h"

@implementation GoodDetailModel (Net)

+(void)requestDoodDetail:(NSString *)Id callBack:(void(^)(NSArray *subjectArr,NSArray *commondArr,NSArray *relativeArr,NSError *error))callBack{
    
    [BaseRequest getWithURL:Id parameters:nil callBack:^(id data, NSError *error) {
       
        if (!error) {
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSArray *subjectarray = dict[@"subject"];
            JSONModelArray *subjectArr = [[JSONModelArray alloc]initWithArray:subjectarray modelClass:[subjectModel class]];
            
            callBack((NSArray *)subjectArr,nil,nil,nil);
            
        }else{
            callBack(nil,nil,nil,error);
        }
        
    }];
    
}

@end
