//
//  ExcellentCell.m
//  ExcellentStudy
//
//  Created by Sunshine on 16/3/16.
//  Copyright © 2016年 Sunshine丶天. All rights reserved.
//

#import "ExcellentCell.h"
#import "UIFactory.h"

@implementation ExcellentCell

-(void)setModel:(ExcellentModel *)model{
    
    _model = model;
    [self.userIcon sd_setImageWithURL:[NSURL URLWithString:model.avatarUrl]];
    
    self.userName.text = model.username;
    self.repostNumLb.text = [NSString stringWithFormat:@"%ld",(long)model.repostNum];
    self.titleLb.text = model.title;
    [self.coverImageV sd_setImageWithURL:[NSURL URLWithString:model.avatarUrl]];
    NSArray *subViews = self.BottomView.subviews;
    for (UIButton *btn in subViews) {
        [btn removeFromSuperview];
    }
    
    CGFloat orginX = 10;
    for (categoriesModel *categories in model.categories) {
        UIButton *categoriedBtn = [UIFactory KindBtn:CGRectMake(orginX, 10, 60, 20) title:categories.title];
        orginX += categoriedBtn.frame.size.width + 15;
    }
}

- (void)awakeFromNib {
    
    self.userIcon.layer.cornerRadius = 14;
    self.userIcon.clipsToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
