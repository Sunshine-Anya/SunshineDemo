//
//  ExcellentCell.h
//  ExcellentStudy
//
//  Created by Sunshine on 16/3/16.
//  Copyright © 2016年 Sunshine丶天. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExcellentModel.h"

@interface ExcellentCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *userIcon;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *repostNumLb;
@property (weak, nonatomic) IBOutlet UIImageView *coverImageV;
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UIView *BottomView;

@property (nonatomic,strong) ExcellentModel *model;



@end
