//
//  GoodDetailController.m
//  ExcellentStudy
//
//  Created by Sunshine on 16/3/22.
//  Copyright © 2016年 Sunshine丶天. All rights reserved.
//

#import "GoodDetailController.h"
#import "AppHeader.h"
#import "GoodDetailModel+Net.h"
#import "GoodSubjectCell.h"

@interface GoodDetailController ()

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIView *headerView;
@property (nonatomic,strong) NSMutableArray *subjectArr;
@property (nonatomic,strong) UIImageView *bannerImgV;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *descriptionLabel;
@property (nonatomic,assign) NSInteger Integer;

@end

@implementation GoodDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
//    [self.navigationController.navigationBar setHidden:YES];
    _Integer = 0;
    [self createUI];

    [self loadData];

}

-(void)createUI{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen.width, Screen.height - 64) style:UITableViewStylePlain];
    
    [self createHeader];
    
    _tableView.tableHeaderView = _headerView;
    [self.view addSubview:_tableView];
    
}

-(void)createHeader{
    
    _bannerImgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Screen.width, 200)];
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, Screen.width - 30, 25)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont systemFontOfSize:16];
    _titleLabel.center = _bannerImgV.center;
    [_bannerImgV addSubview:_titleLabel];
    [self.headerView addSubview:_bannerImgV];
    
    _descriptionLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, _bannerImgV.frame.origin.y + _bannerImgV.frame.size.height, Screen.width - 10, 40)];
    _descriptionLabel.textColor = [UIColor grayColor];
    _descriptionLabel.font = [UIFont systemFontOfSize:14];
    _descriptionLabel.numberOfLines = 0;
    [_headerView addSubview:_descriptionLabel];
    
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen.width, _bannerImgV.frame.size.height + _descriptionLabel.frame.size.height)];
    
    [self setvaluesForHeader:_Integer];
}

-(void)setvaluesForHeader:(NSInteger)index{
    
    subjectModel *model = self.subjectArr[index];
    
    [_bannerImgV sd_setImageWithURL:[NSURL URLWithString:model.bannerUrl]];
    _titleLabel.text = model.title;
    _descriptionLabel.text = model.Cdescription;
}

-(void)loadData{
    
    __weak GoodDetailController *WeakSelf = self;
    
    [GoodDetailModel requestDoodDetail:self.IdUrl callBack:^(NSArray *subjectArr, NSArray *commondArr, NSArray *relativeArr, NSError *error) {
       
        [WeakSelf.subjectArr addObjectsFromArray:subjectArr];
        
        
        [_tableView reloadData];
        
    }];
    
}

-(NSMutableArray *)subjectArr{
    
    if (_subjectArr == nil) {
        _subjectArr = [[NSMutableArray alloc]init];
    }
    return _subjectArr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
