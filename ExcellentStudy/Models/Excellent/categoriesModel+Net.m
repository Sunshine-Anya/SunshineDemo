//
//  categoriesModel+Net.m
//  ExcellentStudy
//
//  Created by Sunshine on 16/3/17.
//  Copyright © 2016年 Sunshine丶天. All rights reserved.
//

#import "categoriesModel+Net.h"

@implementation categoriesModel (Net)

+(void)requestcategory:(NSString *)Id callBack:(void (^)(NSArray *, NSArray *, NSError *))callBack{
    
    [BaseRequest getWithURL:HOMEUrl parameters:nil callBack:^(id data, NSError *error) {
       
        if (!error) {
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSArray *array = dict[@"categories"];
            JSONModelArray *modelArray = [[JSONModelArray alloc]initWithArray:array modelClass:[categoriesModel class]];
            NSMutableArray *IdArr = [[NSMutableArray alloc]init];
            NSInteger i = 0;
            for (NSDictionary *IdDict in array) {
                if (i == 0) {
                    NSString *Id = TuijianUrl;
                    [IdArr addObject:Id];
                }
                NSString *Id = IdDict[@"_id"];
                [IdArr addObject:Id];
                i ++;
                
            }
            callBack((NSArray *)modelArray,IdArr,nil);

        }else{
            callBack(nil,nil,error);
        }
        
    }];
    
}

@end
