//
//  MainTabController.m
//  ExcellentStudy
//
//  Created by Sunshine on 16/3/14.
//  Copyright © 2016年 Sunshine丶天. All rights reserved.
//

#import "MainTabController.h"

#import "ExcellentViewController.h" //优学
#import "FoundViewController.h"     //发现
#import "AddViewController.h"       //加号
#import "GoodThingViewController.h" //好物
#import "MineViewController.h"      //我的

#import "AppHeader.h"

@interface MainTabController ()

@end

@implementation MainTabController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createViewController];
}

-(void)createViewController{
    
    //创建4个视图控制器
    ExcellentViewController *excellent = [[ExcellentViewController alloc]init];
    FoundViewController *found = [[FoundViewController alloc]init];
    AddViewController *add = [[AddViewController alloc]init];
    GoodThingViewController *goodThing = [[GoodThingViewController alloc]init];
    MineViewController *mine = [[MineViewController alloc]init];
    
    //创建4个导航控制器,分别容纳4个视图控制器
    UINavigationController *nav1 = [[UINavigationController alloc]initWithRootViewController:excellent];
    UINavigationController *nav2 = [[UINavigationController alloc]initWithRootViewController:found];
    UINavigationController *nav3 = [[UINavigationController alloc]initWithRootViewController:add];
    UINavigationController *nav4 = [[UINavigationController alloc]initWithRootViewController:goodThing];
    UINavigationController *nav5 = [[UINavigationController alloc]initWithRootViewController:mine];
    
    NSArray *ViewControllers = @[nav1,nav2,nav3,nav4,nav5];
    self.viewControllers = ViewControllers;
    
    [self tabBarItemSetting];
    
    for (UIView *lineView in self.tabBarController.tabBar.subviews) {
        
        if ([lineView isKindOfClass:[UIImageView class]] && lineView.bounds.size.height <= 1) {
            
            UIImageView *lineImage = (UIImageView *)lineView;
            //            //更改线的颜色
            //            lineImage.backgroundColor = [UIColor redColor];
            //隐藏
            lineImage.hidden = YES;
        }
        
    }
}

-(void)tabBarItemSetting{
    
    NSArray *titleArr = @[@"优学",@"发现",@"",@"好物",@"我的"];
    NSInteger i = 0;
    NSArray *imagesTitle = @[@"home_home_normal~iphone",@"home_discover_normal~iphone",@"home_public_normal~iphone",@"home_niceitem_normal~iphone",@"home_personal_normal~iphone"];
    NSArray *imageSelTiele = @[@"home_home_press~iphone",@"home_discover_press~iphone",@"home_public_press~iphone",@"home_niceitem_press~iphone",@"home_personal_press~iphone"];
    for (UINavigationController *nav in self.viewControllers) {
        
        UIImage *image = [[UIImage imageNamed:imagesTitle[i]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *simage = [[UIImage imageNamed:imageSelTiele[i]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UITabBarItem *item = [[UITabBarItem alloc]initWithTitle:titleArr[i] image:image selectedImage:simage];
        item.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
        nav.tabBarItem = item;
        i++;
        nav.navigationBar.barTintColor = [UIColor whiteColor];
        [[UIBarButtonItem appearance]setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
        nav.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor blackColor]};
        //title  或  item 镂空部分的颜色
        nav.navigationBar.tintColor = [UIColor whiteColor];

    }
    self.tabBar.tintColor = CustomColor;
    
    
    
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
