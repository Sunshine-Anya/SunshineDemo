//
//  RecommendCell.h
//  ExcellentStudy
//
//  Created by Sunshine on 16/3/22.
//  Copyright © 2016年 Sunshine丶天. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecommendCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *avatarImgV;
@property (weak, nonatomic) IBOutlet UILabel *userNameLb;
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UILabel *moreLb;

@end
