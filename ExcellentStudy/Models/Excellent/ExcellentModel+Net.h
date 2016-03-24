//
//  ExcellentModel+Net.h
//  ExcellentStudy
//
//  Created by Sunshine on 16/3/16.
//  Copyright © 2016年 Sunshine丶天. All rights reserved.
//

#import "ExcellentModel.h"
#import "categoriesModel+Net.h"
#import "coverModel.h"
@interface ExcellentModel (Net)

+(void)requestTuijian:(NSString *)Id page:(NSInteger)page callBack:(void(^)(NSArray *ExcellentArray, NSInteger totalCount, NSError *error))callBack;

//+(void)requestExcellent:(NSString *)Id page:(NSInteger)page callBack:(void(^)(NSString *courseId,NSArray *categotyArray, NSInteger totalCount, NSError *error))callBack;

+(void)requestExcellent:(NSString *)Id page:(NSInteger)page callBack:(void(^)(NSString *courseId,NSInteger repostNum,NSString *title,NSArray *categotyArray,NSString *imgUrlStr,NSString *avatarUrlStr,NSString *usernameStr, NSInteger totalCount, NSError *error))callBack;


@end
