//
//  GoodThingModel.m
//  ExcellentStudy
//
//  Created by Sunshine on 16/3/18.
//  Copyright © 2016年 Sunshine丶天. All rights reserved.
//

#import "GoodThingModel.h"

@implementation GoodThingModel

+(JSONKeyMapper *)keyMapper{
    
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"_id":@"Id",@"description":@"Cdescription"}];
}

//让字段不完全匹配是仍然可以正常赋值
+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;
}

@end
