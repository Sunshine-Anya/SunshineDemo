//
//  ExcellentViewController.m
//  ExcellentStudy
//
//  Created by Sunshine on 16/3/14.
//  Copyright © 2016年 Sunshine丶天. All rights reserved.
//

#import "ExcellentViewController.h"
#import "AppHeader.h"
#import "SCNavTabBarController.h"
#import "SearchUserController.h"
#import "SearchThingController.h"
#import "ExcellentCell.h"
#import "ExcellentModel+Net.h"
#import "CYTCollectionViewCell.h"
#import "categoriesModel+Net.h"
#import "coverModel.h"
#import "UserModel.h"

#define TAG_SCROLL 200

#define TAG_11TABLEVIEW 500

@interface ExcellentViewController ()<UITableViewDataSource,UITableViewDelegate,ImagesScrollViewDelegate,UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{
    
    ImagesScrollView *_imagescrollview;
    
    UIScrollView *_sv;
    NSInteger _currentindex;
    
    //当前的网络请求的页数
    int _currentpage;
}

@property (nonatomic,strong) UIView *FocusView;
@property (nonatomic,strong) NSMutableArray *dataArr;

@property(nonatomic, strong) NSMutableArray * category_element_all;
@property (nonatomic,strong) NSMutableArray *IDARR;
@property (nonatomic, assign) NSInteger totalCount;


//创建一个collectionview1
@property(nonatomic, strong) UICollectionView * collectionview1;

@property (nonatomic,strong) NSString *IconImage;


@end

@implementation ExcellentViewController
#pragma mark - 生命周期
-(void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self createViewControllers];
    
    _currentpage = -1;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createscrollview];
    
    [self downloaddata];
    
    [self createFocusView];

    [self createTableView];
    
    [self addRefresh];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.collectionview1 selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    });
}

#pragma mark - 创建底层scrollview
- (void)createscrollview{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _sv = [[UIScrollView alloc] initWithFrame:self.view.frame];
    
    [self.view addSubview:_sv];
//    _sv.bounces = NO;
    _sv.backgroundColor = [UIColor whiteColor];
    _sv.delegate = self;
    //4.是否显示水平滚动条  默认是yes显示
    _sv.showsVerticalScrollIndicator = NO;
    
    CGSize contensize = CGSizeMake(self.view.frame.size.width, 999);
    
    _sv.contentSize = contensize;
    
}

#pragma mark - scrollview的代理方法
//当滚动或拖曳时执行的方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (_sv == scrollView) {
        [self.view viewWithTag:100].alpha = 1.0*_sv.contentOffset.y/0;
        
    }
    
    if (scrollView.tag == TAG_SCROLL) {
        
        int page = scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width;
        
        _currentindex = page;
        
        [self.collectionview1 selectItemAtIndexPath:[NSIndexPath indexPathForRow:_currentindex inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
        
        [self.collectionview1 reloadData];
        
        [self loadData];
    }
    
    
}

-(void)createFocusView{
    
    _FocusView = [[UIView alloc]initWithFrame:self.view.frame];
    _FocusView.backgroundColor = [UIColor cyanColor];
    
    _FocusView.hidden = YES;
    [self.view addSubview:_FocusView];
}

#pragma mark
-(void)navigationItemSetting{
    
    UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 35, 35)];
    [leftBtn setImage:[UIImage imageNamed:@"follow_add_friend"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(lefClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 35, 35)];
    [rightBtn setImage:[UIImage imageNamed:@"navi_search_b"] forState:UIControlStateNormal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    [rightBtn addTarget:self action:@selector(RightClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    UISegmentedControl *segmentController = [[UISegmentedControl alloc]initWithItems:@[@"  热门",@"关注  "]];
    segmentController.tintColor = CustomColor;
    segmentController.selectedSegmentIndex = 0;
    segmentController.layer.cornerRadius = segmentController.frame.size.height/2;
    segmentController.layer.masksToBounds = YES;
    segmentController.layer.borderWidth = 1.0;
    segmentController.layer.borderColor = [CustomColor CGColor];
    
    [segmentController addTarget:self action:@selector(segmentValuechanged:) forControlEvents:UIControlEventValueChanged];
    
    self.navigationItem.titleView = segmentController;
    
    [self createCollectionview];
    
}

-(void)addRefresh{
    
    //添加上拉加载(从当前显示的数据的下一页开始请求更多的数据，来显示)
    //当你拖拽tableview，让tableview的y值超过tableview的contentsize高度的时候，会调用block代码段，但是如果已经调用，下次想要再次调用这个代码块，必须是在上次刷新结束或者停止后才能继续来调用
    
    self.tuijian.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{

        [self downloaddata];
    }];
    
    self.caizhuang.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self downloaddata];
    }];
    
}

