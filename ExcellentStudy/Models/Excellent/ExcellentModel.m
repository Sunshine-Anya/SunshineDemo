//
//  ExcellentModel.m
//  ExcellentStudy
//
//  Created by Sunshine on 16/3/16.
//  Copyright © 2016年 Sunshine丶天. All rights reserved.
//

#import "ExcellentModel.h"

@implementation ExcellentModel

+(JSONKeyMapper *)keyMapper{
    
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"_id":@"courseId"}];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err
{
    self = [super initWithDictionary:dict error:err];
    if (self) {
        
        //特殊处理tagsInfo JSONModel会解析成字典 而不是我们希望的存放模型
        self.categories = nil;
        NSArray *tagsArr = dict[@"tags_info"];
        JSONModelArray *models = [[JSONModelArray alloc]initWithArray:tagsArr modelClass:[categoriesModel class]];
        
        NSMutableArray *array = [[NSMutableArray alloc]init];
        [array addObjectsFromArray:(NSArray *)models];
        _categories = array;
    }
    return self;
}

//让字段不完全匹配是仍然可以正常赋值
+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;
}

@end
