//
//  UIFactory.m
//  ExcellentStudy
//
//  Created by Sunshine on 16/3/16.
//  Copyright © 2016年 Sunshine丶天. All rights reserved.
//

#import "UIFactory.h"
#import "AppHeader.h"

@implementation UIFactory

+(UIButton *)KindBtn:(CGRect)frame title:(NSString *)title selected:(BOOL)selected{
    
    UIButton *btn = [[UIButton alloc]initWithFrame:frame];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:CustomColor forState:UIControlStateNormal];
    
    CGRect rect = [title boundingRectWithSize:frame.size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
    frame.size = CGSizeMake(rect.size.width + 20, rect.size.height + 5);
    
    btn.frame = frame;
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    
    btn.layer.borderWidth = 0.5;
    btn.layer.borderColor = CustomColor.CGColor;
    btn.layer.cornerRadius = frame.size.height / 2.0;
    
    return btn;
}

@end