-(void)downloaddata{
    __weak ExcellentViewController *weakSelf = self;

    [categoriesModel requestcategory:nil callBack:^(NSArray *categoriesArr, NSArray *IdArray, NSError *error) {

        NSMutableArray *IDarray = [[NSMutableArray alloc]init];
        
        if (!error) {
            [weakSelf.category_element_all addObjectsFromArray:categoriesArr];
            
            for (int i = 0; i < IdArray.count; i++) {
                if (i == 0) {
            
                    IDarray[0] = IdArray[0];
                    
                }else{
                    
                    NSString *Id = [NSString stringWithFormat:@"%@/courses?",IdArray[i]];
                    [IDarray addObject:Id];
                    
                }
                
            }
            for (int i = 0; i < IdArray.count; i++) {
                
                if (i == 0) {
                    
                    self.IDARR[0] = IDarray[0];
                    
                }else{
                    
                    NSString *Id = [NSString stringWithFormat:@"http://course2.jaxus.cn/api/v2/recommendation/hotCategory/%@",IDarray[i]];
                    [self.IDARR addObject:Id];
                    
                }
                               
            }
            
            [weakSelf createCollectionview];
            [weakSelf loadData];
        }
        
    }];
    
}

-(void)loadData{
    __weak ExcellentViewController *weakSelf = self;
    
    [ExcellentModel requestTuijian:weakSelf.IDARR[_currentindex] page:_currentpage callBack:^(NSArray *ExcellentArray, NSInteger totalCount, NSError *error) {
        if (_currentindex == 0) {
            
            [weakSelf.tuijianarray addObjectsFromArray:ExcellentArray];
            weakSelf.totalCount = totalCount;
            [_tuijian reloadData];
            
        }else if (_currentindex == 1){
            
            [weakSelf.caizhuangarray addObjectsFromArray:ExcellentArray];
            weakSelf.totalCount = totalCount;
            [_caizhuang reloadData];
            
        }else if (_currentindex == 2){
            
            [weakSelf.shougongarray addObjectsFromArray:ExcellentArray];
            weakSelf.totalCount = totalCount;
            [_shougong reloadData];
            
        }else if (_currentindex == 3){
            
            [weakSelf.hufuarray addObjectsFromArray:ExcellentArray];
            weakSelf.totalCount = totalCount;
            [_hufu reloadData];
            
        }else if (_currentindex == 4){
            
            [weakSelf.faxingarray addObjectsFromArray:ExcellentArray];
            weakSelf.totalCount = totalCount;
            [_faxing reloadData];
            
        }else if (_currentindex == 5){
            
            [weakSelf.yangshengarray addObjectsFromArray:ExcellentArray];
            weakSelf.totalCount = totalCount;
            [_yangsheng reloadData];
            
        }else if (_currentindex == 6){
            
            [weakSelf.jianshenarray addObjectsFromArray:ExcellentArray];
            weakSelf.totalCount = totalCount;
            [_jianshen reloadData];
            
        }else if (_currentindex == 7){
            
            [weakSelf.paizhaoarray addObjectsFromArray:ExcellentArray];
            weakSelf.totalCount = totalCount;
            [_paizhao reloadData];
            
        }else if (_currentindex == 8){
            
            [weakSelf.fushiarray addObjectsFromArray:ExcellentArray];
            weakSelf.totalCount = totalCount;
            [_fushi reloadData];
            
            
        }else if (_currentindex == 9){
            [weakSelf.jiachangcaiarray addObjectsFromArray:ExcellentArray];
            weakSelf.totalCount = totalCount;
            [_jiachangcai reloadData];
            
        }else if (_currentindex == 10){
            
            [weakSelf.hongbeiarray addObjectsFromArray:ExcellentArray];
            weakSelf.totalCount = totalCount;
            [_hongbei reloadData];
            
        }
        
    }];
}

