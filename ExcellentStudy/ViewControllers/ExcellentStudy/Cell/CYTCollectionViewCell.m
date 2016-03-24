//
//  CYTCollectionViewCell.m
//  ExcellentStudy
//
//  Created by Sunshine on 16/3/17.
//  Copyright © 2016年 Sunshine丶天. All rights reserved.
//

#import "CYTCollectionViewCell.h"
#import "AppHeader.h"

@implementation CYTCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setSelected:(BOOL)selected{
    
    [super setSelected:selected];
    
    self.slideView.hidden = !selected;
    self.TitleLabel.textColor = !selected?[UIColor grayColor]:CustomColor;
}

@end
