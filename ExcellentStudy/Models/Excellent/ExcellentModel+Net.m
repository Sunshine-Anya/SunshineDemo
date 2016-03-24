//
//  ExcellentModel+Net.m
//  ExcellentStudy
//
//  Created by Sunshine on 16/3/16.
//  Copyright © 2016年 Sunshine丶天. All rights reserved.
//

#import "ExcellentModel+Net.h"

@implementation ExcellentModel (Net)

+(void)requestTuijian:(NSString *)Id page:(NSInteger)page callBack:(void(^)(NSArray *ExcellentArray, NSInteger totalCount, NSError *error))callBack{
    
    [BaseRequest getWithURL:Id parameters:nil callBack:^(id data, NSError *error) {
        
        if (!error) {
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            //取到存放所有字典的数组
            NSArray *array = dict[@"courses"];
            JSONModelArray *modelArray = [[JSONModelArray alloc]initWithArray:array modelClass:[ExcellentModel class]];
            
            NSInteger count = [dict[@"total"] integerValue];
            
            callBack((NSArray *)modelArray,count,nil);
            
        }else{
            callBack(nil,0,error);
        }
        
    }];
    
}

+(void)requestExcellent:(NSString *)Id page:(NSInteger)page callBack:(void(^)(NSString *courseId,NSInteger repostNum,NSString *title,NSArray *categotyArray,NSString *imgUrlStr,NSString *avatarUrlStr,NSString *usernameStr, NSInteger totalCount, NSError *error))callBack{
    
    NSDictionary *para = @{@"start":@0,@"end":@(page),@"jaxusVersion":@"2.0.3"};
    
    [BaseRequest getWithURL:Id parameters:para callBack:^(id data, NSError *error) {
        
        if (!error) {
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            //取到存放所有字典的数组
            NSArray *array = dict[@"courses"];
        
            //total
            NSString *countStr = dict[@"total"];
            NSInteger count = [countStr integerValue];
            
            for (NSDictionary *courseDict in array) {
                
                //ID
                NSString *IdStr = courseDict[@"_id"];
                
                //repostNum
                NSInteger repostNum = [courseDict[@"repostNum"] integerValue];
                
                //title
                NSString *title = courseDict[@"title"];
                
                //categories
                NSArray *categotyArray = courseDict[@"categories"];
                JSONModelArray *categotyArr = [[JSONModelArray alloc]initWithArray:categotyArray modelClass:[categoriesModel class]];
                
                //cover
                NSDictionary *coverDict = courseDict[@"cover"];
                NSString *imgUrlStr = coverDict[@"imgUrl"];
                
                //user
                NSDictionary *userDict = coverDict[@"user"];
                NSString *avatarUrlStr = userDict[@"avatarUrl"];
                NSString *usernameStr = userDict[@"username"];

                callBack((NSString *)IdStr,repostNum,(NSString *)title,(NSArray *)categotyArr,(NSString *)imgUrlStr,(NSString *)avatarUrlStr,(NSString *)usernameStr,count,nil);
            }
            
            
        }else{
            callBack(nil,0,nil,nil,nil,nil,nil,0,nil);
        }
        
    }];
}

//+(void)requestExcellent:(NSString *)Id page:(NSInteger)page callBack:(void(^)(NSString *courseId,NSArray *categotyArray, NSInteger totalCount, NSError *error))callBack{
//    
//    NSDictionary *para = @{@"start":@0,@"end":@(page),@"jaxusVersion":@"2.0.3"};
//    
//    [BaseRequest getWithURL:Id parameters:para callBack:^(id data, NSError *error) {
//        
//        if (!error) {
//            
//            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//            
//            //取到存放所有字典的数组
//            NSArray *array = dict[@"courses"];
////            JSONModelArray *CoursesmodelArray = [[JSONModelArray alloc]initWithArray:array modelClass:[ExcellentModel class]];
//            
//            //total
//            NSString *countStr = dict[@"total"];
//            NSInteger count = [countStr integerValue];
//            
//            for (NSDictionary *courseDict in array) {
//                
//                //ID
//                NSString *IdStr = courseDict[@"_id"];
//                
//                //repostNum
//                NSInteger repostNum = [courseDict[@"repostNum"] integerValue];
//                
//                //title
//                NSString *title = courseDict[@"title"];
//                
//                //categories
//                NSArray *categotyArray = courseDict[@"categories"];
//                JSONModelArray *categotyArr = [[JSONModelArray alloc]initWithArray:categotyArray modelClass:[categoriesModel class]];
//                
//                //cover
//                NSDictionary *coverDict = courseDict[@"cover"];
//                NSString *imgUrlStr = coverDict[@"imgUrl"];
//                
//                //user
//                NSDictionary *userDict = coverDict[@"user"];
//                NSString *avatarUrlStr = userDict[@"avatarUrl"];
//                NSString *usernameStr = userDict[@"username"];
//
//                callBack((NSString *)IdStr,(NSArray *)categotyArr,count,nil);
//            }
//
//            
//        }else{
//            callBack(nil,nil,0,error);
//        }
//        
//    }];
//    
//}



@end