-(void)createCollectionview{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    self.collectionview1 = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64,Screen.width , 30) collectionViewLayout:layout];
    self.collectionview1.backgroundColor = [UIColor whiteColor];
    layout.itemSize = CGSizeMake(Screen.width / 5, 30);
    
    //设置滚动方向
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    //每行之间最小的距离
    layout.minimumInteritemSpacing = 1;
    layout.minimumLineSpacing = 1;
    
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    self.collectionview1.dataSource = self;
    self.collectionview1.delegate = self;
    self.collectionview1.showsHorizontalScrollIndicator = NO;
    
    //注册collectioncell
    [self.collectionview1 registerNib:[UINib nibWithNibName:@"CYTCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CYTCollectionViewCell"];
    
    [_sv addSubview:self.collectionview1];
    
}

#pragma mark - collectionview的代理方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.category_element_all.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CYTCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CYTCollectionViewCell" forIndexPath:indexPath];
    if (_currentindex == indexPath.row) {
        cell.slideView.hidden = NO;
        cell.TitleLabel.textColor = [UIColor blackColor];
        cell.TitleLabel.font = [UIFont systemFontOfSize:15];
        cell.slideView.backgroundColor = CustomColor;
    }else{
        cell.slideView.hidden = YES;
        cell.TitleLabel.textColor = [UIColor grayColor];
        cell.TitleLabel.font = [UIFont systemFontOfSize:13];
        cell.TitleLabel.hidden = NO;
    }
    if (indexPath.item == 0) {
        cell.TitleLabel.text = self.category_element_all[indexPath.item][@"title"];
    }else{
        categoriesModel *model = self.category_element_all[indexPath.item];
        cell.TitleLabel.text = model.title;
    }
    
    return cell;
}

//选中每个cell的时候调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UIScrollView *sc = (UIScrollView *)[self.view viewWithTag:TAG_SCROLL];
    sc.contentOffset = CGPointMake(indexPath.row * Screen.width, 0);
    
    [collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
    
    _currentindex = indexPath.row;

}

#pragma mark - 创建11项tableview
-(void)createTableView {
    
    UIScrollView *sc = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64 + 30, Screen.width, Screen.height - 64 - 49 - 30)];
    
    sc.tag = TAG_SCROLL;
    [_sv addSubview:sc];
    sc.contentSize = CGSizeMake(Screen.width * 11, Screen.height);
    sc.pagingEnabled = YES;
    sc.showsHorizontalScrollIndicator = NO;
    sc.delegate = self;
    
    for (int i = 0; i < 11; i++) {
        
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(sc.bounds.size.width * i, 0, sc.bounds.size.width, sc.bounds.size.height)style:UITableViewStylePlain];
        tableView.tag = TAG_11TABLEVIEW + i;
        tableView.bounces = NO;
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.rowHeight = 280;
        [tableView registerNib:[UINib nibWithNibName:@"ExcellentCell" bundle:nil] forCellReuseIdentifier:@"ExcellentCell"];
        
        if (i == 0) {
            
            self.tuijian = tableView;
            
        }else if (i == 1){
            
            self.caizhuang = tableView;
            
        }else if (i == 2){
            
            self.shougong = tableView;
            
        }else if (i == 3){
            
            self.hufu = tableView;
            
        }else if (i == 4){
            
            self.faxing = tableView;
            
        }else if (i == 5){
            
            self.yangsheng = tableView;
            
        }else if (i == 6){
            
            self.jianshen = tableView;
            
        }else if (i == 7){
            
            self.paizhao = tableView;
            
        }else if (i == 8){
            
            self.fushi = tableView;
            
        }else if (i == 9){
            
            self.jiachangcai = tableView;
            
        }else if (i == 10){
            
            self.hongbei = tableView;
            
        }
        [sc addSubview:tableView];
    }
}


- (void)segmentValuechanged:(UISegmentedControl *)segment{
    
    if (segment.selectedSegmentIndex == 0) {
        self.FocusView.hidden = YES;
    }else{
        self.FocusView.hidden = NO;
    }
    
}

-(void)lefClick:(UIButton *)btn{
    
    SearchUserController *seach = [[SearchUserController alloc]init];
    [self.view.window addTransitionAnimationWithDuration:1.0 andType:TransitionRippleEffect andSubTupe:From_RIGHT];
    seach.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:seach animated:YES];
}

-(void)RightClick:(UIButton *)btn{
    
    SearchThingController *searchTh = [[SearchThingController alloc]init];
    [self.view.window addTransitionAnimationWithDuration:0.5 andType:TransitionPageUnCurl andSubTupe:From_RIGHT];
    searchTh.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchTh animated:YES];
}

