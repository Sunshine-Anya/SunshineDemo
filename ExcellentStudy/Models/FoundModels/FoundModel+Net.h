//
//  FoundModel+Net.h
//  ExcellentStudy
//
//  Created by Sunshine on 16/3/21.
//  Copyright © 2016年 Sunshine丶天. All rights reserved.
//

#import "FoundModel.h"
#import "BannerModel.h"
#import "Topicmodel.h"
#import "recommendModel.h"

@interface FoundModel (Net)

+(void)requestFoundData:(void(^)(NSArray *bannerarray,NSArray *categoryarray,NSArray *recommendarray,NSArray *topicsarray,NSError *error))callBack;


@end
