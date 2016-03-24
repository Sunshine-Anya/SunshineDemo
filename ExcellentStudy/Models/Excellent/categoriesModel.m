//
//  categoriesModel.m
//  ExcellentStudy
//
//  Created by Sunshine on 16/3/16.
//  Copyright © 2016年 Sunshine丶天. All rights reserved.
//

#import "categoriesModel.h"

@implementation categoriesModel
@synthesize title = _title;

+(JSONKeyMapper *)keyMapper{
    
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"_id":@"Id"}];
}
+ (BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;//字典key和属性不完全匹配时仍然正常赋值
}

@end