-(void)createViewControllers{

    UIViewController *oneViewController = [[UIViewController alloc] init];
    oneViewController.title = @"推荐";
    oneViewController.view.backgroundColor = RandomColor;
    
    
    UIViewController *twoViewController = [[UIViewController alloc] init];
    twoViewController.title = @"彩妆";
    twoViewController.view.backgroundColor = RandomColor;
    
    UIViewController *threeViewController = [[UIViewController alloc] init];
    threeViewController.title = @"手工";
    threeViewController.view.backgroundColor = RandomColor;
    
    UIViewController *fourViewController = [[UIViewController alloc] init];
    fourViewController.title = @"护肤";
    fourViewController.view.backgroundColor = RandomColor;
    
    UIViewController *fiveViewController = [[UIViewController alloc] init];
    fiveViewController.title = @"发型";
    fiveViewController.view.backgroundColor = RandomColor;
    
    UIViewController *sixViewController = [[UIViewController alloc] init];
    sixViewController.title = @"养生";
    sixViewController.view.backgroundColor = [UIColor cyanColor];
    
    UIViewController *sevenViewController = [[UIViewController alloc] init];
    sevenViewController.title = @"健身";
    sevenViewController.view.backgroundColor = [UIColor blueColor];
    
    UIViewController *eightViewController = [[UIViewController alloc] init];
    eightViewController.title = @"拍照";
    eightViewController.view.backgroundColor = [UIColor greenColor];
    
    UIViewController *ninghtViewController = [[UIViewController alloc] init];
    ninghtViewController.title = @"服饰";
    ninghtViewController.view.backgroundColor = [UIColor redColor];
    
    UIViewController *tenViewController = [[UIViewController alloc] init];
    tenViewController.title = @"家常菜";
    tenViewController.view.backgroundColor = [UIColor greenColor];
    
    UIViewController *eleViewController = [[UIViewController alloc] init];
    eleViewController.title = @"烘焙";
    eleViewController.view.backgroundColor = [UIColor redColor];
    
    SCNavTabBarController *navTabBarController = [[SCNavTabBarController alloc] init];
    navTabBarController.subViewControllers = @[oneViewController, twoViewController, threeViewController, fourViewController, fiveViewController, sixViewController, sevenViewController, eightViewController, ninghtViewController,tenViewController,eleViewController];
    navTabBarController.showArrowButton = YES;
    [navTabBarController addParentController:self];
    
}

#pragma mark - tableview的协议方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView == self.tuijian) {
        
        return self.tuijianarray.count;
        
    }else if (tableView == self.caizhuang){
        
        return self.caizhuangarray.count;
        
    }else if (tableView == self.shougong){
        
        return self.shougongarray.count;
        
    }else if (tableView == self.hufu){
        
        return self.hufuarray.count;
        
    }else if (tableView == self.faxing){
        
        return self.faxingarray.count;
        
    }else if (tableView == self.yangsheng){
        
        return self.yangshengarray.count;
        
    }else if (tableView == self.jianshen){
        
        return self.jianshenarray.count;
        
    }else if (tableView == self.paizhao){
        
        return self.paizhaoarray.count;
        
    }else if (tableView == self.fushi){
        
        return self.fushiarray.count;
        
    }else if (tableView == self.jiachangcai){
        
        return self.jiachangcaiarray.count;
        
    }else if (tableView == self.hongbei){
        
        return self.hongbeiarray.count;
    }
    return 0;
}

#pragma mark cell的加载动画
-(void)addanimation:(UITableViewCell *)cell{
    
        cell.layer.transform = CATransform3DMakeScale(1, 0.6, 1);
    
        [UIView animateWithDuration:0.4 animations:^{
            
            cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
            
        }];

}

