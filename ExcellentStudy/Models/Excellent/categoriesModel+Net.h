//
//  categoriesModel+Net.h
//  ExcellentStudy
//
//  Created by Sunshine on 16/3/17.
//  Copyright © 2016年 Sunshine丶天. All rights reserved.
//

#import "categoriesModel.h"

@interface categoriesModel (Net)

+(void)requestcategory:(NSString *)Id callBack:(void(^)(NSArray *categoriesArr,NSArray *Id, NSError *error))callBack;

@end
