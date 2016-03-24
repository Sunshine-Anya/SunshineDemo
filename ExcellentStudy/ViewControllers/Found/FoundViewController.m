//
//  FoundViewController.m
//  ExcellentStudy
//
//  Created by Sunshine on 16/3/14.
//  Copyright © 2016年 Sunshine丶天. All rights reserved.
//

#import "FoundViewController.h"
#import "AppHeader.h"
#import "XTADScrollView.h"
#import "FoundModel+Net.h"
#import "TopicsCell.h"
#import "RecommendCell.h"
@interface FoundViewController ()<UISearchBarDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UISearchBar *searchBar;
@property (nonatomic,strong) XTADScrollView *AdVIew;

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *bannerArr;
@property (nonatomic,strong) UIView *headerView;
@property (nonatomic,strong) UIView *HbottomView;

@property (nonatomic,strong) UICollectionView *topicView;
@property (nonatomic,strong) NSMutableArray *topicArr;

@property (nonatomic,strong) NSMutableArray *recommendArr;

@end

@implementation FoundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
}

-(void)createUI{
    
    if (_tableView) {
        return;
    }
    self.automaticallyAdjustsScrollViewInsets = YES;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Screen.width, Screen.height - 64) style:UITableViewStylePlain];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [_tableView registerNib:[UINib nibWithNibName:@"RecommendCell" bundle:nil] forCellReuseIdentifier:@"RecommendCell"];
    [self.view addSubview:_tableView];
    
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen.width, (Screen.height - 64 - 49)/2)];
    _AdVIew = [[XTADScrollView alloc]initWithFrame:CGRectMake(0, 0, Screen.width, (_headerView.frame.size.height / 2) + 20)];
    _AdVIew.infiniteLoop = YES;
    _AdVIew.pageControlPositionType = pageControlPositionTypeMiddle;
    _AdVIew.needPageControl = YES;
    [_headerView addSubview:_AdVIew];
    
    
    _HbottomView = [[UIView alloc]initWithFrame:CGRectMake(5, (_headerView.frame.size.height / 2), Screen.width, _headerView.frame.size.height - _AdVIew.frame.size.height + 20)];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    //指定最小间距
    layout.minimumInteritemSpacing = 2;
    //设置滚动方向
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _topicView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    [_HbottomView addSubview:_topicView];
    _topicView.delegate = self;
    _topicView.dataSource = self;
    
    [_topicView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(30, 5, 5, 5));
    }];
    
    [_topicView registerNib:[UINib nibWithNibName:@"TopicsCell" bundle:nil] forCellWithReuseIdentifier:@"TopicsCell"];
    _topicView.backgroundColor = [UIColor clearColor];
    _topicView.showsHorizontalScrollIndicator = NO;
    _headerView.userInteractionEnabled = YES;
    [_headerView addSubview:_HbottomView];
    
    _tableView.tableHeaderView = _headerView;

}

-(void)loadData{
    
    __weak FoundViewController *weaSelf = self;
    [FoundModel requestFoundData:^(NSArray *bannerarray, NSArray *categoryarray, NSArray *recommendarray, NSArray *topicsarray, NSError *error) {
       
        if (!error) {
            
            NSMutableArray *imageUrl = [[NSMutableArray alloc]init];
            for (BannerModel *model in bannerarray) {
                [imageUrl addObject:model.bannerUrl];
            }
            
            [weaSelf.topicArr addObjectsFromArray:topicsarray];
            
            [weaSelf.recommendArr addObjectsFromArray:recommendarray];
            
            [weaSelf createUI];
            _AdVIew.imageURLArray = imageUrl;
            [_tableView reloadData];
        }
        
    }];
    
}

#pragma mark collectionView 的协议方法
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"TopicsCell";
    
    TopicsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    Topicmodel *model = self.topicArr[indexPath.item];
    
        [cell.IconUrlImg sd_setImageWithURL:[NSURL URLWithString:model.iconUrl]];
        cell.titleLb.text = model.title;
    
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(80, 100);
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.topicArr.count;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

#pragma mark tableview 的协议方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.recommendArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"RecommendCell";
    
    RecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    recommendModel *model = self.recommendArr[indexPath.row];
    
    [cell.avatarImgV sd_setImageWithURL:[NSURL URLWithString:model.avatarUrl]];
    
    return cell;
}


-(void)navigationItemSetting{
    
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 180, 40)];
    _searchBar.delegate = self;
    _searchBar.backgroundColor = [UIColor lightGrayColor];
    _searchBar.placeholder = @"搜索一切有品质的事物和好友";
//    [_searchBar sizeToFit];//设置搜索条位置自适应 
    self.navigationItem.titleView = _searchBar;
    
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_searchBar resignFirstResponder];
}

#pragma mark 懒加载
-(NSMutableArray *)bannerArr{
    
    if (!_bannerArr) {
        _bannerArr = [[NSMutableArray alloc]init];
    }
    return  _bannerArr;
}

-(NSMutableArray *)topicArr{
    
    if (!_topicArr) {
        _topicArr = [[NSMutableArray alloc]init];
    }
    return _topicArr;
}

-(NSMutableArray *)recommendArr{
    
    if (!_recommendArr) {
        _recommendArr = [[NSMutableArray alloc]init];
    }
    return _recommendArr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