#pragma mark Cell的加载
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ExcellentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ExcellentCell" forIndexPath:indexPath];
//    [self addanimation:cell];
    
    UIImage *backImg = [UIImage imageNamed:@"placeholderImg"];
    
    if (tableView == self.tuijian) {
        
        ExcellentModel *Model = self.tuijianarray[indexPath.row];
        
        cell.repostNumLb.text = [NSString stringWithFormat:@"%ld",(long)Model.repostNum];
        cell.titleLb.text = Model.title;
        [cell.coverImageV sd_setImageWithURL:[NSURL URLWithString:Model.cover[@"imgUrl"]]placeholderImage:[UIImage imageNamed:@"placeholderImg"]];
        [cell.userIcon sd_setImageWithURL:[NSURL URLWithString:Model.user[@"avatarUrl"]]];
        cell.userName.text = Model.user[@"username"];
        return cell;
        
    }else if (tableView == self.caizhuang){
        
        ExcellentModel *Model = self.caizhuangarray[indexPath.row];
        
        cell.repostNumLb.text = [NSString stringWithFormat:@"%ld",(long)Model.repostNum];
        cell.titleLb.text = Model.title;
        [cell.coverImageV sd_setImageWithURL:[NSURL URLWithString:Model.cover[@"imgUrl"]]];
        [cell.userIcon sd_setImageWithURL:[NSURL URLWithString:Model.user[@"avatarUrl"]]];
        cell.userName.text = Model.user[@"username"];
        
        return cell;
        
    }else if (tableView == self.shougong){
        
        ExcellentModel *Model = self.shougongarray[indexPath.row];
        
        cell.repostNumLb.text = [NSString stringWithFormat:@"%ld",(long)Model.repostNum];
        cell.titleLb.text = Model.title;
        [cell.coverImageV sd_setImageWithURL:[NSURL URLWithString:Model.cover[@"imgUrl"]]];
        [cell.userIcon sd_setImageWithURL:[NSURL URLWithString:Model.user[@"avatarUrl"]]];
        cell.userName.text = Model.user[@"username"];
        
        return cell;
        
    }else if (tableView == self.hufu){
        
        ExcellentModel *Model = self.hufuarray[indexPath.row];
        
        cell.repostNumLb.text = [NSString stringWithFormat:@"%ld",(long)Model.repostNum];
        cell.titleLb.text = Model.title;
        [cell.coverImageV sd_setImageWithURL:[NSURL URLWithString:Model.cover[@"imgUrl"]]];
        [cell.userIcon sd_setImageWithURL:[NSURL URLWithString:Model.user[@"avatarUrl"]]];
        cell.userName.text = Model.user[@"username"];
        return cell;
        
    }else if (tableView == self.faxing){
        
        ExcellentModel *Model = self.faxingarray[indexPath.row];
        
        cell.repostNumLb.text = [NSString stringWithFormat:@"%ld",(long)Model.repostNum];
        cell.titleLb.text = Model.title;
        [cell.coverImageV sd_setImageWithURL:[NSURL URLWithString:Model.cover[@"imgUrl"]]];
        [cell.userIcon sd_setImageWithURL:[NSURL URLWithString:Model.user[@"avatarUrl"]]];
        cell.userName.text = Model.user[@"username"];
        return cell;
        
    }else if (tableView == self.yangsheng){
        
        ExcellentModel *Model = self.yangshengarray[indexPath.row];
        
        cell.repostNumLb.text = [NSString stringWithFormat:@"%ld",(long)Model.repostNum];
        cell.titleLb.text = Model.title;
        [cell.coverImageV sd_setImageWithURL:[NSURL URLWithString:Model.cover[@"imgUrl"]]];
        [cell.userIcon sd_setImageWithURL:[NSURL URLWithString:Model.user[@"avatarUrl"]]];
        cell.userName.text = Model.user[@"username"];
        return cell;
        
    }else if (tableView == self.jianshen){
        
        ExcellentModel *Model = self.jianshenarray[indexPath.row];
        
        cell.repostNumLb.text = [NSString stringWithFormat:@"%ld",(long)Model.repostNum];
        cell.titleLb.text = Model.title;
        [cell.coverImageV sd_setImageWithURL:[NSURL URLWithString:Model.cover[@"imgUrl"]]];
        [cell.userIcon sd_setImageWithURL:[NSURL URLWithString:Model.user[@"avatarUrl"]]];
        cell.userName.text = Model.user[@"username"];
        return cell;
        
    }else if (tableView == self.paizhao){
        
        ExcellentModel *Model = self.paizhaoarray[indexPath.row];
        
        cell.repostNumLb.text = [NSString stringWithFormat:@"%ld",(long)Model.repostNum];
        cell.titleLb.text = Model.title;
        [cell.coverImageV sd_setImageWithURL:[NSURL URLWithString:Model.cover[@"imgUrl"]]];
        [cell.userIcon sd_setImageWithURL:[NSURL URLWithString:Model.user[@"avatarUrl"]]];
        cell.userName.text = Model.user[@"username"];
        return cell;
        
    }else if (tableView == self.fushi){
        
        ExcellentModel *Model = self.fushiarray[indexPath.row];
        
        cell.repostNumLb.text = [NSString stringWithFormat:@"%ld",(long)Model.repostNum];
        cell.titleLb.text = Model.title;
        [cell.coverImageV sd_setImageWithURL:[NSURL URLWithString:Model.cover[@"imgUrl"]]];
        [cell.userIcon sd_setImageWithURL:[NSURL URLWithString:Model.user[@"avatarUrl"]]];
        cell.userName.text = Model.user[@"username"];
        return cell;
        
    }else if (tableView == self.jiachangcai){
        
        ExcellentModel *Model = self.jiachangcaiarray[indexPath.row];
        
        cell.repostNumLb.text = [NSString stringWithFormat:@"%ld",(long)Model.repostNum];
        cell.titleLb.text = Model.title;
        [cell.coverImageV sd_setImageWithURL:[NSURL URLWithString:Model.cover[@"imgUrl"]]];
        [cell.userIcon sd_setImageWithURL:[NSURL URLWithString:Model.user[@"avatarUrl"]]];
        cell.userName.text = Model.user[@"username"];
        return cell;
        
    }else if (tableView == self.hongbei){
        
        ExcellentModel *Model = self.hongbeiarray[indexPath.row];
        
        cell.repostNumLb.text = [NSString stringWithFormat:@"%ld",(long)Model.repostNum];
        cell.titleLb.text = Model.title;
        [cell.coverImageV sd_setImageWithURL:[NSURL URLWithString:Model.cover[@"imgUrl"]]];
        [cell.userIcon sd_setImageWithURL:[NSURL URLWithString:Model.user[@"avatarUrl"]]];
        cell.userName.text = Model.user[@"username"];
        return cell;
    }
    return cell;
}

