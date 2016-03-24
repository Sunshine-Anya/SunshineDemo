//
//  GoodThingModel+Net.h
//  ExcellentStudy
//
//  Created by Sunshine on 16/3/18.
//  Copyright © 2016年 Sunshine丶天. All rights reserved.
//

#import "GoodThingModel.h"

@interface GoodThingModel (Net)

+(void)requestDoodThing:(NSInteger)page callBack:(void(^)(NSArray *dataArr,NSError *error))callBack;

@end
