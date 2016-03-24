//
//  subjectModel.m
//  ExcellentStudy
//
//  Created by Sunshine on 16/3/22.
//  Copyright © 2016年 Sunshine丶天. All rights reserved.
//

#import "subjectModel.h"

@implementation subjectModel

+(JSONKeyMapper *)keyMapper{
    
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"_id":@"Id",@"description":@"Cdescription"}];
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;//字典key和属性不完全匹配时仍然正常赋值
}

@end