#pragma mark 懒加载
-(NSMutableArray *)dataArr{
    
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc]init];
    }
    return _dataArr;
}

-(NSMutableArray *)category_element_all{
    if (_category_element_all == nil) {
        _category_element_all = [[NSMutableArray alloc]init];
        [_category_element_all addObject:@{@"title":@"推荐"}];
    }
    return _category_element_all;
}

-(NSMutableArray *)IDARR{
    if (_IDARR == nil) {
        _IDARR = [[NSMutableArray alloc]init];
    }
    return _IDARR;
}

- (NSMutableArray *)tuijianarray{
    
    if (_tuijianarray == nil) {
        _tuijianarray = [[NSMutableArray alloc] init];
    }
    
    return _tuijianarray;
}

- (NSMutableArray *)caizhuangarray{
    
    if (_caizhuangarray == nil) {
        _caizhuangarray = [[NSMutableArray alloc] init];
    }
    return _caizhuangarray;
    
}

- (NSMutableArray *)shougongarray{
    
    if (_shougongarray == nil) {
        _shougongarray = [[NSMutableArray alloc] init];
    }
    
    return _shougongarray;
}

- (NSMutableArray *)hufuarray{
    
    if (_hufuarray == nil) {
        _hufuarray = [[NSMutableArray alloc] init];
    }
    return _hufuarray;
}

- (NSMutableArray *)faxingarray{
    
    if (_faxingarray ==nil) {
        _faxingarray = [[NSMutableArray alloc] init];
    }
    return _faxingarray;
    
}

- (NSMutableArray *)yangshengarray{
    
    if (_yangshengarray ==nil) {
        _yangshengarray= [[NSMutableArray alloc] init];
    }
    return _yangshengarray;
    
}

- (NSMutableArray *)jianshenarray{
    
    if (_jianshenarray ==nil) {
        _jianshenarray = [[NSMutableArray alloc] init];
    }
    return _jianshenarray;
    
}

- (NSMutableArray *)paizhaoarray{
    
    if (_paizhaoarray ==nil) {
        _paizhaoarray = [[NSMutableArray alloc] init];
    }
    return _paizhaoarray;
    
}

- (NSMutableArray *)fushiarray{
    
    if (_fushiarray ==nil) {
        _fushiarray = [[NSMutableArray alloc] init];
    }
    return _fushiarray;
    
}

-(NSMutableArray *)jiachangcai{
    if (_jiachangcaiarray) {
        _jiachangcaiarray = [[NSMutableArray alloc]init];
    }
    return _jiachangcaiarray;
}

- (NSMutableArray *)hongbeiarray{
    
    if (_hongbeiarray ==nil) {
        _hongbeiarray = [[NSMutableArray alloc] init];
    }
    return _hongbeiarray;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//基于viewcontroller设置的
- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
    
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
