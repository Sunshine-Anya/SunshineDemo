//
//  GoodThingViewController.m
//  ExcellentStudy
//
//  Created by Sunshine on 16/3/14.
//  Copyright © 2016年 Sunshine丶天. All rights reserved.
//

#import "GoodThingViewController.h"
#import "GoodThingModel+Net.h"
#import "GoodThingCell.h"
#import "GoodDetailController.h"

@interface GoodThingViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArry;
@property (nonatomic,assign) NSInteger pageIndex;
@property (nonatomic,strong) MBProgressHUD *Hud;


@end

@implementation GoodThingViewController

-(void)viewWillAppear:(BOOL)animated{
    
    self.navigationController.tabBarController.tabBar.hidden  = NO;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self refreshData];
    
}

-(void)navigationItemSetting{
    
    self.navigationItem.title = @"好物";
}

-(void)createUI{
    
    if (_tableView) {
        return;
    }
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Screen.width, Screen.height - 64)style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView registerNib:[UINib nibWithNibName:@"GoodThingCell" bundle:nil] forCellReuseIdentifier:@"GoodThingCell"];
    [self.view addSubview:_tableView];
    
    __weak GoodThingViewController *weakSelf = self;
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf refreshData];
    }];
    _tableView.footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        [weakSelf loadMore];
    }];
}

-(void)refreshData{
    _pageIndex = 1;
    
    [self loadData];
}
-(void)loadMore{
    
    _pageIndex ++;
    
    [self loadData];
}

-(void)loadData{
    
    [self.view addSubview:self.Hud];
    [self.Hud show:YES];
    __weak GoodThingViewController *weakSelf = self;
    
    [GoodThingModel requestDoodThing:_pageIndex callBack:^(NSArray *dataArr, NSError *error) {
        
        if (!error) {
            
           [weakSelf createUI];
            
            if (_pageIndex == 1) {
                
                [self.dataArry removeAllObjects];
            }
        }else{
            
        }
        
        [weakSelf.dataArry addObjectsFromArray:dataArr];
        [_tableView reloadData];

        [_tableView.header endRefreshing];
        [_tableView.footer endRefreshing];
        [self.Hud hide:YES];
    }];
    
}

#pragma mark - UITableView 协议方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArry.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"GoodThingCell";
    GoodThingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    GoodThingModel *model = self.dataArry[indexPath.row];
    [cell.CoverImagV sd_setImageWithURL:[NSURL URLWithString:model.coverUrl]];
    cell.TitleLb.text = model.title;

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 160;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GoodThingModel *model = self.dataArry[indexPath.row];
    
    GoodDetailController *GoodDetail = [[GoodDetailController alloc]init];
    GoodDetail.IdUrl = [NSString stringWithFormat:@"http://course2.jaxus.cn/api/v2/mall/subject/%@",model.Id];
    
    self.navigationController.tabBarController.tabBar.hidden  = YES;
    [self.navigationController pushViewController:GoodDetail animated:YES];

}

-(NSMutableArray *)dataArry{
    
    if (_dataArry == nil) {
        _dataArry = [[NSMutableArray alloc]init];
    }
    return _dataArry;
}

-(MBProgressHUD *)Hud{
    
    if (_Hud == nil) {
        _Hud = [[MBProgressHUD alloc]init];
        _Hud.labelText = @"玩命加载中";
        _Hud.detailsLabelText = @"请稍后...";
    }
    return _Hud;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
