//
//  BannerModel.m
//  ExcellentStudy
//
//  Created by Sunshine on 16/3/21.
//  Copyright © 2016年 Sunshine丶天. All rights reserved.
//

#import "BannerModel.h"

@implementation BannerModel

+(JSONKeyMapper *)keyMapper{

    return [[JSONKeyMapper alloc]initWithDictionary:@{@"_id":@"Id"}];
}

@end
