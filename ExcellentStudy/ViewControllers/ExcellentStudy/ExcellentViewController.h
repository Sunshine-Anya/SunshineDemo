//
//  ExcellentViewController.h
//  ExcellentStudy
//
//  Created by Sunshine on 16/3/14.
//  Copyright © 2016年 Sunshine丶天. All rights reserved.
//

#import "BaseViewController.h"

@interface ExcellentViewController : BaseViewController

@property(nonatomic, strong) UITableView * tuijian;
@property(nonatomic, strong) UITableView * caizhuang;
@property(nonatomic, strong) UITableView * shougong;
@property(nonatomic, strong) UITableView * hufu;
@property(nonatomic, strong) UITableView * faxing;
@property(nonatomic, strong) UITableView * yangsheng;
@property(nonatomic, strong) UITableView * jianshen;
@property(nonatomic, strong) UITableView * paizhao;
@property(nonatomic, strong) UITableView * fushi;
@property(nonatomic, strong) UITableView * jiachangcai;
@property(nonatomic, strong) UITableView * hongbei;


@property(nonatomic, strong) NSMutableArray * tuijianarray;
@property(nonatomic, strong) NSMutableArray * caizhuangarray;
@property(nonatomic, strong) NSMutableArray * shougongarray;
@property(nonatomic, strong) NSMutableArray * hufuarray;
@property(nonatomic, strong) NSMutableArray * faxingarray;
@property(nonatomic, strong) NSMutableArray * yangshengarray;
@property(nonatomic, strong) NSMutableArray * jianshenarray;
@property(nonatomic, strong) NSMutableArray * paizhaoarray;
@property(nonatomic, strong) NSMutableArray * fushiarray;
@property(nonatomic, strong) NSMutableArray * jiachangcaiarray;
@property(nonatomic, strong) NSMutableArray * hongbeiarray;


@end
