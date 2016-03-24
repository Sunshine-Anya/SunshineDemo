//
//  ExcellentModel.h
//  ExcellentStudy
//
//  Created by Sunshine on 16/3/16.
//  Copyright © 2016年 Sunshine丶天. All rights reserved.
//

#import "BaseModel.h"
#import "categoriesModel.h"

@interface ExcellentModel : BaseModel

@property (nonatomic,copy) NSString *avatarUrl;
@property (nonatomic,copy) NSString *username;
@property (nonatomic,strong) NSDictionary *cover;
@property (nonatomic,strong) NSDictionary *user;

@property (nonatomic,copy) NSString *title;
@property (nonatomic,strong) NSMutableArray *categories;
@property (nonatomic,assign) NSInteger repostNum;
@property (nonatomic,copy) NSString *courseId;


@end
