//
//  TopicsCell.m
//  ExcellentStudy
//
//  Created by Sunshine on 16/3/21.
//  Copyright © 2016年 Sunshine丶天. All rights reserved.
//

#import "TopicsCell.h"

@implementation TopicsCell

- (void)awakeFromNib {
    
    self.titleLb.adjustsFontSizeToFitWidth = YES;
    self.IconUrlImg.layer.cornerRadius = 15;
    self.IconUrlImg.clipsToBounds = YES;
}

@end
