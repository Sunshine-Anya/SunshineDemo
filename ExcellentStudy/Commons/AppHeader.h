//
//  AppHeader.h
//  ExcellentStudy
//
//  Created by Sunshine on 16/3/14.
//  Copyright © 2016年 Sunshine丶天. All rights reserved.
//

#ifndef AppHeader_h
#define AppHeader_h

#import "Masonry.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"
#import "UIImageView+WebCache.h"
#import "ImagesScrollView.h"
#import "UIView+TransitionAnimation.h"

//颜色
#define CustomColor [UIColor colorWithRed:48/255.0f green:188/255.0f blue:192/255.0f alpha:1]
#define CustomColor2 [UIColor colorWithRed:255/255.0f green:124/255.0f blue:74/255.0f alpha:1]

#define RandomColor [UIColor colorWithRed:arc4random()%256/255.0f green:arc4random()%256/255.0f blue:arc4random()%256/255.0f alpha:1]

#define Screen [UIScreen mainScreen].bounds.size

//首页URL
#define HOMEUrl @"http://course2.jaxus.cn/api/v2/recommendation/hotCategories?/courses?"
//推荐
#define TuijianUrl @"http://course2.jaxus.cn/api/v2/recommendation/course?platform=1&length=20&version=2&jaxusVersion=2.0.3"
//11项
#define hotCategoryUrl @"http://course2.jaxus.cn/api/v2/recommendation/hotCategory/"

//好物
#define GoodThingUrl @"http://course2.jaxus.cn/api/v2/mall/subject?"
//好物详情
#define GoodDetailUrl @"http://course2.jaxus.cn/api/v2/mall/subject/"

//发现
#define FoundUrl @"http://course2.jaxus.cn/api/v2/discover?platform=1"


#endif /* AppHeader_h */
