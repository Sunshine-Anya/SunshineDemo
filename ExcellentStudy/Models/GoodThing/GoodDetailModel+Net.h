//
//  GoodDetailModel+Net.h
//  ExcellentStudy
//
//  Created by Sunshine on 16/3/22.
//  Copyright © 2016年 Sunshine丶天. All rights reserved.
//

#import "GoodDetailModel.h"
#import "subjectModel.h"

@interface GoodDetailModel (Net)

+(void)requestDoodDetail:(NSString *)Id callBack:(void(^)(NSArray *subjectArr,NSArray *commondArr,NSArray *relativeArr,NSError *error))callBack;

@end
