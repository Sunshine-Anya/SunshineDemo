//
//  recommendModel.h
//  ExcellentStudy
//
//  Created by Sunshine on 16/3/22.
//  Copyright © 2016年 Sunshine丶天. All rights reserved.
//

#import "BaseModel.h"

@interface recommendModel : BaseModel

@property (nonatomic,copy) NSString *avatarUrl;
@property (nonatomic,copy) NSString *username;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,assign) NSInteger fansNo;
@property (nonatomic,assign) NSInteger publishNo;
@end
